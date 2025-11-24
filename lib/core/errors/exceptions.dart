class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic details;

  AppException({required this.message, this.code, this.details});

  @override
  String toString() => 'AppException: $message ${code != null ? '(Code: $code)' : ''}';
}

class NetworkException extends AppException {
  NetworkException({required super.message, super.code, super.details});
}

class BluetoothException extends AppException {
  BluetoothException({required super.message, super.code, super.details});
}

class PermissionException extends AppException {
  PermissionException({required super.message, super.code, super.details});
}

class CryptoException extends AppException {
  CryptoException({required super.message, super.code, super.details});
}

class TransferException extends AppException {
  TransferException({required super.message, super.code, super.details});
}

class DatabaseException extends AppException {
  DatabaseException({required super.message, super.code, super.details});
}

class TimeoutException extends AppException {
  TimeoutException({required super.message, super.code, super.details});
}

class ValidationException extends AppException {
  ValidationException({required super.message, super.code, super.details});
}
