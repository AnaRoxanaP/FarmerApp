export type SheepSex = 'Femelă' | 'Mascul';

export type Sheep = {
  id: number;
  name: string;
  sex: SheepSex;
  breed: string;
  mark: string;
  tagNumber: string;
  bornAt: string | null;
  motherId: number | null;
  createdAt: string;
};

export type Lambing = {
  id: number;
  motherId: number;
  date: string;
  breed: string;
  sex: SheepSex;
  tagNumber: string;
  lambName: string;
  motherName?: string;
};

export type Treatment = {
  id: number;
  sheepId: number;
  date: string;
  name: string;
  dose: string;
  notes: string;
  reminderAt: string | null;
  notificationId: string | null;
  sheepName?: string;
  tagNumber?: string;
};

export type Activity =
  | { kind: 'lambing'; id: number; date: string; title: string; detail: string }
  | { kind: 'treatment'; id: number; date: string; title: string; detail: string; reminderAt: string | null };
