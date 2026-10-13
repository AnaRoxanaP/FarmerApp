import { useEffect, useState } from 'react';
import type { ReactNode } from 'react';
import {
  ActivityIndicator,
  Alert,
  KeyboardAvoidingView,
  Modal,
  Platform,
  Pressable,
  ScrollView,
  StyleSheet,
  Text,
  TextInput,
  View,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import {
  ArrowDownLeft,
  ArrowRight,
  Baby,
  Bell,
  Check,
  ChevronRight,
  HeartPulse,
  Leaf,
  Plus,
  Search,
  Sparkles,
  Syringe,
  X,
} from 'lucide-react-native';
import { StatusBar as ExpoStatusBar } from 'expo-status-bar';
import type { Activity, Lambing, Sheep as SheepRecord, SheepSex, Treatment } from './src/types';
import {
  getAnimalHistory,
  initializeDatabase,
  listLambings,
  listSheep,
  listTreatments,
  saveLambing,
  saveSheep,
  saveTreatment,
} from './src/database';
import { scheduleTreatmentReminder } from './src/notifications';

type TabKey = 'turma' | 'fatarI' | 'tratamente';
type FormKey = 'sheep' | 'lambing' | 'treatment' | null;

const COLORS = {
  ink: '#18352B',
  forest: '#24513F',
  leaf: '#3E7657',
  mint: '#E8F1E8',
  cream: '#F6F4EB',
  paper: '#FFFDF7',
  line: '#E7E5D9',
  muted: '#758078',
  gold: '#E9B94E',
  goldWash: '#FAF0D6',
  coral: '#D96D54',
  coralWash: '#F9E9E3',
  blue: '#4A8290',
  blueWash: '#E5F0F1',
};

const today = () => new Date().toISOString().slice(0, 10);
const dateLabel = (value: string) => {
  const date = new Date(`${value}T12:00:00`);
  return Number.isNaN(date.getTime()) ? value : new Intl.DateTimeFormat('ro-RO', { day: 'numeric', month: 'short', year: 'numeric' }).format(date);
};

function matchesSearch(query: string, fields: string[], tagNumber: string): boolean {
  const normalizedQuery = query.trim().toLocaleLowerCase('ro');
  if (!normalizedQuery) return true;
  if (fields.some((field) => field.toLocaleLowerCase('ro').includes(normalizedQuery)) || tagNumber.toLocaleLowerCase('ro').includes(normalizedQuery)) return true;

  const queryDigits = normalizedQuery.replace(/\D/g, '');
  const tagDigits = tagNumber.replace(/\D/g, '');
  return queryDigits.length >= 3 && tagDigits.endsWith(queryDigits);
}

export default function App() {
  const [tab, setTab] = useState<TabKey>('turma');
  const [form, setForm] = useState<FormKey>(null);
  const [sheep, setSheep] = useState<SheepRecord[]>([]);
  const [lambings, setLambings] = useState<Lambing[]>([]);
  const [treatments, setTreatments] = useState<Treatment[]>([]);
  const [selected, setSelected] = useState<SheepRecord | null>(null);
  const [history, setHistory] = useState<Activity[]>([]);
  const [query, setQuery] = useState('');
  const [lambQuery, setLambQuery] = useState('');
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [loadError, setLoadError] = useState('');

  async function refreshData() {
    const [sheepRows, lambingRows, treatmentRows] = await Promise.all([listSheep(), listLambings(), listTreatments()]);
    setSheep(sheepRows);
    setLambings(lambingRows);
    setTreatments(treatmentRows);
  }

  useEffect(() => {
    async function bootstrap() {
      try {
        await initializeDatabase();
        await refreshData();
      } catch {
        setLoadError('Nu am putut deschide baza de date. Încearcă să repornești aplicația.');
      } finally {
        setLoading(false);
      }
    }
    void bootstrap();
  }, []);

  useEffect(() => {
    if (selected) {
      void getAnimalHistory(selected.id).then(setHistory).catch(() => setHistory([]));
    } else {
      setHistory([]);
    }
  }, [selected]);

  function openForm(next: Exclude<FormKey, null>) {
    if (next !== 'sheep' && sheep.length === 0) {
      Alert.alert('Mai întâi adaugă o oaie', 'Înregistrează primul animal, apoi vei putea adăuga fătări și tratamente.');
      return;
    }
    if (next === 'lambing' && !sheep.some((animal) => animal.sex === 'Femelă')) {
      Alert.alert('Nu există o mamă în turmă', 'Adaugă sau verifică o oaie de sex feminin înainte de a înregistra o fătare.');
      return;
    }
    setForm(next);
  }

  async function completeSave(action: () => Promise<void>) {
    setSaving(true);
    try {
      await action();
      await refreshData();
      setForm(null);
    } catch (error) {
      const message = error instanceof Error && error.message.toLowerCase().includes('unique')
        ? 'Acest număr de crotaliu este deja folosit.'
        : 'Nu am putut salva datele. Verifică informațiile și încearcă din nou.';
      Alert.alert('Salvarea nu a reușit', message);
    } finally {
      setSaving(false);
    }
  }

  if (loading) {
    return <View style={styles.loading}><ActivityIndicator size="large" color={COLORS.leaf} /><Text style={styles.loadingText}>Pregătim stâna…</Text></View>;
  }

  if (loadError) {
    return <View style={styles.loading}><Text style={styles.errorTitle}>Nu s-a deschis aplicația</Text><Text style={styles.loadingText}>{loadError}</Text></View>;
  }

  const upcoming = treatments.filter((item) => item.reminderAt && item.reminderAt >= today());
  const filteredSheep = sheep.filter((animal) => matchesSearch(query, [animal.name, animal.breed], animal.tagNumber));
  const filteredLambings = lambings.filter((item) => matchesSearch(lambQuery, [item.lambName, item.breed, item.motherName ?? ''], item.tagNumber));

  return (
    <SafeAreaView style={styles.safeArea} edges={['top', 'left', 'right']}>
      <ExpoStatusBar style="dark" />
      <View style={styles.appShell}>
        <View style={styles.topBar}>
          <View style={styles.brandMark}><Leaf size={18} color={COLORS.paper} strokeWidth={2.4} /></View>
          <View style={styles.brandTextWrap}><Text style={styles.brandTitle}>Stâna noastră</Text><Text style={styles.brandCaption}>GOSPODĂRIA, CU GRIJĂ</Text></View>
          <View style={styles.topCount}><Text style={styles.topCountNumber}>{sheep.length}</Text><Text style={styles.topCountLabel}>oi</Text></View>
        </View>

        <ScrollView style={styles.page} contentContainerStyle={styles.pageContent} showsVerticalScrollIndicator={false} keyboardShouldPersistTaps="handled">
          {tab === 'turma' && (
            <>
              <View style={styles.welcomeBlock}>
                <Text style={styles.eyebrow}>EVIDENȚA TURMEI</Text>
                <Text style={styles.pageTitle}>Bună, oameni harnici.</Text>
                <Text style={styles.pageSubtitle}>Tot ce-i important pentru oile voastre, la un loc.</Text>
              </View>
              <View style={styles.summaryRow}>
                <SummaryTile icon={<Baby size={18} color={COLORS.leaf} />} value={`${sheep.length}`} label="în turmă" tone="green" />
                <SummaryTile icon={<Sparkles size={18} color="#B5831D" />} value={`${lambings.length}`} label="fătări" tone="gold" />
                <SummaryTile icon={<Bell size={18} color={COLORS.coral} />} value={`${upcoming.length}`} label="reamintiri" tone="coral" />
              </View>
              {upcoming.length > 0 && <ReminderStrip item={upcoming[0]} onPress={() => setTab('tratamente')} />}
              <View style={styles.sectionHeading}>
                <View><Text style={styles.sectionTitle}>Turma mea</Text><Text style={styles.sectionCaption}>{sheep.length === 1 ? '1 animal în evidență' : `${sheep.length} animale în evidență`}</Text></View>
                <Pressable style={styles.textAction} onPress={() => setTab('tratamente')}><Text style={styles.textActionLabel}>Tratamente</Text><ChevronRight size={15} color={COLORS.leaf} /></Pressable>
              </View>
              <View style={styles.searchBar}><Search size={17} color={COLORS.muted} /><TextInput value={query} onChangeText={setQuery} placeholder="Nume, rasă sau ultimele 3 cifre" placeholderTextColor="#9AA29B" style={styles.searchInput} /></View>
              {filteredSheep.length ? filteredSheep.map((animal) => <SheepRow key={animal.id} animal={animal} onPress={() => setSelected(animal)} />) : <EmptyState title="Nu am găsit oaia" detail="Încearcă numele, rasa sau ultimele cifre ale crotaliului." />}
            </>
          )}

          {tab === 'fatarI' && (
            <>
              <View style={styles.welcomeBlock}>
                <Text style={styles.eyebrow}>JURNALUL MIEILOR</Text>
                <Text style={styles.pageTitle}>Fătări</Text>
                <Text style={styles.pageSubtitle}>Mamele, mieii și datele lor, păstrate la un loc.</Text>
              </View>
              <View style={styles.lambingSummary}><Baby size={23} color={COLORS.forest} /><Text style={styles.lambingSummaryText}><Text style={styles.lambingSummaryStrong}>{lambings.length}</Text> {lambings.length === 1 ? 'fătare înregistrată' : 'fătări înregistrate'}</Text><Sparkles size={16} color="#B5831D" /></View>
              <View style={styles.sectionHeading}><View><Text style={styles.sectionTitle}>Registrul fătărilor</Text><Text style={styles.sectionCaption}>Cele mai recente, primele</Text></View></View>
              <View style={styles.searchBar}><Search size={17} color={COLORS.muted} /><TextInput value={lambQuery} onChangeText={setLambQuery} placeholder="Caută miel după nume, rasă sau crotaliu" placeholderTextColor="#9AA29B" style={styles.searchInput} /></View>
              {filteredLambings.length ? filteredLambings.map((item) => <LambingRow key={item.id} item={item} onMother={() => { const mother = sheep.find((animal) => animal.id === item.motherId); if (mother) setSelected(mother); }} />) : <EmptyState title={lambings.length ? 'Nu am găsit mielul' : 'Încă nu sunt fătări'} detail={lambings.length ? 'Încearcă numele, rasa sau ultimele cifre ale crotaliului mielului.' : 'Adaugă prima fătare cu butonul de mai jos.'} />}
              <View style={{ height: 22 }} />
            </>
          )}

          {tab === 'tratamente' && (
            <>
              <View style={styles.welcomeBlock}>
                <Text style={styles.eyebrow}>SĂNĂTATEA TURMEI</Text>
                <Text style={styles.pageTitle}>Tratamente</Text>
                <Text style={styles.pageSubtitle}>Ce s-a administrat și ce urmează refăcut.</Text>
              </View>
              {upcoming.length > 0 && <View style={styles.nextTreatment}><View style={styles.nextIcon}><Bell size={18} color={COLORS.coral} /></View><View style={{ flex: 1 }}><Text style={styles.nextEyebrow}>URMĂTOAREA REAMINTIRE</Text><Text style={styles.nextName}>{upcoming[0].name}</Text><Text style={styles.nextDetail}>{upcoming[0].sheepName} · {dateLabel(upcoming[0].reminderAt!)}</Text></View><ArrowRight size={18} color={COLORS.coral} /></View>}
              <View style={styles.sectionHeading}><View><Text style={styles.sectionTitle}>Istoric tratamente</Text><Text style={styles.sectionCaption}>{treatments.length} {treatments.length === 1 ? 'înregistrare' : 'înregistrări'}</Text></View></View>
              {treatments.length ? treatments.map((item) => <TreatmentRow key={item.id} item={item} onPress={() => { const animal = sheep.find((entry) => entry.id === item.sheepId); if (animal) setSelected(animal); }} />) : <EmptyState title="Niciun tratament înregistrat" detail="Adaugă ce ai administrat, cu doză și reamintire dacă este nevoie." />}
              <View style={{ height: 22 }} />
            </>
          )}
        </ScrollView>

        <View style={styles.bottomDock}>
          <View style={styles.tabRail}>
            <TabButton active={tab === 'turma'} icon={<Baby size={19} color={tab === 'turma' ? COLORS.leaf : COLORS.muted} />} label="Turmă" onPress={() => setTab('turma')} />
            <TabButton active={tab === 'fatarI'} icon={<Sparkles size={19} color={tab === 'fatarI' ? COLORS.leaf : COLORS.muted} />} label="Fătări" onPress={() => setTab('fatarI')} />
            <TabButton active={tab === 'tratamente'} icon={<HeartPulse size={19} color={tab === 'tratamente' ? COLORS.leaf : COLORS.muted} />} label="Sănătate" onPress={() => setTab('tratamente')} />
          </View>
          <Pressable style={styles.addButton} onPress={() => openForm(tab === 'fatarI' ? 'lambing' : tab === 'tratamente' ? 'treatment' : 'sheep')} accessibilityRole="button" accessibilityLabel={tab === 'fatarI' ? 'Adaugă fătare' : tab === 'tratamente' ? 'Adaugă tratament' : 'Adaugă oaie'}>
            <Plus size={23} color={COLORS.paper} strokeWidth={2.7} /><Text style={styles.addButtonLabel}>{tab === 'fatarI' ? 'Fătare' : tab === 'tratamente' ? 'Tratament' : 'Oaie nouă'}</Text>
          </Pressable>
        </View>
      </View>

      <EntryModal visible={form !== null} form={form} sheep={sheep} saving={saving} onClose={() => setForm(null)} onSaveSheep={(input) => completeSave(() => saveSheep(input))} onSaveLambing={(input) => completeSave(() => saveLambing(input))} onSaveTreatment={async (input) => completeSave(async () => {
        const animal = sheep.find((entry) => entry.id === input.sheepId);
        const notificationId = input.reminderAt && animal ? await scheduleTreatmentReminder(animal.name, input.name, input.reminderAt) : null;
        await saveTreatment({ ...input, notificationId });
      })} />

      <AnimalModal animal={selected} history={history} onClose={() => setSelected(null)} />
    </SafeAreaView>
  );
}

function SummaryTile({ icon, value, label, tone }: { icon: ReactNode; value: string; label: string; tone: 'green' | 'gold' | 'coral' }) {
  const color = tone === 'green' ? COLORS.mint : tone === 'gold' ? COLORS.goldWash : COLORS.coralWash;
  return <View style={[styles.summaryTile, { backgroundColor: color }]}><View style={styles.summaryIcon}>{icon}</View><Text style={styles.summaryValue}>{value}</Text><Text style={styles.summaryLabel}>{label}</Text></View>;
}

function SheepRow({ animal, onPress }: { animal: SheepRecord; onPress: () => void }) {
  const female = animal.sex === 'Femelă';
  return <Pressable style={styles.sheepRow} onPress={onPress}>
    <View style={[styles.animalAvatar, { backgroundColor: female ? COLORS.mint : COLORS.blueWash }]}><Baby size={21} color={female ? COLORS.leaf : COLORS.blue} /></View>
    <View style={styles.animalInfo}><View style={styles.animalNameLine}><Text style={styles.animalName}>{animal.name}</Text><View style={[styles.sexDot, { backgroundColor: female ? COLORS.leaf : COLORS.blue }]} /></View><Text style={styles.animalMeta}>{animal.breed} · {animal.sex.toLocaleLowerCase('ro')}</Text><Text style={styles.animalTag}>Crotaliu {animal.tagNumber}</Text></View>
    <ChevronRight size={19} color="#A7AEA5" />
  </Pressable>;
}

function LambingRow({ item, onMother }: { item: Lambing; onMother: () => void }) {
  return <View style={styles.recordRow}><View style={[styles.recordIcon, { backgroundColor: COLORS.goldWash }]}><Baby size={19} color="#B5831D" /></View><View style={styles.recordMain}><View style={styles.recordTitleLine}><Text style={styles.recordTitle}>{item.lambName}</Text><Text style={styles.recordDate}>{dateLabel(item.date)}</Text></View><Text style={styles.recordDetail}>{item.breed} · {item.sex} · {item.tagNumber}</Text><Pressable onPress={onMother} style={styles.relatedLink}><ArrowDownLeft size={13} color={COLORS.leaf} /><Text style={styles.relatedText}>Mama: {item.motherName}</Text></Pressable></View></View>;
}

function TreatmentRow({ item, onPress }: { item: Treatment; onPress: () => void }) {
  return <Pressable style={styles.recordRow} onPress={onPress}><View style={[styles.recordIcon, { backgroundColor: COLORS.coralWash }]}><Syringe size={18} color={COLORS.coral} /></View><View style={styles.recordMain}><View style={styles.recordTitleLine}><Text style={styles.recordTitle}>{item.name}</Text><Text style={styles.recordDate}>{dateLabel(item.date)}</Text></View><Text style={styles.recordDetail}>{item.sheepName} · {item.dose || 'fără doză notată'}</Text>{item.notes ? <Text style={styles.recordNote}>{item.notes}</Text> : null}{item.reminderAt ? <View style={styles.relatedLink}><Bell size={13} color={COLORS.coral} /><Text style={[styles.relatedText, { color: COLORS.coral }]}>De refăcut: {dateLabel(item.reminderAt)}</Text></View> : null}</View></Pressable>;
}

function ReminderStrip({ item, onPress }: { item: Treatment; onPress: () => void }) {
  return <Pressable style={styles.reminderStrip} onPress={onPress}><View style={styles.reminderIcon}><Bell size={17} color={COLORS.coral} /></View><View style={{ flex: 1 }}><Text style={styles.reminderEyebrow}>REAMINTIRE APROPIATĂ</Text><Text style={styles.reminderTitle}>{item.name} · {item.sheepName}</Text><Text style={styles.reminderDate}>{dateLabel(item.reminderAt!)}</Text></View><ChevronRight size={18} color={COLORS.coral} /></Pressable>;
}

function EmptyState({ title, detail }: { title: string; detail: string }) {
  return <View style={styles.emptyState}><View style={styles.emptyIcon}><Leaf size={22} color={COLORS.leaf} /></View><Text style={styles.emptyTitle}>{title}</Text><Text style={styles.emptyText}>{detail}</Text></View>;
}

function TabButton({ active, icon, label, onPress }: { active: boolean; icon: ReactNode; label: string; onPress: () => void }) {
  return <Pressable onPress={onPress} style={styles.tabButton} accessibilityRole="tab" accessibilityState={{ selected: active }}><View style={[styles.tabIcon, active && styles.tabIconActive]}>{icon}</View><Text style={[styles.tabLabel, active && styles.tabLabelActive]}>{label}</Text></Pressable>;
}

function Field({ label, value, onChangeText, placeholder, keyboardType = 'default', multiline = false, hint }: { label: string; value: string; onChangeText: (text: string) => void; placeholder: string; keyboardType?: 'default' | 'numeric'; multiline?: boolean; hint?: string }) {
  return <View style={styles.fieldBlock}><Text style={styles.fieldLabel}>{label}</Text><TextInput value={value} onChangeText={onChangeText} placeholder={placeholder} placeholderTextColor="#A3AAA2" keyboardType={keyboardType} multiline={multiline} textAlignVertical={multiline ? 'top' : 'center'} style={[styles.fieldInput, multiline && styles.multilineInput]} />{hint ? <Text style={styles.fieldHint}>{hint}</Text> : null}</View>;
}

function SexChoice({ value, onChange }: { value: SheepSex; onChange: (sex: SheepSex) => void }) {
  return <View style={styles.choiceRow}>{(['Femelă', 'Mascul'] as SheepSex[]).map((option) => <Pressable key={option} onPress={() => onChange(option)} style={[styles.choiceButton, value === option && styles.choiceButtonSelected]}><Text style={[styles.choiceText, value === option && styles.choiceTextSelected]}>{option}</Text></Pressable>)}</View>;
}

function AnimalChoice({ sheep, selectedId, onSelect }: { sheep: SheepRecord[]; selectedId: number | null; onSelect: (id: number) => void }) {
  return <ScrollView horizontal showsHorizontalScrollIndicator={false} contentContainerStyle={styles.animalChoiceRow}>{sheep.map((animal) => <Pressable key={animal.id} onPress={() => onSelect(animal.id)} style={[styles.animalChoice, selectedId === animal.id && styles.animalChoiceSelected]}><Text style={[styles.animalChoiceName, selectedId === animal.id && styles.choiceTextSelected]} numberOfLines={1}>{animal.name}</Text><Text style={[styles.animalChoiceTag, selectedId === animal.id && styles.choiceTextSelected]}>{animal.tagNumber}</Text></Pressable>)}</ScrollView>;
}

function EntryModal({ visible, form, sheep, saving, onClose, onSaveSheep, onSaveLambing, onSaveTreatment }: {
  visible: boolean;
  form: FormKey;
  sheep: SheepRecord[];
  saving: boolean;
  onClose: () => void;
  onSaveSheep: (input: { name: string; sex: SheepSex; breed: string; mark: string; tagNumber: string }) => Promise<void>;
  onSaveLambing: (input: { motherId: number; date: string; breed: string; sex: SheepSex; tagNumber: string; lambName: string }) => Promise<void>;
  onSaveTreatment: (input: { sheepId: number; date: string; name: string; dose: string; notes: string; reminderAt: string | null }) => Promise<void>;
}) {
  const [name, setName] = useState('');
  const [sex, setSex] = useState<SheepSex>('Femelă');
  const [breed, setBreed] = useState('');
  const [mark, setMark] = useState('');
  const [tagNumber, setTagNumber] = useState('');
  const [date, setDate] = useState(today());
  const [animalId, setAnimalId] = useState<number | null>(null);
  const [treatmentName, setTreatmentName] = useState('');
  const [dose, setDose] = useState('');
  const [notes, setNotes] = useState('');
  const [hasReminder, setHasReminder] = useState(false);
  const [reminderAt, setReminderAt] = useState('');

  useEffect(() => {
    if (visible) {
      setName(''); setSex('Femelă'); setBreed(''); setMark(''); setTagNumber(''); setDate(today());
      setAnimalId(sheep.find((animal) => animal.sex === 'Femelă')?.id ?? sheep[0]?.id ?? null); setTreatmentName(''); setDose(''); setNotes(''); setHasReminder(false); setReminderAt('');
    }
  }, [visible, form, sheep]);

  const title = form === 'sheep' ? 'Oaie nouă' : form === 'lambing' ? 'Înregistrează fătarea' : 'Tratament nou';
  const canSave = !saving && (form === 'sheep'
    ? !!name.trim() && !!breed.trim() && !!tagNumber.trim()
    : form === 'lambing'
      ? !!animalId && !!breed.trim() && !!tagNumber.trim() && !!date.trim()
      : !!animalId && !!treatmentName.trim() && !!date.trim() && (!hasReminder || /^\d{4}-\d{2}-\d{2}$/.test(reminderAt)));

  async function submit() {
    if (!canSave) return;
    if (form === 'sheep') { await onSaveSheep({ name, sex, breed, mark, tagNumber }); return; }
    if (form === 'lambing' && animalId) { await onSaveLambing({ motherId: animalId, date, breed, sex, tagNumber, lambName: name || `Miel ${tagNumber}` }); return; }
    if (form === 'treatment' && animalId) { await onSaveTreatment({ sheepId: animalId, date, name: treatmentName, dose, notes, reminderAt: hasReminder ? reminderAt : null }); }
  }

  return <Modal visible={visible} transparent animationType="slide" onRequestClose={onClose}>
    <KeyboardAvoidingView style={styles.modalBackdrop} behavior={Platform.OS === 'ios' ? 'padding' : undefined}>
      <Pressable style={styles.modalScrim} onPress={onClose} />
      <View style={styles.sheet}>
        <View style={styles.sheetHandle} />
        <View style={styles.sheetHeader}><View><Text style={styles.sheetEyebrow}>{form === 'treatment' ? 'SĂNĂTATE' : form === 'lambing' ? 'JURNALUL MIEILOR' : 'EVIDENȚA TURMEI'}</Text><Text style={styles.sheetTitle}>{title}</Text></View><Pressable onPress={onClose} style={styles.closeButton}><X size={19} color={COLORS.ink} /></Pressable></View>
        <ScrollView style={styles.formScroll} contentContainerStyle={styles.formContent} keyboardShouldPersistTaps="handled" showsVerticalScrollIndicator={false}>
          {form === 'sheep' && <>
            <Field label="Nume sau descriere" value={name} onChangeText={setName} placeholder="De ex. Mioara" />
            <Text style={styles.fieldLabel}>Sex</Text><SexChoice value={sex} onChange={setSex} />
            <Field label="Rasă" value={breed} onChangeText={setBreed} placeholder="De ex. Țurcană" />
            <Field label="Semn la urechi" value={mark} onChangeText={setMark} placeholder="Descrie semnul sau coarnele" hint="Catalogul desenat al semnelor îl putem adăuga într-o etapă următoare." />
            <Field label="Număr de crotaliu" value={tagNumber} onChangeText={setTagNumber} placeholder="De ex. RO-004" />
          </>}
          {form === 'lambing' && <>
            <Text style={styles.fieldLabel}>Mama</Text><AnimalChoice sheep={sheep.filter((animal) => animal.sex === 'Femelă')} selectedId={animalId} onSelect={setAnimalId} />
            <Field label="Data fătării" value={date} onChangeText={setDate} placeholder="AAAA-LL-ZZ" hint="Format: an-lună-zi" />
            <Field label="Numele mielului (opțional)" value={name} onChangeText={setName} placeholder="De ex. Năsuc" />
            <Text style={styles.fieldLabel}>Sexul mielului</Text><SexChoice value={sex} onChange={setSex} />
            <Field label="Rasa" value={breed} onChangeText={setBreed} placeholder="De ex. Țurcană" />
            <Field label="Crotaliul mielului" value={tagNumber} onChangeText={setTagNumber} placeholder="Numărul primit" />
            <View style={styles.infoCallout}><Baby size={17} color={COLORS.leaf} /><Text style={styles.infoCalloutText}>Mielul va apărea automat și în lista turmei, cu mama și data nașterii.</Text></View>
          </>}
          {form === 'treatment' && <>
            <Text style={styles.fieldLabel}>Animalul tratat</Text><AnimalChoice sheep={sheep} selectedId={animalId} onSelect={setAnimalId} />
            <Field label="Tratament" value={treatmentName} onChangeText={setTreatmentName} placeholder="De ex. deparazitare" />
            <Field label="Data administrării" value={date} onChangeText={setDate} placeholder="AAAA-LL-ZZ" hint="Format: an-lună-zi" />
            <Field label="Doză (opțional)" value={dose} onChangeText={setDose} placeholder="De ex. 2 ml" />
            <Field label="Observații (opțional)" value={notes} onChangeText={setNotes} placeholder="Notează ce e util pentru data viitoare" multiline />
            <Pressable style={styles.toggleRow} onPress={() => { setHasReminder(!hasReminder); if (!hasReminder && !reminderAt) setReminderAt(''); }}><View style={[styles.toggleBox, hasReminder && styles.toggleBoxOn]}>{hasReminder && <Check size={14} color={COLORS.paper} />}</View><View style={{ flex: 1 }}><Text style={styles.toggleTitle}>Amintește-mi să refac tratamentul</Text><Text style={styles.toggleDescription}>Opțional · notificare pe acest telefon</Text></View><Bell size={18} color={hasReminder ? COLORS.coral : COLORS.muted} /></Pressable>
            {hasReminder && <Field label="Data reamintirii" value={reminderAt} onChangeText={setReminderAt} placeholder="AAAA-LL-ZZ" hint="Va fi programată o notificare locală la ora 09:00." />}
          </>}
        </ScrollView>
        <View style={styles.sheetFooter}><Pressable onPress={submit} disabled={!canSave} style={[styles.saveButton, !canSave && styles.saveButtonDisabled]}><Text style={styles.saveButtonText}>{saving ? 'Se salvează…' : form === 'lambing' ? 'Salvează fătarea' : form === 'treatment' ? 'Salvează tratamentul' : 'Adaugă în turmă'}</Text><ArrowRight size={18} color={COLORS.paper} /></Pressable></View>
      </View>
    </KeyboardAvoidingView>
  </Modal>;
}

function AnimalModal({ animal, history, onClose }: { animal: SheepRecord | null; history: Activity[]; onClose: () => void }) {
  return <Modal visible={!!animal} transparent animationType="slide" onRequestClose={onClose}>
    <View style={styles.modalBackdrop}><Pressable style={styles.modalScrim} onPress={onClose} /><View style={styles.detailSheet}>
      <View style={styles.sheetHandle} />
      {animal && <>
        <View style={styles.detailHeader}><View style={styles.detailAvatar}><Baby size={25} color={COLORS.leaf} /></View><View style={styles.detailIdentity}><Text style={styles.sheetEyebrow}>FIȘA ANIMALULUI</Text><Text style={styles.detailName}>{animal.name}</Text><Text style={styles.animalMeta}>{animal.breed} · {animal.sex}</Text></View><Pressable onPress={onClose} style={styles.closeButton}><X size={19} color={COLORS.ink} /></Pressable></View>
        <View style={styles.tagCard}><View><Text style={styles.tagLabel}>CROTALIU</Text><Text style={styles.tagValue}>{animal.tagNumber}</Text></View><View style={styles.tagDivider} /><View style={{ flex: 1 }}><Text style={styles.tagLabel}>SEMN DISTINCTIV</Text><Text style={styles.tagMark}>{animal.mark || 'Nespecificat'}</Text></View></View>
        <View style={styles.historyHeading}><Text style={styles.sectionTitle}>Istoric</Text><Text style={styles.sectionCaption}>Fătări și tratamente</Text></View>
        <ScrollView style={styles.historyList} contentContainerStyle={{ paddingBottom: 20 }} showsVerticalScrollIndicator={false}>
          {history.length ? history.map((entry) => <View key={`${entry.kind}-${entry.id}`} style={styles.historyItem}><View style={[styles.historyDot, { backgroundColor: entry.kind === 'lambing' ? COLORS.gold : COLORS.coral }]} /><View style={styles.historyEntry}><View style={styles.recordTitleLine}><Text style={styles.recordTitle}>{entry.title}</Text><Text style={styles.recordDate}>{dateLabel(entry.date)}</Text></View><Text style={styles.recordDetail}>{entry.detail || 'Fără alte detalii'}</Text>{entry.kind === 'treatment' && entry.reminderAt ? <Text style={styles.historyReminder}>Reamintire: {dateLabel(entry.reminderAt)}</Text> : null}</View></View>) : <EmptyState title="Istoricul începe aici" detail="Fătările și tratamentele pentru acest animal vor apărea în această fișă." />}
        </ScrollView>
      </>}
    </View></View>
  </Modal>;
}

const styles = StyleSheet.create({
  safeArea: { flex: 1, backgroundColor: COLORS.cream },
  appShell: { flex: 1, backgroundColor: COLORS.cream },
  topBar: { height: 67, paddingHorizontal: 23, flexDirection: 'row', alignItems: 'center', borderBottomWidth: 1, borderBottomColor: '#EAE8DE', backgroundColor: COLORS.cream },
  brandMark: { width: 34, height: 34, borderRadius: 11, backgroundColor: COLORS.forest, alignItems: 'center', justifyContent: 'center' },
  brandTextWrap: { marginLeft: 10, flex: 1 },
  brandTitle: { color: COLORS.ink, fontSize: 17, fontWeight: '800', letterSpacing: 0 },
  brandCaption: { color: COLORS.muted, fontSize: 8, fontWeight: '700', letterSpacing: 0.8, marginTop: 2 },
  topCount: { flexDirection: 'row', alignItems: 'baseline', backgroundColor: COLORS.paper, borderWidth: 1, borderColor: COLORS.line, borderRadius: 14, paddingHorizontal: 12, paddingVertical: 7, gap: 4 },
  topCountNumber: { color: COLORS.forest, fontWeight: '800', fontSize: 14 },
  topCountLabel: { color: COLORS.muted, fontSize: 12 },
  page: { flex: 1 },
  pageContent: { paddingHorizontal: 22, paddingTop: 23, paddingBottom: 24 },
  welcomeBlock: { marginBottom: 20 },
  eyebrow: { color: COLORS.leaf, fontSize: 10, letterSpacing: 1.1, fontWeight: '800', marginBottom: 7 },
  pageTitle: { color: COLORS.ink, fontSize: 29, lineHeight: 35, fontWeight: '700', fontFamily: Platform.OS === 'ios' ? 'Georgia' : 'serif' },
  pageSubtitle: { color: COLORS.muted, fontSize: 13, lineHeight: 19, marginTop: 5 },
  summaryRow: { flexDirection: 'row', gap: 9, marginBottom: 18 },
  summaryTile: { flex: 1, minHeight: 106, borderRadius: 14, padding: 12, justifyContent: 'space-between' },
  summaryIcon: { width: 29, height: 29, backgroundColor: '#FFFFFFA6', borderRadius: 9, alignItems: 'center', justifyContent: 'center' },
  summaryValue: { color: COLORS.ink, fontSize: 20, lineHeight: 22, fontWeight: '800', marginTop: 6 },
  summaryLabel: { color: '#5E6D61', fontSize: 11, fontWeight: '600' },
  sectionHeading: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', marginTop: 5, marginBottom: 13 },
  sectionTitle: { color: COLORS.ink, fontSize: 17, fontWeight: '800' },
  sectionCaption: { color: COLORS.muted, fontSize: 11, marginTop: 3 },
  textAction: { flexDirection: 'row', alignItems: 'center', gap: 1 },
  textActionLabel: { color: COLORS.leaf, fontSize: 12, fontWeight: '700' },
  searchBar: { minHeight: 44, flexDirection: 'row', alignItems: 'center', gap: 9, paddingHorizontal: 13, backgroundColor: COLORS.paper, borderWidth: 1, borderColor: COLORS.line, borderRadius: 12, marginBottom: 5 },
  searchInput: { flex: 1, color: COLORS.ink, fontSize: 13, paddingVertical: 8 },
  sheepRow: { flexDirection: 'row', alignItems: 'center', paddingVertical: 13, borderBottomWidth: 1, borderBottomColor: COLORS.line, gap: 12 },
  animalAvatar: { width: 45, height: 45, borderRadius: 14, alignItems: 'center', justifyContent: 'center' },
  animalInfo: { flex: 1 },
  animalNameLine: { flexDirection: 'row', alignItems: 'center', gap: 7 },
  animalName: { color: COLORS.ink, fontSize: 15, fontWeight: '800' },
  sexDot: { width: 6, height: 6, borderRadius: 4 },
  animalMeta: { color: COLORS.muted, fontSize: 11, marginTop: 3 },
  animalTag: { color: COLORS.leaf, fontSize: 10, marginTop: 4, fontWeight: '700' },
  reminderStrip: { flexDirection: 'row', alignItems: 'center', gap: 11, backgroundColor: COLORS.coralWash, padding: 12, borderRadius: 13, marginBottom: 20 },
  reminderIcon: { width: 33, height: 33, borderRadius: 10, backgroundColor: COLORS.paper, alignItems: 'center', justifyContent: 'center' },
  reminderEyebrow: { color: COLORS.coral, fontSize: 8, fontWeight: '800', letterSpacing: 0.7 },
  reminderTitle: { color: COLORS.ink, fontSize: 12, fontWeight: '700', marginTop: 3 },
  reminderDate: { color: COLORS.muted, fontSize: 10, marginTop: 2 },
  lambingSummary: { flexDirection: 'row', alignItems: 'center', gap: 10, backgroundColor: COLORS.mint, borderRadius: 13, padding: 15, marginBottom: 25 },
  lambingSummaryText: { flex: 1, color: COLORS.muted, fontSize: 12 },
  lambingSummaryStrong: { color: COLORS.forest, fontSize: 17, fontWeight: '800' },
  recordRow: { flexDirection: 'row', alignItems: 'flex-start', gap: 12, paddingVertical: 14, borderBottomWidth: 1, borderBottomColor: COLORS.line },
  recordIcon: { width: 38, height: 38, borderRadius: 12, alignItems: 'center', justifyContent: 'center' },
  recordMain: { flex: 1, minWidth: 0 },
  recordTitleLine: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'baseline', gap: 8 },
  recordTitle: { color: COLORS.ink, fontSize: 13, fontWeight: '800', flexShrink: 1 },
  recordDate: { color: COLORS.muted, fontSize: 10, flexShrink: 0 },
  recordDetail: { color: COLORS.muted, fontSize: 11, lineHeight: 16, marginTop: 4 },
  recordNote: { color: '#65746A', fontSize: 11, lineHeight: 16, marginTop: 4 },
  relatedLink: { flexDirection: 'row', alignItems: 'center', gap: 4, marginTop: 7 },
  relatedText: { color: COLORS.leaf, fontSize: 10, fontWeight: '700' },
  nextTreatment: { flexDirection: 'row', alignItems: 'center', gap: 12, padding: 13, borderWidth: 1, borderColor: '#F0D4CA', borderRadius: 13, backgroundColor: COLORS.coralWash, marginBottom: 23 },
  nextIcon: { width: 37, height: 37, borderRadius: 12, backgroundColor: COLORS.paper, alignItems: 'center', justifyContent: 'center' },
  nextEyebrow: { color: COLORS.coral, fontSize: 8, letterSpacing: 0.7, fontWeight: '800' },
  nextName: { color: COLORS.ink, fontSize: 13, fontWeight: '800', marginTop: 3 },
  nextDetail: { color: COLORS.muted, fontSize: 10, marginTop: 2 },
  emptyState: { alignItems: 'center', paddingHorizontal: 25, paddingTop: 34, paddingBottom: 30 },
  emptyIcon: { width: 50, height: 50, borderRadius: 17, backgroundColor: COLORS.mint, alignItems: 'center', justifyContent: 'center', marginBottom: 12 },
  emptyTitle: { color: COLORS.ink, fontWeight: '800', fontSize: 14, textAlign: 'center' },
  emptyText: { color: COLORS.muted, fontSize: 12, lineHeight: 18, textAlign: 'center', marginTop: 5, maxWidth: 260 },
  bottomDock: { borderTopWidth: 1, borderTopColor: COLORS.line, backgroundColor: COLORS.paper, paddingHorizontal: 13, paddingTop: 9, paddingBottom: Platform.OS === 'ios' ? 17 : 10, flexDirection: 'row', alignItems: 'center', gap: 7 },
  tabRail: { flex: 1, flexDirection: 'row', justifyContent: 'space-around' },
  tabButton: { minWidth: 58, alignItems: 'center', justifyContent: 'center', gap: 2 },
  tabIcon: { width: 34, height: 27, borderRadius: 10, alignItems: 'center', justifyContent: 'center', color: COLORS.muted },
  tabIconActive: { backgroundColor: COLORS.mint },
  tabLabel: { color: COLORS.muted, fontSize: 9, fontWeight: '600' },
  tabLabelActive: { color: COLORS.forest, fontWeight: '800' },
  addButton: { flexDirection: 'row', alignItems: 'center', justifyContent: 'center', gap: 7, height: 47, paddingHorizontal: 16, borderRadius: 14, backgroundColor: COLORS.forest },
  addButtonLabel: { color: COLORS.paper, fontSize: 12, fontWeight: '800' },
  loading: { flex: 1, backgroundColor: COLORS.cream, alignItems: 'center', justifyContent: 'center', padding: 30, gap: 12 },
  loadingText: { color: COLORS.muted, fontSize: 13, textAlign: 'center', lineHeight: 19 },
  errorTitle: { color: COLORS.ink, fontSize: 18, fontWeight: '800' },
  modalBackdrop: { flex: 1, justifyContent: 'flex-end', backgroundColor: '#16251E66' },
  modalScrim: { ...StyleSheet.absoluteFill },
  sheet: { maxHeight: '92%', backgroundColor: COLORS.paper, borderTopLeftRadius: 24, borderTopRightRadius: 24, paddingTop: 9 },
  detailSheet: { maxHeight: '87%', minHeight: '55%', backgroundColor: COLORS.paper, borderTopLeftRadius: 24, borderTopRightRadius: 24, paddingTop: 9, paddingHorizontal: 22 },
  sheetHandle: { alignSelf: 'center', width: 37, height: 4, borderRadius: 3, backgroundColor: '#D8DBD2', marginBottom: 17 },
  sheetHeader: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', paddingHorizontal: 22, paddingBottom: 14 },
  sheetEyebrow: { color: COLORS.leaf, fontSize: 9, letterSpacing: 1, fontWeight: '800' },
  sheetTitle: { color: COLORS.ink, fontSize: 23, fontWeight: '700', fontFamily: Platform.OS === 'ios' ? 'Georgia' : 'serif', marginTop: 3 },
  closeButton: { width: 35, height: 35, borderRadius: 12, backgroundColor: COLORS.cream, alignItems: 'center', justifyContent: 'center' },
  formScroll: { flexGrow: 0, flexShrink: 1 },
  formContent: { paddingHorizontal: 22, paddingTop: 2, paddingBottom: 14 },
  fieldBlock: { marginBottom: 15 },
  fieldLabel: { color: COLORS.ink, fontSize: 12, fontWeight: '800', marginBottom: 7 },
  fieldInput: { minHeight: 47, borderWidth: 1, borderColor: COLORS.line, borderRadius: 11, paddingHorizontal: 13, color: COLORS.ink, fontSize: 13, backgroundColor: '#FFFEFA' },
  multilineInput: { minHeight: 85, paddingTop: 12 },
  fieldHint: { color: COLORS.muted, fontSize: 10, lineHeight: 15, marginTop: 5 },
  choiceRow: { flexDirection: 'row', gap: 8, marginBottom: 15 },
  choiceButton: { flex: 1, height: 43, borderWidth: 1, borderColor: COLORS.line, borderRadius: 11, alignItems: 'center', justifyContent: 'center', backgroundColor: COLORS.paper },
  choiceButtonSelected: { borderColor: COLORS.leaf, backgroundColor: COLORS.mint },
  choiceText: { color: COLORS.muted, fontSize: 12, fontWeight: '700' },
  choiceTextSelected: { color: COLORS.forest, fontWeight: '800' },
  animalChoiceRow: { gap: 8, paddingBottom: 16 },
  animalChoice: { minWidth: 106, maxWidth: 145, borderWidth: 1, borderColor: COLORS.line, borderRadius: 11, paddingHorizontal: 11, paddingVertical: 9, backgroundColor: COLORS.paper },
  animalChoiceSelected: { borderColor: COLORS.leaf, backgroundColor: COLORS.mint },
  animalChoiceName: { color: COLORS.ink, fontSize: 11, fontWeight: '800' },
  animalChoiceTag: { color: COLORS.muted, fontSize: 9, marginTop: 3 },
  infoCallout: { flexDirection: 'row', gap: 9, alignItems: 'flex-start', backgroundColor: COLORS.mint, padding: 12, borderRadius: 11, marginTop: 1, marginBottom: 8 },
  infoCalloutText: { color: COLORS.forest, fontSize: 11, lineHeight: 16, flex: 1 },
  toggleRow: { flexDirection: 'row', alignItems: 'center', gap: 10, paddingVertical: 12, borderTopWidth: 1, borderTopColor: COLORS.line, borderBottomWidth: 1, borderBottomColor: COLORS.line, marginBottom: 14 },
  toggleBox: { width: 22, height: 22, borderRadius: 7, borderWidth: 1.5, borderColor: '#B6BEB6', alignItems: 'center', justifyContent: 'center' },
  toggleBoxOn: { backgroundColor: COLORS.leaf, borderColor: COLORS.leaf },
  toggleTitle: { color: COLORS.ink, fontSize: 11, fontWeight: '800' },
  toggleDescription: { color: COLORS.muted, fontSize: 10, marginTop: 3 },
  sheetFooter: { paddingHorizontal: 22, paddingTop: 10, paddingBottom: Platform.OS === 'ios' ? 24 : 15, borderTopWidth: 1, borderTopColor: COLORS.line, backgroundColor: COLORS.paper },
  saveButton: { height: 49, borderRadius: 13, backgroundColor: COLORS.forest, flexDirection: 'row', alignItems: 'center', justifyContent: 'center', gap: 9 },
  saveButtonDisabled: { backgroundColor: '#AEB9AF' },
  saveButtonText: { color: COLORS.paper, fontSize: 13, fontWeight: '800' },
  detailHeader: { flexDirection: 'row', alignItems: 'center', gap: 12, marginBottom: 18 },
  detailAvatar: { width: 51, height: 51, borderRadius: 16, backgroundColor: COLORS.mint, alignItems: 'center', justifyContent: 'center' },
  detailIdentity: { flex: 1 },
  detailName: { color: COLORS.ink, fontSize: 23, fontWeight: '700', fontFamily: Platform.OS === 'ios' ? 'Georgia' : 'serif', marginTop: 2 },
  tagCard: { flexDirection: 'row', alignItems: 'center', gap: 16, padding: 14, backgroundColor: COLORS.cream, borderRadius: 13, marginBottom: 22 },
  tagLabel: { color: COLORS.muted, fontSize: 8, letterSpacing: 0.8, fontWeight: '800' },
  tagValue: { color: COLORS.forest, fontSize: 15, fontWeight: '800', marginTop: 4 },
  tagDivider: { width: 1, height: 34, backgroundColor: COLORS.line },
  tagMark: { color: COLORS.ink, fontSize: 11, lineHeight: 15, marginTop: 4, flexShrink: 1 },
  historyHeading: { marginBottom: 9 },
  historyList: { flex: 1 },
  historyItem: { flexDirection: 'row', gap: 10, paddingTop: 12 },
  historyDot: { width: 8, height: 8, borderRadius: 5, marginTop: 5 },
  historyEntry: { flex: 1, borderBottomWidth: 1, borderBottomColor: COLORS.line, paddingBottom: 12 },
  historyReminder: { color: COLORS.coral, fontSize: 10, fontWeight: '700', marginTop: 6 },
});
