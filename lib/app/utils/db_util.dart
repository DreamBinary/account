import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

enum DBTable {
  tConsume('consumeTable'),
  tBook('bookTable'),
  tMultiBook('multiBookTable'),
  tGoal('goalTable');

  const DBTable(this.name);

  final String name;
}

class DBUtil {
  static Database? _database;
  static const String _databaseName = "account.db";

  get database => _database;

  static Future<void> init() async {
    if (_database == null) {
      var dbPath = await getDatabasesPath();
      var path = join(dbPath, _databaseName);
      _database = await openDatabase(path, version: 1, onCreate: _onCreate);
    }
  }

  static Future _onCreate(Database db, int version) async {
    String consumeSQL = '''
          CREATE TABLE ${DBTable.tConsume.name}(
          consumptionId INTEGER PRIMARY KEY AUTOINCREMENT,
          consumptionName TEXT,
          description TEXT,
          amount REAL,
          typeId INTEGER,
          store TEXT,
          consumeTime TEXT,
          credential TEXT
          )
          ''';

    String bookSQL = '''
          CREATE TABLE ${DBTable.tBook.name}(
          ledgerId INTEGER PRIMARY KEY AUTOINCREMENT,
          userId INTEGER,
          ledgerName TEXT,
          coverMsg TEXT,
          createTime TEXT,
          updateTime TEXT
          )
          ''';

    String multiBookSQL = '''
          CREATE TABLE ${DBTable.tMultiBook.name}(
          multiLedgerId INTEGER PRIMARY KEY AUTOINCREMENT,
          multiLedgerName TEXT,
          description TEXT,
          password TEXT,
          modifyTime TEXT
          )
          ''';

    String goalSQL = '''
          CREATE TABLE ${DBTable.tGoal.name}(
          goalId INTEGER PRIMARY KEY AUTOINCREMENT,
          goalName TEXT,
          userId INTEGER,
          money REAL,
          createDate TEXT,
          deadline TEXT,
          savedMoney REAL
          )
          ''';

    await db.execute(consumeSQL);
    await db.execute(bookSQL);
    await db.execute(multiBookSQL);
    await db.execute(goalSQL);
  }

  // show table
  static Future<List<Map<String, dynamic>>> showTables() async {
    var tables =
        await _database!.rawQuery('SELECT * FROM sqlite_master ORDER BY name;');
    return tables;
  }

  // insert
  static Future<int> insert(String table, Map<String, dynamic> values) async {
    return await _database!.insert(table, values, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // delete
  static Future<int> delete(
      String table, String where, List<dynamic> whereArgs) async {
    return await _database!.delete(table, where: where, whereArgs: whereArgs);
  }

  // update
  static Future<int> update(String table, Map<String, dynamic> values,
      String where, List<dynamic> whereArgs) async {
    return await _database!
        .update(table, values, where: where, whereArgs: whereArgs);
  }

  // query
  static Future<List<Map<String, dynamic>>> query(String table,
      {bool distinct = false,
      List<String>? columns,
      String? where,
      List<dynamic>? whereArgs,
      String? groupBy,
      String? having,
      String? orderBy,
      int? limit,
      int? offset}) async {
    return await _database!.query(
      table,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  // close
  static Future<void> close() async {
    await _database!.close();
    _database = null;
  }

  // isOpen
  static bool isOpen() {
    return _database!.isOpen;
  }
}
