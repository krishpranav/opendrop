import 'package:permission_handler/permission_handler.dart';
import 'logger_util.dart';

class PermissionUtil {
  Future<bool> requestBluetoothPermissions() async {
    try {
      LoggerUtil.info('📡 Requesting Bluetooth permissions...');

      Map<Permission, PermissionStatus> statuses = await [Permission.bluetooth, Permission.bluetoothScan, Permission.bluetoothConnect, Permission.bluetoothAdvertise].request();

      bool allGranted = statuses.values.every((status) => status.isGranted || status.isLimited);

      if (allGranted) {
        LoggerUtil.info('Bluetooth permissions granted');
      } else {
        LoggerUtil.warning('Some Bluetooth permissions denied');
      }

      return allGranted;
    } catch (e) {
      LoggerUtil.error('Error requesting Bluetooth permissions', e);
      return false;
    }
  }

  Future<bool> requestLocationPermissions() async {
    try {
      LoggerUtil.info('📍 Requesting Location permissions...');

      Map<Permission, PermissionStatus> statuses = await [Permission.locationWhenInUse, Permission.location].request();

      bool granted = statuses.values.any((status) => status.isGranted);

      if (granted) {
        LoggerUtil.info('Location permissions granted');
      } else {
        LoggerUtil.warning('Location permissions denied');
      }

      return granted;
    } catch (e) {
      LoggerUtil.error('Error requesting Location permissions', e);
      return false;
    }
  }

  Future<bool> requestNotificationPermissions() async {
    try {
      LoggerUtil.info('🔔 Requesting Notification permissions...');

      PermissionStatus status = await Permission.notification.request();

      if (status.isGranted) {
        LoggerUtil.info('Notification permissions granted');
        return true;
      } else {
        LoggerUtil.warning('Notification permissions denied');
        return false;
      }
    } catch (e) {
      LoggerUtil.error('Error requesting Notification permissions', e);
      return false;
    }
  }

  Future<bool> requestContactsPermissions() async {
    try {
      LoggerUtil.info('👥 Requesting Contacts permissions...');

      PermissionStatus status = await Permission.contacts.request();

      if (status.isGranted) {
        LoggerUtil.info('Contacts permissions granted');
        return true;
      } else {
        LoggerUtil.warning('Contacts permissions denied');
        return false;
      }
    } catch (e) {
      LoggerUtil.error('Error requesting Contacts permissions', e);
      return false;
    }
  }

  Future<bool> requestCameraPermissions() async {
    try {
      LoggerUtil.info('📷 Requesting Camera permissions...');

      PermissionStatus status = await Permission.camera.request();

      if (status.isGranted) {
        LoggerUtil.info('Camera permissions granted');
        return true;
      } else {
        LoggerUtil.warning('Camera permissions denied');
        return false;
      }
    } catch (e) {
      LoggerUtil.error('Error requesting Camera permissions', e);
      return false;
    }
  }

  Future<bool> requestStoragePermissions() async {
    try {
      LoggerUtil.info('💾 Requesting Storage permissions...');

      PermissionStatus status = await Permission.photos.request();

      if (status.isGranted || status.isLimited) {
        LoggerUtil.info('Storage permissions granted');
        return true;
      } else {
        LoggerUtil.warning('Storage permissions denied');
        return false;
      }
    } catch (e) {
      LoggerUtil.error('Error requesting Storage permissions', e);
      return false;
    }
  }

  Future<bool> hasBluetoothPermissions() async {
    try {
      Map<Permission, PermissionStatus> statuses = await [Permission.bluetooth, Permission.bluetoothScan, Permission.bluetoothConnect].request();

      return statuses.values.every((status) => status.isGranted || status.isLimited);
    } catch (e) {
      LoggerUtil.error('Error checking Bluetooth permissions', e);
      return false;
    }
  }

  Future<bool> hasLocationPermissions() async {
    try {
      PermissionStatus status = await Permission.location.status;
      return status.isGranted;
    } catch (e) {
      LoggerUtil.error('Error checking Location permissions', e);
      return false;
    }
  }

  Future<bool> requestAllPermissions() async {
    LoggerUtil.info('🔐 Requesting all required permissions...');

    bool bluetoothGranted = await requestBluetoothPermissions();
    bool locationGranted = await requestLocationPermissions();
    bool notificationGranted = await requestNotificationPermissions();

    bool allGranted = bluetoothGranted && locationGranted && notificationGranted;

    if (allGranted) {
      LoggerUtil.info('All required permissions granted');
    } else {
      LoggerUtil.warning('Some required permissions not granted');
    }

    return allGranted;
  }

  Future<void> openAppSettings() async {
    LoggerUtil.info('⚙️ Opening app settings...');
    await openAppSettings();
  }
}
