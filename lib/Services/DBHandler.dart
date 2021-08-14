import 'package:market_list/Models/ItemModel.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHandler {
  //initialize DataBase
  Future<Database> initDB() async {
    final String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'marketList.db'),
      onCreate: (database, version) async {
        await database.execute(
            "CREATE TABLE marketList(id INTEGER PRIMARY KEY AUTOINCREMENT, groupId INTEGER NOT NULL,isDone INTEGER NOT NULL, amountPerItem INTEGER NOT NULL, itemName TEXT NOT NULL, itemQuantity TEXT NOT NULL)");
      },
      version: 1,
    );
  }

  Future<List<ItemModel>> getData() async {
    Database db = await initDB();
    final List<Map<String, Object?>> queryResult = await db.query('marketList');
    return queryResult.map((e) => ItemModel.fromMap(e)).toList();
  }

  Future<int> insertData(ItemModel data) async {
    Database db = await initDB();
    print('map>>${data.toMap()}');
    int res = 0;
    res = await db.insert('marketList', data.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  Future<void> deleteList(int id) async {
    final db = await initDB();
    await db.delete(
      'marketList',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> updateList(ItemModel updatedList) async {
    final db = await initDB();
    await db.update('marketList', updatedList.toMap(),
        where: "id = ?", whereArgs: [updatedList.id]);
  }
}
