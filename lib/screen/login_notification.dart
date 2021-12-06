import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

class LoginNotification {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        importance: Importance.max,
      ),
    );
  }

  static Future init() async {
    // ignore: prefer_const_constructors
    final android = AndroidInitializationSettings('hcmut_official_logo');
    final settings = InitializationSettings(android: android);
    await _notifications.initialize(settings,
        onSelectNotification: (payload) => onNotification.add(payload));
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
}
