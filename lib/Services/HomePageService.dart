import 'package:get/get.dart';
import 'package:market_list/Models/ItemModel.dart';
import 'package:market_list/Services/DBHandler.dart';

class HomePageService extends GetxController {
  DbHandler _dbHandler = DbHandler();
  List<ItemModel> items = <ItemModel>[].obs;

  Future<void> initDataFromDBtoItems() async {
    List<ItemModel> itemsFromDB = await _dbHandler.getData();
    items.assignAll(itemsFromDB);
    items.sort((a, b) => a.groupId.compareTo(b.groupId));
    sortByIsDone();
  }

  Future<void> updateDb(ItemModel updatedItem) async {
    await _dbHandler.updateData(updatedItem);
    await initDataFromDBtoItems();
  }

  sortByIsDone() {
    items.removeWhere((element) => isAllDoneInGroup(element.groupId) == true);
  }

  String totalAmount(int groupId) {
    int total = 0;
    for (int i = 0; i < items.length; i++) {
      if (items[i].groupId == groupId) {
        total += items[i].amountPerItem;
      }
    }
    return total.toString();
  }

 bool checkIsSorted(int id){
    int a = 0;
    int b = 0;
    for(int i = 0;i<items.length;i++){
      if(items[i].groupId == id){
        a++;
        if(items[i].isDone == 1){
          b++;
        }
      }
    }
    return a - b == 1;
  }

  bool isAllDoneInGroup(int id) {
    for (ItemModel item in items) {
      if (item.groupId == id) {
        if (item.isDone == 0) {
          return false;
        }
      }
    }
    return true;
  }

  @override
  void onInit() async {
    super.onInit();
    await initDataFromDBtoItems();
  }
}
