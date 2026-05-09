import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static final DatabaseHelper instance =
      DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {

    if (_database != null) {
      return _database!;
    }

    _database =
        await _initDB('hospital.db');

    return _database!;
  }

  Future<Database> _initDB(
    String filePath,
  ) async {

    final dbPath =
        await getDatabasesPath();

    final path =
        join(dbPath, filePath);

    return await openDatabase(

      path,

      version: 3,

      onCreate: _createDB,

      onUpgrade: _onUpgrade,

      onOpen: (db) async {

        await db.execute(
          'PRAGMA foreign_keys = ON',
        );
      },
    );
  }

  Future _createDB(
    Database db,
    int version,
  ) async {

    // =========================
    // USUARIOS
    // =========================

    await db.execute('''
      CREATE TABLE usuarios (

        id INTEGER PRIMARY KEY AUTOINCREMENT,

        username TEXT UNIQUE,

        password TEXT,

        rol TEXT,

        activo INTEGER DEFAULT 1
      )
    ''');

    await db.insert('usuarios', {

      'username': 'admin',

      'password': '1234',

      'rol': 'admin',
    });

    // =========================
    // PACIENTES
    // =========================

    await db.execute('''
      CREATE TABLE pacientes (

        id INTEGER PRIMARY KEY AUTOINCREMENT,

        nombre TEXT,

        apellido TEXT,

        ci TEXT,

        fecha_nacimiento TEXT,

        genero TEXT,

        telefono TEXT,

        direccion TEXT
      )
    ''');

    // =========================
    // MEDICOS
    // =========================

    await db.execute('''
      CREATE TABLE medicos (

        id INTEGER PRIMARY KEY AUTOINCREMENT,

        nombre TEXT,

        especialidad TEXT,

        telefono TEXT
      )
    ''');

    // =========================
    // TURNOS
    // =========================

    await db.execute('''
      CREATE TABLE turnos (

        id INTEGER PRIMARY KEY AUTOINCREMENT,

        paciente_id INTEGER,

        medico_id INTEGER,

        fecha TEXT,

        hora TEXT,

        estado TEXT,

        FOREIGN KEY (paciente_id)
        REFERENCES pacientes(id),

        FOREIGN KEY (medico_id)
        REFERENCES medicos(id)
      )
    ''');

    // =========================
    // CAMAS
    // =========================

    await db.execute('''
      CREATE TABLE camas (

        id INTEGER PRIMARY KEY AUTOINCREMENT,

        numero TEXT,

        estado TEXT,

        tipo TEXT
      )
    ''');

    await insertarCamasIniciales(db);

    // =========================
    // HOSPITALIZACION
    // =========================

    await db.execute('''
      CREATE TABLE hospitalizacion (

        id INTEGER PRIMARY KEY AUTOINCREMENT,

        paciente_id INTEGER,

        cama_id INTEGER,

        fecha_ingreso TEXT,

        fecha_salida TEXT,

        estado TEXT,

        FOREIGN KEY (paciente_id)
        REFERENCES pacientes(id),

        FOREIGN KEY (cama_id)
        REFERENCES camas(id)
      )
    ''');

    // =========================
    // HISTORIA CLINICA
    // =========================

    await db.execute('''
      CREATE TABLE historia_clinica (

        id INTEGER PRIMARY KEY AUTOINCREMENT,

        paciente_id INTEGER,

        medico_id INTEGER,

        diagnostico TEXT,

        tratamiento TEXT,

        fecha TEXT,

        FOREIGN KEY (paciente_id)
        REFERENCES pacientes(id),

        FOREIGN KEY (medico_id)
        REFERENCES medicos(id)
      )
    ''');

    // =========================
    // INVENTARIO
    // =========================

    await db.execute('''
      CREATE TABLE inventario (

        id INTEGER PRIMARY KEY AUTOINCREMENT,

        nombre TEXT,

        tipo TEXT,

        cantidad INTEGER,

        stock_minimo INTEGER,

        descripcion TEXT
      )
    ''');

    // =========================
    // MOVIMIENTOS INVENTARIO
    // =========================

    await db.execute('''
      CREATE TABLE movimientos_inventario (

        id INTEGER PRIMARY KEY AUTOINCREMENT,

        inventario_id INTEGER,

        tipo TEXT,

        cantidad INTEGER,

        fecha TEXT,

        FOREIGN KEY (inventario_id)
        REFERENCES inventario(id)
      )
    ''');

    // =========================
    // INDICES
    // =========================

    await db.execute('''
      CREATE INDEX idx_turnos_paciente
      ON turnos(paciente_id)
    ''');

    await db.execute('''
      CREATE INDEX idx_historia_paciente
      ON historia_clinica(paciente_id)
    ''');
  }

  // =========================
  // ACTUALIZACIONES
  // =========================

  Future _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {

    if (oldVersion < 3) {

      await insertarCamasIniciales(db);
    }
  }

  // =========================
  // INSERTAR CAMAS AUTOMATICAS
  // =========================

  Future<void> insertarCamasIniciales(
    Database db,
  ) async {

    final camas =
        await db.query('camas');

    if (camas.isNotEmpty) return;

    // =========================
    // OBSERVACION
    // =========================

    for (int i = 1; i <= 20; i++) {

      await db.insert('camas', {

        'numero':
            'OBS-${i.toString().padLeft(2, '0')}',

        'estado': 'Disponible',

        'tipo': 'Observación',
      });
    }

    // =========================
    // INTERMEDIA
    // =========================

    for (int i = 1; i <= 10; i++) {

      await db.insert('camas', {

        'numero':
            'INT-${i.toString().padLeft(2, '0')}',

        'estado': 'Disponible',

        'tipo': 'Intermedia',
      });
    }

    // =========================
    // INTENSIVA
    // =========================

    for (int i = 1; i <= 5; i++) {

      await db.insert('camas', {

        'numero':
            'UCI-${i.toString().padLeft(2, '0')}',

        'estado': 'Disponible',

        'tipo': 'Intensiva',
      });
    }
  }
}