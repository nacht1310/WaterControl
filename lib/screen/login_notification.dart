import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:uitest/constant.dart';

class LoginNotification {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    const styleInformation = BigPictureStyleInformation(
        DrawableResourceAndroidBitmap('maxresdefault'),
        largeIcon: DrawableResourceAndroidBitmap('bronya_icon'));
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        importance: Importance.max,
        styleInformation: styleInformation,
      ),
    );
  }

  static Future init({required bool initSchedule}) async {
    // ignore: prefer_const_constructors
    final android = AndroidInitializationSettings('hcmut_official_logo');
    final settings = InitializationSettings(android: android);
    // final details = await _notifications.getNotificationAppLaunchDetails();
    // if (details != null && details.didNotificationLaunchApp) {
    //   onNotification.add(details.payload);
    // }

    await _notifications.initialize(settings,
        onSelectNotification: (payload) => onNotification.add(payload));
    if (initSchedule) {
      initializeTimeZones();
      tz.setLocalLocation(cityHoChiMinh);
    }
  }

  static Future showNotifications({
    String? payload,
    int id = 0,
    required String title,
    required String body,
  }) async {
    _notifications.show(id, title, body, await _notificationDetails(),
        payload: payload);
  }

  static Future showScheduledNotifications({
    String? payload,
    int id = 0,
    required String title,
    required String body,
    required DateTime scheduleTime,
  }) async {
    initializeTimeZones();
    _notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduleTime, cityHoChiMinh),
        await _notificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  static Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }
}


// tz.TZDateTime _scheduleDaily(DateTime time) {
//   final now = tz.TZDateTime.now(cityHoChiMinh);
//   final scheduledDate = tz.TZDateTime(cityHoChiMinh, now.day, now.month,
//       now.year, time.hour, time.minute, time.second);
//   if (scheduledDate.isBefore(now)) {
//     return now.add(const Duration(minutes: 1));
//   } else {
//     return scheduledDate;
//   }
// }
