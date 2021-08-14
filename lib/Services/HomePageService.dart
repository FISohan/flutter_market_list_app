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

  @override
  void onInit() async{
    super.onInit();
    await initDataFromDBtoItems();
  }
}
