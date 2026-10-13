import * as SQLite from 'expo-sqlite';
import type { Activity, Lambing, Sheep, SheepSex, Treatment } from './types';

const databasePromise = SQLite.openDatabaseAsync('stana-mea.db');

export async function initializeDatabase(): Promise<void> {
  const db = await databasePromise;
  await db.execAsync(`
    PRAGMA journal_mode = WAL;
    CREATE TABLE IF NOT EXISTS sheep (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      sex TEXT NOT NULL,
      breed TEXT NOT NULL,
      mark TEXT NOT NULL DEFAULT '',
      tag_number TEXT NOT NULL UNIQUE,
      born_at TEXT,
      mother_id INTEGER REFERENCES sheep(id),
      created_at TEXT NOT NULL
    );
    CREATE TABLE IF NOT EXISTS lambings (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      mother_id INTEGER NOT NULL REFERENCES sheep(id),
      date TEXT NOT NULL,
      breed TEXT NOT NULL,
      sex TEXT NOT NULL,
      tag_number TEXT NOT NULL,
      lamb_name TEXT NOT NULL
    );
    CREATE TABLE IF NOT EXISTS treatments (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      sheep_id INTEGER NOT NULL REFERENCES sheep(id),
      date TEXT NOT NULL,
      name TEXT NOT NULL,
      dose TEXT NOT NULL DEFAULT '',
      notes TEXT NOT NULL DEFAULT '',
      reminder_at TEXT,
      notification_id TEXT
    );
  `);

  const count = await db.getFirstAsync<{ count: number }>('SELECT COUNT(*) AS count FROM sheep');
  if (count?.count === 0) {
    const today = new Date().toISOString().slice(0, 10);
    await db.runAsync('INSERT INTO sheep (name, sex, breed, mark, tag_number, born_at, created_at) VALUES (?, ?, ?, ?, ?, ?, ?)', 'Mioara', 'Femelă', 'Țurcană', 'Urechea stângă crestată', 'RO-001', '2021-03-12', today);
    await db.runAsync('INSERT INTO sheep (name, sex, breed, mark, tag_number, born_at, created_at) VALUES (?, ?, ?, ?, ?, ?, ?)', 'Alba', 'Femelă', 'Țurcană', 'Ambele urechi întregi', 'RO-002', '2022-02-20', today);
    await db.runAsync('INSERT INTO sheep (name, sex, breed, mark, tag_number, born_at, created_at) VALUES (?, ?, ?, ?, ?, ?, ?)', 'Berbecuț', 'Mascul', 'Merinos', 'Corn scurt pe partea dreaptă', 'RO-003', '2023-01-08', today);
  }
}

export async function listSheep(): Promise<Sheep[]> {
  const db = await databasePromise;
  return db.getAllAsync<Sheep>('SELECT id, name, sex, breed, mark, tag_number AS tagNumber, born_at AS bornAt, mother_id AS motherId, created_at AS createdAt FROM sheep ORDER BY name COLLATE NOCASE');
}

export async function saveSheep(input: Omit<Sheep, 'id' | 'createdAt' | 'bornAt' | 'motherId'>): Promise<void> {
  const db = await databasePromise;
  await db.runAsync('INSERT INTO sheep (name, sex, breed, mark, tag_number, created_at) VALUES (?, ?, ?, ?, ?, ?)', input.name.trim(), input.sex, input.breed.trim(), input.mark.trim(), input.tagNumber.trim(), new Date().toISOString().slice(0, 10));
}

export async function listLambings(): Promise<Lambing[]> {
  const db = await databasePromise;
  return db.getAllAsync<Lambing>(`SELECT l.id, l.mother_id AS motherId, l.date, l.breed, l.sex, l.tag_number AS tagNumber, l.lamb_name AS lambName, s.name AS motherName
    FROM lambings l JOIN sheep s ON s.id = l.mother_id ORDER BY l.date DESC, l.id DESC`);
}

export async function saveLambing(input: { motherId: number; date: string; breed: string; sex: SheepSex; tagNumber: string; lambName: string }): Promise<void> {
  const db = await databasePromise;
  await db.withTransactionAsync(async () => {
    const result = await db.runAsync('INSERT INTO sheep (name, sex, breed, mark, tag_number, born_at, mother_id, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', input.lambName.trim(), input.sex, input.breed.trim(), '', input.tagNumber.trim(), input.date, input.motherId, input.date);
    await db.runAsync('INSERT INTO lambings (mother_id, date, breed, sex, tag_number, lamb_name) VALUES (?, ?, ?, ?, ?, ?)', input.motherId, input.date, input.breed.trim(), input.sex, input.tagNumber.trim(), input.lambName.trim() || `Miel #${result.lastInsertRowId}`);
  });
}

export async function listTreatments(): Promise<Treatment[]> {
  const db = await databasePromise;
  return db.getAllAsync<Treatment>(`SELECT t.id, t.sheep_id AS sheepId, t.date, t.name, t.dose, t.notes, t.reminder_at AS reminderAt, t.notification_id AS notificationId, s.name AS sheepName, s.tag_number AS tagNumber
    FROM treatments t JOIN sheep s ON s.id = t.sheep_id ORDER BY COALESCE(t.reminder_at, t.date) ASC, t.id DESC`);
}

export async function saveTreatment(input: Omit<Treatment, 'id' | 'notificationId' | 'sheepName' | 'tagNumber'> & { notificationId: string | null }): Promise<void> {
  const db = await databasePromise;
  await db.runAsync('INSERT INTO treatments (sheep_id, date, name, dose, notes, reminder_at, notification_id) VALUES (?, ?, ?, ?, ?, ?, ?)', input.sheepId, input.date, input.name.trim(), input.dose.trim(), input.notes.trim(), input.reminderAt, input.notificationId);
}

export async function getAnimalHistory(sheepId: number): Promise<Activity[]> {
  const db = await databasePromise;
  const birth = await db.getFirstAsync<{ bornAt: string | null; motherId: number | null; motherName: string | null; breed: string; sex: SheepSex; tagNumber: string }>(`SELECT s.born_at AS bornAt, s.mother_id AS motherId, m.name AS motherName, s.breed, s.sex, s.tag_number AS tagNumber
    FROM sheep s LEFT JOIN sheep m ON m.id = s.mother_id WHERE s.id = ?`, sheepId);
  const lambings = await db.getAllAsync<{ id: number; date: string; lambName: string; breed: string; sex: SheepSex; tagNumber: string }>('SELECT id, date, lamb_name AS lambName, breed, sex, tag_number AS tagNumber FROM lambings WHERE mother_id = ? ORDER BY date DESC', sheepId);
  const treatments = await db.getAllAsync<{ id: number; date: string; name: string; dose: string; notes: string; reminderAt: string | null }>('SELECT id, date, name, dose, notes, reminder_at AS reminderAt FROM treatments WHERE sheep_id = ? ORDER BY date DESC', sheepId);
  return [
    ...(birth?.motherId && birth.bornAt ? [{ kind: 'lambing' as const, id: -sheepId, date: birth.bornAt, title: `Născut(ă) · mama ${birth.motherName}`, detail: `${birth.breed} · ${birth.sex} · crotaliu ${birth.tagNumber}` }] : []),
    ...lambings.map((item): Activity => ({ kind: 'lambing', id: item.id, date: item.date, title: `Fătare · ${item.lambName}`, detail: `${item.breed} · ${item.sex} · crotaliu ${item.tagNumber}` })),
    ...treatments.map((item): Activity => ({ kind: 'treatment', id: item.id, date: item.date, title: item.name, detail: [item.dose, item.notes].filter(Boolean).join(' · '), reminderAt: item.reminderAt })),
  ].sort((first, second) => second.date.localeCompare(first.date));
}
