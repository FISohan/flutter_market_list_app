import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_list/Services/HomePageService.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<HomePageService>(
        init: HomePageService(),
        builder: (c)=>Container(
      child: Center(child: Text('Home page${c.items.length}'),),
    ));
  }
}
