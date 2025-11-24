import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../utils/logger_util.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    try {
      LoggerUtil.info('🔔 Initializing notification service...');

      const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
      const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true);

      const InitializationSettings initSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);

      await _notifications.initialize(initSettings, onDidReceiveNotificationResponse: _onNotificationTapped);

      _initialized = true;
      LoggerUtil.info('Notification service initialized');
    } catch (e) {
      LoggerUtil.error('Failed to initialize notification service', e);
    }
  }

  void _onNotificationTapped(NotificationResponse response) {
    LoggerUtil.info('🔔 Notification tapped: ${response.payload}');
  }

  Future<void> showNotification({required int id, required String title, required String body, String? payload}) async {
    if (!_initialized) await initialize();

    try {
      const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'opendrop_channel',
        'OpenDrop Notifications',
        channelDescription: 'Notifications for OpenDrop Connect',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
      );

      const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true);

      const NotificationDetails details = NotificationDetails(android: androidDetails, iOS: iosDetails);

      await _notifications.show(id, title, body, details, payload: payload);

      LoggerUtil.info('🔔 Notification shown: $title');
    } catch (e) {
      LoggerUtil.error('Failed to show notification', e);
    }
  }

  Future<void> showDeviceDiscoveredNotification({required String deviceName}) async {
    await showNotification(id: 1, title: 'Device Nearby', body: '$deviceName wants to share contact', payload: 'device_discovered');
  }

  Future<void> showTransferCompleteNotification({required String contactName}) async {
    await showNotification(id: 2, title: 'Contact Received', body: 'Successfully received contact from $contactName', payload: 'transfer_complete');
  }

  Future<void> showErrorNotification({required String message}) async {
    await showNotification(id: 3, title: 'Error', body: message, payload: 'error');
  }

  Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  Future<void> createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel('opendrop_channel', 'OpenDrop Notifications', description: 'Notifications for OpenDrop Connect', importance: Importance.high, playSound: true);

    await _notifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    LoggerUtil.info('✅ Notification channel created');
  }
}
