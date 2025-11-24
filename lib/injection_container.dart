import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'core/utils/logger_util.dart';
import 'core/utils/permission_util.dart';
import 'core/utils/device_util.dart';
import 'core/services/notification_service.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  final Map<Type, dynamic> _services = {};

  void register<T>(T service) {
    _services[T] = service;
  }

  T get<T>() {
    final service = _services[T];
    if (service == null) {
      throw Exception('Service of type $T not registered');
    }
    return service as T;
  }

  bool isRegistered<T>() {
    return _services.containsKey(T);
  }
}

final sl = ServiceLocator();

Future<void> init() async {
  LoggerUtil.info('🔧 Initializing dependencies...');

  // Core utilities
  await _initCore();

  // Services
  await _initServices();

  // External dependencies
  await _initExternal();

  LoggerUtil.info('✅ All dependencies initialized');
}

Future<void> _initCore() async {
  LoggerUtil.info('📦 Initializing core utilities...');

  // Register utils as singletons
  sl.register<PermissionUtil>(PermissionUtil());
  sl.register<DeviceUtil>(DeviceUtil());

  LoggerUtil.info('✅ Core utilities initialized');
}

Future<void> _initServices() async {
  LoggerUtil.info('🔔 Initializing services...');

  // Notification Service
  final notificationService = NotificationService();
  await notificationService.initialize();
  sl.register<NotificationService>(notificationService);

  LoggerUtil.info('✅ Services initialized');
}

Future<void> _initExternal() async {
  LoggerUtil.info('🌐 Initializing external dependencies...');

  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.register<SharedPreferences>(sharedPreferences);

  // App directory
  final appDirectory = await getApplicationDocumentsDirectory();
  LoggerUtil.info('📁 App directory: ${appDirectory.path}');

  LoggerUtil.info('✅ External dependencies initialized');
}
