import 'package:dartz/dartz.dart';
import 'package:opendrop/core/errors/exceptions.dart';
import 'package:opendrop/core/errors/failures.dart';
import 'package:opendrop/core/utils/logger_util.dart';
import 'package:opendrop/features/profile/data/datasources/contact_local_datasource.dart';
import 'package:opendrop/features/profile/data/datasources/vcard_generator.dart';
import 'package:opendrop/features/profile/data/models/contact_model.dart';
import 'package:opendrop/features/profile/domain/entities/contact_entity.dart';
import 'package:opendrop/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ContactLocalDataSource localDataSource;

  ProfileRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, ContactEntity>> getUserProfile() async {
    try {
      final contact = await localDataSource.getUserProfile();

      if (contact == null) {
        return Left(DatabaseFailure(message: 'No user profile found', code: 'PROFILE_NOT_FOUND'));
      }

      return Right(contact);
    } on DatabaseException catch (e) {
      LoggerUtil.error('Database error getting user profile', e);
      return Left(DatabaseFailure(message: e.message, code: e.code));
    } catch (e) {
      LoggerUtil.error('Unexpected error getting user profile', e);
      return Left(UnknownFailure(message: 'Failed to get user profile: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, ContactEntity>> createUserProfile(ContactEntity contact) async {
    try {
      final contactModel = ContactModel.fromEntity(contact);
      await localDataSource.saveContact(contactModel);

      LoggerUtil.info('User profile created successfully');
      return Right(contactModel);
    } on DatabaseException catch (e) {
      LoggerUtil.error('Database error creating user profile', e);
      return Left(DatabaseFailure(message: e.message, code: e.code));
    } catch (e) {
      LoggerUtil.error('Unexpected error creating user profile', e);
      return Left(UnknownFailure(message: 'Failed to create user profile: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, ContactEntity>> updateUserProfile(ContactEntity contact) async {
    try {
      final contactModel = ContactModel.fromEntity(contact);
      await localDataSource.updateContact(contactModel);

      LoggerUtil.info('User profile updated successfully');
      return Right(contactModel);
    } on DatabaseException catch (e) {
      LoggerUtil.error('Database error updating user profile', e);
      return Left(DatabaseFailure(message: e.message, code: e.code));
    } catch (e) {
      LoggerUtil.error('Unexpected error updating user profile', e);
      return Left(UnknownFailure(message: 'Failed to update user profile: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUserProfile() async {
    try {
      final profile = await localDataSource.getUserProfile();

      if (profile == null) {
        return Left(DatabaseFailure(message: 'No user profile to delete', code: 'PROFILE_NOT_FOUND'));
      }

      await localDataSource.deleteContact(profile.id);

      LoggerUtil.info('User profile deleted successfully');
      return const Right(null);
    } on DatabaseException catch (e) {
      LoggerUtil.error('Database error deleting user profile', e);
      return Left(DatabaseFailure(message: e.message, code: e.code));
    } catch (e) {
      LoggerUtil.error('Unexpected error deleting user profile', e);
      return Left(UnknownFailure(message: 'Failed to delete user profile: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> hasUserProfile() async {
    try {
      final hasProfile = await localDataSource.hasUserProfile();
      return Right(hasProfile);
    } catch (e) {
      LoggerUtil.error('Error checking user profile', e);
      return Left(UnknownFailure(message: 'Failed to check user profile: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, String>> generateVCard(ContactEntity contact) async {
    try {
      final vCard = VCardGenerator.generateVCard(contact);
      return Right(vCard);
    } catch (e) {
      LoggerUtil.error('Error generating vCard', e);
      return Left(UnknownFailure(message: 'Failed to generate vCard: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, String>> generateVCardWithAvatar(ContactEntity contact, String avatarPath) async {
    try {
      final base64Avatar = await VCardGenerator.imageToBase64(avatarPath);
      final vCard = VCardGenerator.generateVCardWithAvatar(contact, base64Avatar);
      return Right(vCard);
    } catch (e) {
      LoggerUtil.error('Error generating vCard with avatar', e);
      return Left(UnknownFailure(message: 'Failed to generate vCard with avatar: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> parseVCard(String vCardString) async {
    try {
      final parsed = VCardGenerator.parseVCard(vCardString);
      return Right(parsed);
    } catch (e) {
      LoggerUtil.error('Error parsing vCard', e);
      return Left(UnknownFailure(message: 'Failed to parse vCard: ${e.toString()}'));
    }
  }
}
