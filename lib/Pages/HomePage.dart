import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_list/Models/ItemModel.dart';
import 'package:market_list/Services/HomePageService.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<HomePageService>(
        init: HomePageService(),
        builder: (c) => Container(
              child: ListView(
                children: (c.items.length == 0)
                    ? [
                        Center(
                          child: Text('No data'),
                        )
                      ]
                    : _listViewChildren(c.items),
              ),
            ));
  }

  //listView children
  List<Widget> _listViewChildren(List<ItemModel> itemList) {
    List<Widget> children = [];
    List<Widget> containerListChildren = [];

    int groupId = itemList.first.groupId;
    int itemListLength = itemList.length;

    for (int i = 0; i < itemListLength; i++) {


      if (groupId != itemList[i].groupId) {
        groupId = itemList[i].groupId;
        children.add(_listViewChidrenContainer(containerListChildren));
        containerListChildren = [];
      }

      containerListChildren.add(_listViewChidrenContainerRow(itemList, i));


      if(i == itemListLength - 1){
        children.add(_listViewChidrenContainer(containerListChildren));
        containerListChildren = [];
      }
    }
    return children;
  }

  Row _listViewChidrenContainerRow(List<ItemModel> itemList, int i) {
    return Row(
      children: [
        Text('${itemList[i].groupId}'),
        Text('${itemList[i].groupId}'),
        Text('${itemList[i].groupId}'),
      ],
    );
  }

  Padding _listViewChidrenContainer(List<Widget> containerListChildren) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.red,
          child: Column(
            children: containerListChildren,
          ),
        ),
      );
  }
}

/*
Row(
          children: [
            Text('${itemList[itemListLength - 1].groupId}'),
            Text('${itemList[itemListLength - 1].groupId}'),
            Text('${itemList[itemListLength - 1].groupId}'),
          ],
        )


        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.red,
            child: Column(
              children: containerListChildren,
            ),
          ),
        ));
        */
