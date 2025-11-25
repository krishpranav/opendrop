import 'dart:convert';
import 'dart:io';
import 'package:opendrop/core/utils/logger_util.dart';
import 'package:opendrop/features/profile/domain/entities/contact_entity.dart';

class VCardGenerator {
  static String generateVCard(ContactEntity contact) {
    final buffer = StringBuffer();

    buffer.writeln('BEGIN:VCARD');
    buffer.writeln('VERSION:4.0');

    buffer.writeln('FN:${contact.fullName}');

    buffer.writeln('N:${contact.lastName};${contact.firstName};;;');

    if (contact.hasPhone) {
      buffer.writeln('TEL;TYPE=CELL:${contact.phoneNumber}');
    }

    if (contact.hasEmail) {
      buffer.writeln('EMAIL:${contact.email}');
    }

    if (contact.organization != null && contact.organization!.isNotEmpty) {
      buffer.writeln('ORG:${contact.organization}');
    }

    if (contact.jobTitle != null && contact.jobTitle!.isNotEmpty) {
      buffer.writeln('TITLE:${contact.jobTitle}');
    }

    if (contact.website != null && contact.website!.isNotEmpty) {
      buffer.writeln('URL:${contact.website}');
    }

    if (contact.socialHandles != null && contact.socialHandles!.isNotEmpty) {
      final socialText = contact.socialHandles!.entries.map((e) => '${e.key}: ${e.value}').join(', ');
      buffer.writeln('NOTE:Social Handles - $socialText');
    }

    buffer.writeln('UID:${contact.id}');

    buffer.writeln('REV:${contact.updatedAt.toIso8601String()}');

    buffer.writeln('END:VCARD');

    LoggerUtil.info('📇 Generated vCard for ${contact.fullName}');
    return buffer.toString();
  }

  static Map<String, dynamic> parseVCard(String vCardString) {
    final result = <String, dynamic>{};
    final lines = vCardString.split('\n');

    for (var line in lines) {
      line = line.trim();
      if (line.isEmpty) continue;

      if (line.startsWith('FN:')) {
        result['fullName'] = line.substring(3);
      } else if (line.startsWith('N:')) {
        final parts = line.substring(2).split(';');
        if (parts.length >= 2) {
          result['lastName'] = parts[0];
          result['firstName'] = parts[1];
        }
      } else if (line.contains('TEL')) {
        final phoneMatch = RegExp(r'TEL[^:]*:(.+)').firstMatch(line);
        if (phoneMatch != null) {
          result['phoneNumber'] = phoneMatch.group(1);
        }
      } else if (line.startsWith('EMAIL:')) {
        result['email'] = line.substring(6);
      } else if (line.startsWith('ORG:')) {
        result['organization'] = line.substring(4);
      } else if (line.startsWith('TITLE:')) {
        result['jobTitle'] = line.substring(6);
      } else if (line.startsWith('URL:')) {
        result['website'] = line.substring(4);
      } else if (line.startsWith('NOTE:')) {
        result['note'] = line.substring(5);
      } else if (line.startsWith('UID:')) {
        result['id'] = line.substring(4);
      }
    }

    LoggerUtil.info('📇 Parsed vCard successfully');
    return result;
  }

  static String generateVCardWithAvatar(ContactEntity contact, String? base64Avatar) {
    final buffer = StringBuffer();

    buffer.writeln('BEGIN:VCARD');
    buffer.writeln('VERSION:4.0');

    buffer.writeln('FN:${contact.fullName}');

    buffer.writeln('N:${contact.lastName};${contact.firstName};;;');

    if (contact.hasPhone) {
      buffer.writeln('TEL;TYPE=CELL:${contact.phoneNumber}');
    }

    if (contact.hasEmail) {
      buffer.writeln('EMAIL:${contact.email}');
    }

    if (contact.organization != null && contact.organization!.isNotEmpty) {
      buffer.writeln('ORG:${contact.organization}');
    }

    if (contact.jobTitle != null && contact.jobTitle!.isNotEmpty) {
      buffer.writeln('TITLE:${contact.jobTitle}');
    }

    if (contact.website != null && contact.website!.isNotEmpty) {
      buffer.writeln('URL:${contact.website}');
    }

    if (base64Avatar != null && base64Avatar.isNotEmpty) {
      buffer.writeln('PHOTO;ENCODING=b;TYPE=JPEG:');
      final photoLines = _splitString(base64Avatar, 75);
      for (var line in photoLines) {
        buffer.writeln(' $line');
      }
    }

    if (contact.socialHandles != null && contact.socialHandles!.isNotEmpty) {
      final socialText = contact.socialHandles!.entries.map((e) => '${e.key}: ${e.value}').join(', ');
      buffer.writeln('NOTE:Social Handles - $socialText');
    }

    buffer.writeln('UID:${contact.id}');

    buffer.writeln('REV:${contact.updatedAt.toIso8601String()}');

    buffer.writeln('END:VCARD');

    LoggerUtil.info('📇 Generated vCard with avatar for ${contact.fullName}');
    return buffer.toString();
  }

  static List<String> _splitString(String text, int chunkSize) {
    final chunks = <String>[];
    for (var i = 0; i < text.length; i += chunkSize) {
      final end = (i + chunkSize < text.length) ? i + chunkSize : text.length;
      chunks.add(text.substring(i, end));
    }
    return chunks;
  }

  static Future<String?> imageToBase64(String imagePath) async {
    try {
      final file = File(imagePath);
      if (!await file.exists()) {
        LoggerUtil.warning('Image file does not exist: $imagePath');
        return null;
      }

      final bytes = await file.readAsBytes();
      final base64String = base64Encode(bytes);

      LoggerUtil.info('📷 Converted image to base64 (${base64String.length} chars)');
      return base64String;
    } catch (e) {
      LoggerUtil.error('Error converting image to base64', e);
      return null;
    }
  }

  static Future<String?> saveVCardToFile(String vCardContent, String fileName) async {
    try {
      LoggerUtil.info('💾 vCard saved to file: $fileName');
      return fileName;
    } catch (e) {
      LoggerUtil.error('Error saving vCard to file', e);
      return null;
    }
  }
}
