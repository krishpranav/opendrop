import 'package:dartz/dartz.dart';
import 'package:opendrop/core/errors/failures.dart';
import '../entities/contact_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ContactEntity>> getUserProfile();

  Future<Either<Failure, ContactEntity>> createUserProfile(ContactEntity contact);

  Future<Either<Failure, ContactEntity>> updateUserProfile(ContactEntity contact);

  Future<Either<Failure, void>> deleteUserProfile();

  Future<Either<Failure, bool>> hasUserProfile();

  Future<Either<Failure, String>> generateVCard(ContactEntity contact);

  Future<Either<Failure, String>> generateVCardWithAvatar(ContactEntity contact, String avatarPath);

  Future<Either<Failure, Map<String, dynamic>>> parseVCard(String vCardString);
}
