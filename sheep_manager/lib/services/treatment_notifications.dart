import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as timezone_data;
import 'package:timezone/timezone.dart' as timezone;

class TreatmentNotifications {
  TreatmentNotifications._();

  static const _channelId = 'treatment-follow-up';
  static const _channelName = 'Controale tratamente';
  static const _channelDescription = 'Reamintiri pentru refacerea tratamentelor animalelor.';
  static const _localTimeZone = 'Europe/Bucharest';

  static final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized || kIsWeb) return;

    timezone_data.initializeTimeZones();
    timezone.setLocalLocation(timezone.getLocation(_localTimeZone));

    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );
    await _plugin.initialize(settings: settings);
    _initialized = true;
  }

  static Future<bool> scheduleFollowUp({
    required String treatmentId,
    required String animalName,
    required String treatmentName,
    required DateTime followUpDate,
  }) async {
    await initialize();
    final scheduledDate = timezone.TZDateTime(
      timezone.local,
      followUpDate.year,
      followUpDate.month,
      followUpDate.day,
      9,
    );
    if (!scheduledDate.isAfter(timezone.TZDateTime.now(timezone.local))) return false;

    final permissionGranted = await _requestPermission();
    if (!permissionGranted) return false;

    final id = _stableNotificationId(treatmentId);
    await _plugin.cancel(id: id);
    await _plugin.zonedSchedule(
      id: id,
      title: 'Tratament de refăcut',
      body: '$animalName · $treatmentName',
      scheduledDate: scheduledDate,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDescription,
          importance: Importance.defaultImportance,
          priority: Priority.defaultPriority,
        ),
        iOS: DarwinNotificationDetails(presentAlert: true, presentSound: true),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      payload: treatmentId,
    );
    return true;
  }

  static Future<void> cancelFollowUp(String treatmentId) async {
    await initialize();
    await _plugin.cancel(id: _stableNotificationId(treatmentId));
  }

  static Future<bool> _requestPermission() async {
    if (kIsWeb) return false;
    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidPlugin = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      return await androidPlugin?.requestNotificationsPermission() ?? false;
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iosPlugin = _plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
      return await iosPlugin?.requestPermissions(alert: true, badge: false, sound: true) ?? false;
    }
    return false;
  }

  static int _stableNotificationId(String value) {
    var hash = 0x811c9dc5;
    for (final codeUnit in value.codeUnits) {
      hash ^= codeUnit;
      hash = (hash * 0x01000193) & 0x7fffffff;
    }
    return hash;
  }
}
