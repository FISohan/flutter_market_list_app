import 'dart:math';

import 'package:get/get.dart';
import 'package:market_list/Models/ItemModel.dart';
import 'package:market_list/Services/DBHandler.dart';

class AddItemService extends GetxController {
  DbHandler _dbHandler = DbHandler();

  List<ItemModel> items = <ItemModel>[].obs;
  List<ItemModel> itemsFromDB = [];

  int id = 0;
  int groupId = 0;
  int isDone = 0;
  int amountPerItem = 0;
  String itemName = '';
  String itemQuantity = '';

  Future<void>getItemsFromDB()async{
    itemsFromDB = await _dbHandler.getData();
  }

  void addItem() {
    ItemModel _item = ItemModel(
        id: id,
        groupId: groupId,
        isDone: isDone,
        amountPerItem: amountPerItem,
        itemName: itemName,
        itemQuantity: itemQuantity);
    items.add(_item);
  }

  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    await getItemsFromDB();
  }
}
