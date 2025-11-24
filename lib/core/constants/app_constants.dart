class AppConstants {
  static const String appName = 'OpenDrop Connect';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Share contacts instantly';

  static const String dbName = 'opendrop_connect.db';
  static const int dbVersion = 1;

  static const String keyFirstLaunch = 'first_launch';
  static const String keyUserProfile = 'user_profile';
  static const String keyBackgroundServiceEnabled = 'background_service_enabled';
  static const String keyDiscoveryRange = 'discovery_range';
  static const String keyNotificationsEnabled = 'notifications_enabled';
  static const String keyAutoAcceptEnabled = 'auto_accept_enabled';

  static const int connectionTimeout = 30;
  static const int discoveryTimeout = 60;
  static const int transferTimeout = 45;
  static const int pairingTimeout = 20;

  static const double defaultPadding = 16.0;
  static const double defaultRadius = 12.0;
  static const double cardElevation = 4.0;

  static const int shortAnimationDuration = 300;
  static const int mediumAnimationDuration = 500;
  static const int longAnimationDuration = 800;

  static const double proximityThresholdClose = 0.1; // 10 cm
  static const double proximityThresholdNear = 0.5; // 50 cm
  static const double proximityThresholdFar = 2.0; // 2 meters

  static const int maxAvatarSize = 5 * 1024 * 1024; // 5 MB
  static const int maxContactDataSize = 10 * 1024 * 1024; // 10 MB

  static const int maxRetryAttempts = 3;
  static const int retryDelaySeconds = 2;

  static const int sessionExpiryMinutes = 10;

  static const bool enableNFC = true;
  static const bool enableBLE = true;
  static const bool enableAudioPairing = true;
  static const bool enableWifiDirect = true;
  static const bool enableWebRTC = true;
  static const bool enableBackgroundService = true;

  static const bool requireManualAcceptance = true;
  static const bool showProximityIndicator = true;

  static const bool enableDebugLogs = true;
  static const bool enablePerformanceMonitoring = false;
}
