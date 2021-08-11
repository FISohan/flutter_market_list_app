import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_list/Pages/AddItemPage.dart';
import 'package:market_list/Services/TabService.dart';

import 'Pages/ArchivePage.dart';
import 'Pages/HomePage.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _tabs = [HomePage(),ArchivePage()];
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        home: GetBuilder<TabService>(
          init: TabService(),
          builder: (c)=>Scaffold(
            body: _tabs[c.index],
            floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Get.to(AddItemPage());
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
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
                    label: 'HOME${c.index}'),
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
