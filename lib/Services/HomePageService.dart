import 'package:get/get.dart';
import 'package:market_list/Models/ItemModel.dart';
import 'package:market_list/Services/DBHandler.dart';

class HomePageService extends GetxController {
  DbHandler _dbHandler = DbHandler();
  List<ItemModel> items = <ItemModel>[].obs;

  Future<void> initDataFromDBtoItems()async{
    List<ItemModel> itemsFromDB = await _dbHandler.getData();
   //assign to DB
    items.assignAll(itemsFromDB);
    //sort the list by group id
    items.sort((a,b)=>a.groupId.compareTo(b.groupId));
  }

  Future<void> updateDb(ItemModel updatedItem) async{
      await _dbHandler.updateData(updatedItem);
      await initDataFromDBtoItems();
  }

  String totalAmount(int groupId){
    int total = 0;
    for(int i = 0;i < items.length;i++){
      if(items[i].groupId == groupId){
        total += items[i].amountPerItem;
      }
    }
    print('>>>>$total $groupId');
    return total.toString();
  }

  @override
  void onInit() async{
    super.onInit();
    await initDataFromDBtoItems();
  }
}
