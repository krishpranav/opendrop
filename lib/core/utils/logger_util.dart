import 'package:logger/logger.dart';
import 'package:opendrop/core/constants/app_constants.dart';

class LoggerUtil {
  static late Logger _logger;
  static bool _initialized = false;

  static void init() {
    if (_initialized) return;

    _logger = Logger(
      printer: SimplePrinter(
        colors: false,
        printTime: false,
      ),
      level: AppConstants.enableDebugLogs ? Level.debug : Level.info,
    );

    _initialized = true;
  }

  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    if (!_initialized) init();
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  static void info(String message, [dynamic error, StackTrace? stackTrace]) {
    if (!_initialized) init();
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  static void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    if (!_initialized) init();
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    if (!_initialized) init();
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  static void fatal(String message, [dynamic error, StackTrace? stackTrace]) {
    if (!_initialized) init();
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  static void trace(String message, [dynamic error, StackTrace? stackTrace]) {
    if (!_initialized) init();
    _logger.t(message, error: error, stackTrace: stackTrace);
  }
}