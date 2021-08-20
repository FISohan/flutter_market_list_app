import 'package:get/get.dart';
import 'package:market_list/Models/ItemModel.dart';
import 'package:market_list/Services/DBHandler.dart';

class ArchivePageService extends GetxController{
  DbHandler _dbHandler = DbHandler();
  List<ItemModel>items = <ItemModel>[].obs;
  void _initItemData()async{
    items.assignAll(await _dbHandler.getData());
  }
  void deleteItem(int groupId)async{
     await _dbHandler.deleteData(groupId);
     _initItemData();
  }
  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    _initItemData();
   print(items.length);
  }
}