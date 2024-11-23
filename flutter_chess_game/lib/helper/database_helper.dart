import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'user_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL
      )
    ''');
  }

  // Metodo para registrar um novo usuário
  Future<bool> registerUser(String username, String email, String password) async {
    try {
      final db = await database;

      // Verifica se o email já está registrado
      final existingUser = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [email],
      );

      if (existingUser.isNotEmpty) {
        return false; // Usuário já existe
      }

      await db.insert('users', {
        'username': username,
        'email': email,
        'password': password,
      });
      return true; 
    } catch (e) {
      print('Erro ao registrar usuário: $e');
      return false; 
    }
  }

  // Mwtodo para validar o login
  Future<bool> validateUser(String email, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty; // Retorna true se encontrar o usuário
  }
}
