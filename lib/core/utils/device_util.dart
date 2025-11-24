import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';
import 'logger_util.dart';

class DeviceUtil {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  String? _deviceId;
  String? _deviceName;
  String? _deviceModel;
  String? _osVersion;

  Future<String> getDeviceId() async {
    if (_deviceId != null) return _deviceId!;

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        _deviceId = androidInfo.id;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        _deviceId = iosInfo.identifierForVendor ?? const Uuid().v4();
      } else {
        _deviceId = const Uuid().v4();
      }

      LoggerUtil.info('📱 Device ID: $_deviceId');
      return _deviceId!;
    } catch (e) {
      LoggerUtil.error('Error getting device ID', e);
      _deviceId = const Uuid().v4();
      return _deviceId!;
    }
  }

  Future<String> getDeviceName() async {
    if (_deviceName != null) return _deviceName!;

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        _deviceName = androidInfo.model;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        _deviceName = iosInfo.name;
      } else {
        _deviceName = 'Unknown Device';
      }

      LoggerUtil.info('📱 Device Name: $_deviceName');
      return _deviceName!;
    } catch (e) {
      LoggerUtil.error('Error getting device name', e);
      _deviceName = 'Unknown Device';
      return _deviceName!;
    }
  }

  Future<String> getDeviceModel() async {
    if (_deviceModel != null) return _deviceModel!;

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        _deviceModel = '${androidInfo.manufacturer} ${androidInfo.model}';
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        _deviceModel = iosInfo.model;
      } else {
        _deviceModel = 'Unknown Model';
      }

      LoggerUtil.info('📱 Device Model: $_deviceModel');
      return _deviceModel!;
    } catch (e) {
      LoggerUtil.error('Error getting device model', e);
      _deviceModel = 'Unknown Model';
      return _deviceModel!;
    }
  }

  Future<String> getOSVersion() async {
    if (_osVersion != null) return _osVersion!;

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        _osVersion = 'Android ${androidInfo.version.release}';
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        _osVersion = 'iOS ${iosInfo.systemVersion}';
      } else {
        _osVersion = 'Unknown OS';
      }

      LoggerUtil.info('📱 OS Version: $_osVersion');
      return _osVersion!;
    } catch (e) {
      LoggerUtil.error('Error getting OS version', e);
      _osVersion = 'Unknown OS';
      return _osVersion!;
    }
  }

  bool isAndroid() => Platform.isAndroid;

  bool isIOS() => Platform.isIOS;

  String getPlatform() {
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    return 'Unknown';
  }

  Future<Map<String, dynamic>> getAllDeviceInfo() async {
    return {'deviceId': await getDeviceId(), 'deviceName': await getDeviceName(), 'deviceModel': await getDeviceModel(), 'osVersion': await getOSVersion(), 'platform': getPlatform()};
  }

  Future<bool> supportsBLE() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        return androidInfo.version.sdkInt >= 21;
      } else if (Platform.isIOS) {
        return true;
      }
      return false;
    } catch (e) {
      LoggerUtil.error('Error checking BLE support', e);
      return false;
    }
  }

  Future<bool> supportsNFC() async {
    try {
      if (Platform.isAndroid) {
        return true;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        return !iosInfo.model.contains('iPhone6') && !iosInfo.model.contains('iPhone5');
      }
      return false;
    } catch (e) {
      LoggerUtil.error('Error checking NFC support', e);
      return false;
    }
  }
}
