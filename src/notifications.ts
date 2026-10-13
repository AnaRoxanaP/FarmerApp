import { Platform } from 'react-native';
import * as Notifications from 'expo-notifications';

Notifications.setNotificationHandler({
  handleNotification: async () => ({ shouldShowAlert: true, shouldPlaySound: false, shouldSetBadge: false, shouldShowBanner: true, shouldShowList: true }),
});

export async function scheduleTreatmentReminder(animalName: string, treatmentName: string, reminderAt: string): Promise<string | null> {
  const date = new Date(`${reminderAt}T09:00:00`);
  if (Number.isNaN(date.getTime()) || date <= new Date()) return null;

  if (Platform.OS === 'android') {
    await Notifications.setNotificationChannelAsync('treatments', {
      name: 'Reamintiri tratamente',
      importance: Notifications.AndroidImportance.DEFAULT,
    });
  }

  const permission = await Notifications.requestPermissionsAsync();
  if (!permission.granted) return null;

  return Notifications.scheduleNotificationAsync({
    content: {
      title: 'Tratament de refăcut',
      body: `${animalName} · ${treatmentName}`,
      ...(Platform.OS === 'android' ? { channelId: 'treatments' } : {}),
    },
    trigger: { type: Notifications.SchedulableTriggerInputTypes.DATE, date },
  });
}
