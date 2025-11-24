class BleConstants {
  static const String serviceUuid = '0000FEED-0000-1000-8000-00805F9B34FB';

  static const String characteristicDeviceInfo = '0000FEE1-0000-1000-8000-00805F9B34FB';
  static const String characteristicHandshake = '0000FEE2-0000-1000-8000-00805F9B34FB';
  static const String characteristicDataTransfer = '0000FEE3-0000-1000-8000-00805F9B34FB';
  static const String characteristicControl = '0000FEE4-0000-1000-8000-00805F9B34FB';

  static const int scanDurationSeconds = 10;
  static const int scanModeBalanced = 1; // 0: Low power, 1: Balanced, 2: Low latency
  static const bool allowDuplicates = false;

  static const int advertisementIntervalMs = 100; // 100ms
  static const int advertisementTxPowerHigh = 3; // High power for close-range detection

  static const int rssiThresholdVeryClose = -50; // < 10cm
  static const int rssiThresholdClose = -65; // < 50cm
  static const int rssiThresholdNear = -75; // < 2m
  static const int rssiThresholdFar = -85; // > 2m

  static const int connectionTimeoutSeconds = 15;
  static const int mtuSize = 512; // Maximum Transmission Unit
  static const int connectionPriority = 1; // 0: Balanced, 1: High

  static const int maxPayloadSize = 512; // Bytes per packet
  static const int chunkSize = 256; // Bytes per chunk
  static const int transferRetryAttempts = 3;

  static const int deviceTimeoutSeconds = 5; // Remove device if not seen for 5s
  static const int proximityCheckIntervalMs = 500; // Check proximity every 500ms

  static const int backgroundScanIntervalSeconds = 30;
  static const int backgroundScanDurationSeconds = 5;
}
