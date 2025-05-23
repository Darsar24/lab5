import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:lab5/db/calculation.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();
  late Database _database;

  factory DatabaseProvider() => _instance;

  DatabaseProvider._internal();

  Future<Database> get database async {
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, 'calculator.db');

  return await openDatabase(
    path,
    version: 1,
    onCreate: _createDB,
  );
}
  Future<void> _createDB(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE calculations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        a REAL NOT NULL,
        b REAL NOT NULL,
        c REAL NOT NULL,
        result TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertCalculation(Calculation calculation) async {
    final db = await database;
    return await db.insert('calculations', calculation.toMap());
  }

  Future<List<Calculation>> getAllCalculations() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('calculations');
    return List.generate(maps.length, (i) => Calculation.fromMap(maps[i]));
  }
}