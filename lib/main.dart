import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_list/Pages/AddItemPage.dart';
import 'package:market_list/Services/HomePageService.dart';
import 'package:market_list/Services/TabService.dart';

import 'Pages/ArchivePage.dart';
import 'Pages/HomePage.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  HomePageService _homePageService = Get.put(HomePageService());
  final _tabs = [HomePage(),ArchivePage()];
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        routingCallback: (routing)async{
          if(routing!.current == '/'){
           await _homePageService.initDataFromDBtoItems();
            print('????iam in home page');
          }
        },
        home: GetBuilder<TabService>(
          init: TabService(),
          builder: (c)=>Scaffold(
            backgroundColor: Colors.white60,
            body: _tabs[c.index],
            floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
            floatingActionButton: FloatingActionButton(

              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.add,),
              onPressed: () {
                Get.to(AddItemPage());
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.grey,
              selectedItemColor: Colors.blueGrey,
              currentIndex: c.index,
              onTap: (i){
                c.goPage(i);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      size: 30,
                    ),
                    label: 'HOME'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive,
                      size: 30,
                    ),
                    label: 'ARCHIVE')
              ],
            ),
          ),
        )
    );

  }
}
