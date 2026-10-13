# Stâna noastră · Flutter

Noua implementare Flutter a aplicației de evidență pentru gospodărie. Proiectul Expo din directorul părinte este păstrat ca prototip și referință.

## Prima etapă

- Bază locală SQLite prin Drift, versiunea de schemă 2, cu migrare pentru fișele de animale din schema prototip.
- Tabele separate pentru gospodării și membri, animale, fătări și mieii rezultați, tratamente, monte, cântăriri și evenimente generale.
- Identificatori UUID, inclusiv UUID de gospodărie generat și păstrat per instalare; crotalii unice în cadrul gospodăriei, legături de filiație și marcaje soft-delete/audit pentru păstrarea istoricului.
- Coada outbox locală pentru schimbări pregătite de sincronizare.
- Înregistrarea unei fătări este tranzacțională: creează evenimentul, fișele tuturor mieilor, legăturile și înregistrările outbox împreună.
- Operații de bază pentru tratamente, cântăriri, monte și evenimente generale; animalele ieșite din efectiv se arhivează, nu se șterg definitiv.
- Căutare după nume, rasă, crotaliu complet sau ultimele trei cifre.
- Adăugarea unei fișe cu nume/descriere, sex, rasă, semn, crotaliu și data nașterii.
- Fișă individuală deschisă din turmă, cu crotaliu, semn, stare, filiație și cronologia evenimentelor.
- Editarea fișei unei oi sau a unui miel păstrează UUID-ul și relațiile; editarea datei unui miel actualizează și data evenimentului de fătare.
- Trei file de lucru: Turmă, Fătări și Sănătate.
- Formular de fătare cu căutarea mamei după nume, rasă sau crotaliu și cu unul sau mai mulți miei.
- Registru reactiv al fătărilor și tratamentelor, cu doză, timpi de așteptare și dată de control opțională.
- Tratamentul poate fi aplicat simultan mai multor animale selectate sau tuturor rezultatelor căutării.
- Notificare locală opțională pentru data controlului la tratament, programată la ora 09:00 în fusul Europe/Bucharest.

## Generare și pornire

După instalarea Flutter SDK. Android SDK este necesar doar dacă vrei să compilezi sau să rulezi varianta Android:

```powershell
cd E:\MyProjects\FarmerApp\sheep_manager
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

La salvarea unui tratament cu dată de control, aplicația cere permisiunea pentru notificări. Dacă permisiunea este refuzată sau data nu este în viitor, tratamentul rămâne salvat, dar notificarea nu se programează.

Rulează analiza și testele bazei de date cu `flutter analyze` și `flutter test`.

## Preview în Chrome pe Windows

Acest preview ajută la verificarea interfeței fără iPhone sau Android. În PowerShell, din directorul proiectului:

```powershell
flutter create --platforms=web .
$driftRelease = 'https://github.com/simolus3/drift/releases/download/drift-2.35.2'
Invoke-WebRequest "$driftRelease/sqlite3.wasm" -OutFile .\web\sqlite3.wasm
Invoke-WebRequest "$driftRelease/drift_worker.js" -OutFile .\web\drift_worker.js
flutter pub get
flutter run -d chrome --web-header=Cross-Origin-Opener-Policy=same-origin --web-header=Cross-Origin-Embedder-Policy=require-corp
```

Datele preview-ului se păstrează în browserul de pe PC și nu sunt aceleași cu datele de pe telefon. Notificările programate nu sunt disponibile în acest preview web; ele se testează în aplicația instalată nativ.

Pentru a verifica mediul înainte, rulează `flutter doctor`. Deschiderea în Expo Go nu se aplică acestei implementări Flutter.

## Direcția următoare

Supabase, autentificarea, sincronizarea efectivă, retry-urile și rezolvarea conflictelor nu sunt încă implementate. Coada outbox este doar fundația locală; SQLite și Supabase nu se sincronizează automat.
