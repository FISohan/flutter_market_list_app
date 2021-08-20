import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

import 'package:market_list/Models/ItemModel.dart';
import 'package:market_list/Services/ArchivePsgeService.dart';
import 'package:market_list/Services/HomePageService.dart';

import 'AddItemPage.dart';

class ArchivePage extends StatelessWidget {
  final HomePageService _homePageService = Get.put(HomePageService());

  @override
  Widget build(BuildContext context) {
    return GetX<ArchivePageService>(
        init: ArchivePageService(),
        builder: (c) => Container(
              child: (c.items.length == 0)
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No Current item found',
                            style: TextStyle(
                                fontSize: 30, color: Colors.redAccent),
                          ),
                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: 'This app made by: ',
                                  children: [
                                    TextSpan(
                                        text: 'FI Sohan\n',
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 20)),
                                    TextSpan(text: 'fisohan7@gmail.com\n'),
                                    TextSpan(text: 'For you 19B7')
                                  ])),
                          ElevatedButton(
                              onPressed: () {
                                Get.to(AddItemPage());
                              },
                              child: Text('ADD'))
                        ],
                      ),
                    )
                  : ListView(
                      children: _listViewChildren(c.items),
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
        children.add(_listViewChildrenContainer(containerListChildren));

        containerListChildren.add(Column(
          children: [
            Divider(
              endIndent: 50,
              indent: 50,
            ),
            Text(
              'Total:${_homePageService.totalAmount(itemList[i].groupId - 1)}',
              style: TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              onPressed: () {
                if (_homePageService
                    .isAllDoneInGroup(itemList[i].groupId - 1)) {
                  Get.put(ArchivePageService())
                      .deleteItem(itemList[i].groupId - 1);
                } else {
                  Get.snackbar('Alert', 'You are not done',
                      backgroundColor: Colors.blueGrey,
                      snackPosition: SnackPosition.TOP,
                      mainButton: TextButton(
                          onPressed: () {
                            Get.put(ArchivePageService())
                                .deleteItem(itemList[i].groupId - 1);
                          },
                          child: Text(
                            'Force delete',
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          )),
                      padding: EdgeInsets.all(10));
                }
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(1)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red)),
              child: Text('DELETE'),
            ),
            Text(
              'Time:${itemList[i].time}',
              style: TextStyle(fontSize: 10),
            )
          ],
        ));
        containerListChildren = [];
      }

      containerListChildren.add(_listViewChildrenContainerRow(itemList, i));

      if (i == itemListLength - 1) {
        children.add(_listViewChildrenContainer(containerListChildren));
        containerListChildren.add(Column(
          children: [
            Divider(
              endIndent: 50,
              indent: 50,
            ),
            Text(
              'Total:${_homePageService.totalAmount(itemList.last.groupId)}',
              style: TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              onPressed: () {
                if (_homePageService.isAllDoneInGroup(itemList.last.groupId)) {
                  Get.put(ArchivePageService())
                      .deleteItem(itemList.last.groupId);
                } else {
                  Get.snackbar('Alert', 'You are not done',
                      backgroundColor: Colors.blueGrey,
                      snackPosition: SnackPosition.TOP,
                      mainButton: TextButton(
                          onPressed: () {
                            Get.put(ArchivePageService())
                                .deleteItem(itemList.last.groupId);
                          },
                          child: Text(
                            'Force delete',
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          )),
                      padding: EdgeInsets.all(10));
                }
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(1)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red)),
              child: Text('DELETE'),
            ),
            Text(
              'Time:${itemList.last.time}',
              style: TextStyle(fontSize: 10),
            )
          ],
        ));
        containerListChildren = [];
      }
    }
    return children;
  }

  Row _listViewChildrenContainerRow(List<ItemModel> itemList, int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Text('${itemList[i].itemName}',
              style: (itemList[i].isDone == 1)
                  ? TextStyle(color: Colors.redAccent)
                  : TextStyle()),
        ),
        Text('${itemList[i].itemQuantity}',
            style: (itemList[i].isDone == 1)
                ? TextStyle(color: Colors.redAccent)
                : TextStyle()),
        Text('${itemList[i].amountPerItem}',
            style: (itemList[i].isDone == 1)
                ? TextStyle(color: Colors.redAccent)
                : TextStyle())
      ],
    );
  }

  Padding _listViewChildrenContainer(List<Widget> containerListChildren) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1.5, color: Colors.blueGrey)),
        child: Column(
          children: containerListChildren,
        ),
      ),
    );
  }
}
