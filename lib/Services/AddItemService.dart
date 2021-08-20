
import 'package:get/get.dart';
import 'package:market_list/Models/ItemModel.dart';
import 'package:market_list/Services/DBHandler.dart';

class AddItemService extends GetxController {
  DbHandler _dbHandler = DbHandler();

  List<ItemModel> items = <ItemModel>[].obs;
  List<ItemModel> itemsFromDB = [];

  int id = 0;
  int groupId = 1;
  int isDone = 0;
  int amountPerItem = 0;
  String itemName = '';
  String itemQuantity = '';

  Future<void>getItemsFromDB()async{
    itemsFromDB = await _dbHandler.getData();
    itemsFromDB.sort((a,b)=>a.groupId.compareTo(b.groupId));
  }

  void addItem() {
    id++;
    groupId = _maxGroupIdFromDB() + 1;
    ItemModel _item = ItemModel(
        id: id,
        groupId: groupId,
        isDone: isDone,
        amountPerItem: amountPerItem,
        itemName: itemName,
        itemQuantity: itemQuantity,time: DateTime.now().toLocal().toString());
    items.add(_item);
  }

  int _maxGroupIdFromDB(){
    if(itemsFromDB.length != 0){
      print('${itemsFromDB.last.id}');
      return itemsFromDB.last.groupId;
    }else{
      return 0;
    }
  }

  Future<void>saveItemsToDB()async{
    for(ItemModel item in items){
      await _dbHandler.insertData(item);
      print(_dbHandler.insertData(item));
    }
  }
  void removeItemFromItems(int index){
    items.removeAt(index);
    print('>>$index');
  }
  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    await getItemsFromDB();
    id = (itemsFromDB.length != 0) ? itemsFromDB.last.id : 0;

  }
}
