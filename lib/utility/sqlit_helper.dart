import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ungpos/models/sqlite_model.dart';

class SQLiteHelper {
  final String nameDatabase = 'ungpos2.db';
  final int versionDatabase = 1;
  final String nameTable = 'productOrder';

  final String columnId = 'id';
  final String columnIdProduct = 'idproduct';
  final String columnName = 'name';
  final String columnPrice = 'price';
  final String columnAmount = 'amount';
  final String columnSum = 'sum';

  SQLiteHelper() {
    initialDatabase();
  }

  Future<Null> initialDatabase() async {
    await openDatabase(
      join(await getDatabasesPath(), nameDatabase),
      onCreate: (db, version) => db.execute(
          'CREATE TABLE $nameTable (id INTEGER PRIMARY KEY, $columnIdProduct TEXT, $columnName TEXT, $columnPrice TEXT, $columnAmount TEXT, $columnSum TEXT)'),
      version: versionDatabase,
    );
  }

  Future<Database> connectedDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

  Future<Null> insertValueToSQLite(SQLModel sqlModel) async {
    Database database = await connectedDatabase();
    try {
      database.insert(
        nameTable,
        sqlModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {}
  }

  Future<List<SQLModel>> readSQLite() async {
    Database database = await connectedDatabase();
    List<SQLModel> sqlModels = [];

    List<Map<String, dynamic>> maps = await database.query(nameTable);
    for (var item in maps) {
      SQLModel model = SQLModel.fromMap(item);
      sqlModels.add(model);
    }

    return sqlModels;
  }

  Future<Null> deleteSQLiteById(int id) async {
    Database database = await connectedDatabase();
    try {
      await database.delete(nameTable, where: '$columnId = $id');
    } catch (e) {}
  }

  Future<Null> emptySQLite() async {
    Database database = await connectedDatabase();
    try {
      await database.delete(nameTable);
    } catch (e) {}
  }
} // Class
