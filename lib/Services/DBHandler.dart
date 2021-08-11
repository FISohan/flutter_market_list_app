import 'package:market_list/Models/ItemModel.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHandler extends GetxController {
  //initialize DataBase
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'marketList.db'),
      onCreate: (database, version) async {
        await database.execute(
            "CREATE TABLE marketList(id INTEGER PRIMARY KEY AUTOINCREMENT, isDone INTEGER NOT NULL,groupId INTEGER NOT NULL,itemName TEXT NOT NULL, itemQuantity TEXT NOT NULL, amountOfPerItem INTEGER NOT NULL)");
      },
      version: 1,
    );
  }

  Future<List<ItemModel>> getList() async {
    Database db = await initDB();
    final List<Map<String, Object?>> queryResult = await db.query('bazarlist');
    return queryResult.map((e) => ItemModel.fromMap(e)).toList();
  }

  Future<int> insertList(ItemModel list) async {
    Database db = await initDB();
    int res = 0;
    res = await db.insert('bazarlist', list.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  Future<void> deleteList(int id) async {
    final db = await initDB();
    await db.delete(
      'bazarlist',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> updateList(ItemModel updatedList) async {
    final db = await initDB();
    await db.update('bazarlist', updatedList.toMap(),
        where: "id = ?", whereArgs: [updatedList.id]);
  }
}