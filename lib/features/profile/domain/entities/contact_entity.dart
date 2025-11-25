import 'package:equatable/equatable.dart';

class ContactEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String? email;
  final String? avatarPath;
  final String? organization;
  final String? jobTitle;
  final String? website;
  final Map<String, String>? socialHandles;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ContactEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.email,
    this.avatarPath,
    this.organization,
    this.jobTitle,
    this.website,
    this.socialHandles,
    required this.createdAt,
    required this.updatedAt,
  });

  String get fullName => '$firstName $lastName'.trim();

  String get displayName {
    if (fullName.isNotEmpty) return fullName;
    if (phoneNumber != null && phoneNumber!.isNotEmpty) return phoneNumber!;
    if (email != null && email!.isNotEmpty) return email!;
    return 'Unknown';
  }

  bool get hasAvatar => avatarPath != null && avatarPath!.isNotEmpty;

  bool get hasPhone => phoneNumber != null && phoneNumber!.isNotEmpty;

  bool get hasEmail => email != null && email!.isNotEmpty;

  bool get isValid => fullName.isNotEmpty || hasPhone || hasEmail;

  ContactEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
    String? avatarPath,
    String? organization,
    String? jobTitle,
    String? website,
    Map<String, String>? socialHandles,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ContactEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      avatarPath: avatarPath ?? this.avatarPath,
      organization: organization ?? this.organization,
      jobTitle: jobTitle ?? this.jobTitle,
      website: website ?? this.website,
      socialHandles: socialHandles ?? this.socialHandles,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, firstName, lastName, phoneNumber, email, avatarPath, organization, jobTitle, website, socialHandles, createdAt, updatedAt];
}
