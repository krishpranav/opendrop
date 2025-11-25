import 'package:opendrop/core/constants/app_constants.dart';
import 'package:opendrop/core/utils/logger_util.dart';
import 'package:opendrop/features/profile/data/models/contact_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ContactLocalDataSource {
  static Database? _database;
  static const String _tableName = 'contacts';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    try {
      final databasesPath = await getDatabasesPath();
      final path = join(databasesPath, AppConstants.dbName);

      LoggerUtil.info('💾 Initializing database at: $path');

      return await openDatabase(path, version: AppConstants.dbVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
    } catch (e) {
      LoggerUtil.error('Error initializing database', e);
      rethrow;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      LoggerUtil.info('📊 Creating database tables...');

      await db.execute('''
        CREATE TABLE $_tableName (
          id TEXT PRIMARY KEY,
          firstName TEXT NOT NULL,
          lastName TEXT NOT NULL,
          phoneNumber TEXT,
          email TEXT,
          avatarPath TEXT,
          organization TEXT,
          jobTitle TEXT,
          website TEXT,
          socialHandles TEXT,
          createdAt INTEGER NOT NULL,
          updatedAt INTEGER NOT NULL
        )
      ''');

      LoggerUtil.info('✅ Database tables created successfully');
    } catch (e) {
      LoggerUtil.error('Error creating database tables', e);
      rethrow;
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    LoggerUtil.info('🔄 Upgrading database from v$oldVersion to v$newVersion');
  }

  Future<void> saveContact(ContactModel contact) async {
    try {
      final db = await database;
      await db.insert(_tableName, contact.toDatabase(), conflictAlgorithm: ConflictAlgorithm.replace);

      LoggerUtil.info('💾 Contact saved: ${contact.fullName}');
    } catch (e) {
      LoggerUtil.error('Error saving contact', e);
      rethrow;
    }
  }

  Future<ContactModel?> getUserProfile() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(_tableName, limit: 1, orderBy: 'createdAt ASC');

      if (maps.isEmpty) {
        LoggerUtil.info('ℹ️ No user profile found');
        return null;
      }

      final contact = ContactModel.fromDatabase(maps.first);
      LoggerUtil.info('User profile loaded: ${contact.fullName}');
      return contact;
    } catch (e) {
      LoggerUtil.error('Error getting user profile', e);
      rethrow;
    }
  }

  Future<ContactModel?> getContactById(String id) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(_tableName, where: 'id = ?', whereArgs: [id]);

      if (maps.isEmpty) {
        LoggerUtil.info('Contact not found: $id');
        return null;
      }

      return ContactModel.fromDatabase(maps.first);
    } catch (e) {
      LoggerUtil.error('Error getting contact by ID', e);
      rethrow;
    }
  }

  Future<void> updateContact(ContactModel contact) async {
    try {
      final db = await database;
      await db.update(_tableName, contact.toDatabase(), where: 'id = ?', whereArgs: [contact.id]);

      LoggerUtil.info('Contact updated: ${contact.fullName}');
    } catch (e) {
      LoggerUtil.error('Error updating contact', e);
      rethrow;
    }
  }

  Future<void> deleteContact(String id) async {
    try {
      final db = await database;
      await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);

      LoggerUtil.info('Contact deleted: $id');
    } catch (e) {
      LoggerUtil.error('Error deleting contact', e);
      rethrow;
    }
  }

  Future<List<ContactModel>> getAllContacts() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(_tableName, orderBy: 'createdAt DESC');

      LoggerUtil.info('Retrieved ${maps.length} contacts');

      return List.generate(maps.length, (i) => ContactModel.fromDatabase(maps[i]));
    } catch (e) {
      LoggerUtil.error('Error getting all contacts', e);
      rethrow;
    }
  }

  Future<bool> hasUserProfile() async {
    try {
      final db = await database;
      final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $_tableName'));

      return count != null && count > 0;
    } catch (e) {
      LoggerUtil.error('Error checking user profile', e);
      return false;
    }
  }

  Future<void> clearAllContacts() async {
    try {
      final db = await database;
      await db.delete(_tableName);
      LoggerUtil.info('🗑️ All contacts cleared');
    } catch (e) {
      LoggerUtil.error('Error clearing contacts', e);
      rethrow;
    }
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
      LoggerUtil.info('🔒 Database closed');
    }
  }
}
