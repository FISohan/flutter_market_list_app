import 'package:get/get.dart';

class TabService extends GetxController{
    int index = 0;
    void goPage(int i){
      index = i;
      printInfo(info: '---$index');
      update();
    }
}