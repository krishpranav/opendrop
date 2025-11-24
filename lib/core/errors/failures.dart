import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];

  @override
  String toString() => 'Failure: $message ${code != null ? '(Code: $code)' : ''}';
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code});
}

class BluetoothFailure extends Failure {
  const BluetoothFailure({required super.message, super.code});
}

class PermissionFailure extends Failure {
  const PermissionFailure({required super.message, super.code});
}

class CryptoFailure extends Failure {
  const CryptoFailure({required super.message, super.code});
}

class TransferFailure extends Failure {
  const TransferFailure({required super.message, super.code});
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({required super.message, super.code});
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({required super.message, super.code});
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, super.code});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});
}

class UnknownFailure extends Failure {
  const UnknownFailure({super.message = 'An unknown error occurred', super.code});
}
