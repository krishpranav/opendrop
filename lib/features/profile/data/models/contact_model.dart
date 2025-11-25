import 'dart:convert';
import 'package:opendrop/features/profile/domain/entities/contact_entity.dart';

class ContactModel extends ContactEntity {
  const ContactModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    super.phoneNumber,
    super.email,
    super.avatarPath,
    super.organization,
    super.jobTitle,
    super.website,
    super.socialHandles,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ContactModel.fromEntity(ContactEntity entity) {
    return ContactModel(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      phoneNumber: entity.phoneNumber,
      email: entity.email,
      avatarPath: entity.avatarPath,
      organization: entity.organization,
      jobTitle: entity.jobTitle,
      website: entity.website,
      socialHandles: entity.socialHandles,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      avatarPath: json['avatarPath'] as String?,
      organization: json['organization'] as String?,
      jobTitle: json['jobTitle'] as String?,
      website: json['website'] as String?,
      socialHandles: json['socialHandles'] != null ? Map<String, String>.from(json['socialHandles'] as Map) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'avatarPath': avatarPath,
      'organization': organization,
      'jobTitle': jobTitle,
      'website': website,
      'socialHandles': socialHandles,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  String toJsonString() => json.encode(toJson());

  factory ContactModel.fromJsonString(String jsonString) {
    return ContactModel.fromJson(json.decode(jsonString));
  }

  Map<String, dynamic> toDatabase() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'avatarPath': avatarPath,
      'organization': organization,
      'jobTitle': jobTitle,
      'website': website,
      'socialHandles': socialHandles != null ? json.encode(socialHandles) : null,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory ContactModel.fromDatabase(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      phoneNumber: map['phoneNumber'] as String?,
      email: map['email'] as String?,
      avatarPath: map['avatarPath'] as String?,
      organization: map['organization'] as String?,
      jobTitle: map['jobTitle'] as String?,
      website: map['website'] as String?,
      socialHandles: map['socialHandles'] != null ? Map<String, String>.from(json.decode(map['socialHandles'])) : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  @override
  ContactModel copyWith({
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
    return ContactModel(
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
}
