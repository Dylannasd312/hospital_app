import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('hospital.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {

    // USUARIOS (LOGIN)
    await db.execute('''
      CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE,
        password TEXT,
        rol TEXT
      )
    ''');

    // USUARIO ADMIN POR DEFECTO
    await db.insert('usuarios', {
      'username': 'admin',
      'password': '1234',
      'rol': 'admin'
    });

    // PACIENTES
    await db.execute('''
      CREATE TABLE pacientes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT,
        edad INTEGER,
        genero TEXT
      )
    ''');

    // INVENTARIO
    await db.execute('''
      CREATE TABLE inventario (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT,
        cantidad INTEGER,
        descripcion TEXT
      )
    ''');

    // TURNOS
    await db.execute('''
      CREATE TABLE turnos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        paciente_id INTEGER,
        fecha TEXT,
        hora TEXT,
        medico TEXT
      )
    ''');

    // CAMAS
    await db.execute('''
      CREATE TABLE camas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        numero TEXT,
        estado TEXT
      )
    ''');

    // HISTORIA CLINICA
    await db.execute('''
      CREATE TABLE historia_clinica (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        paciente_id INTEGER,
        diagnostico TEXT,
        tratamiento TEXT,
        fecha TEXT
      )
    ''');
  }
}