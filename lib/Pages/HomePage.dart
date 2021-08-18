import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:market_list/Models/ItemModel.dart';
import 'package:market_list/Services/HomePageService.dart';
import 'package:market_list/Services/TabService.dart';

class HomePage extends StatelessWidget {
  final HomePageService _homePageService = Get.put(HomePageService());

  @override
  Widget build(BuildContext context) {
    return GetX<HomePageService>(
        init: HomePageService(),
        builder: (c) => Container(
              child: ListView(
                children: (c.items.length == 0)
                    ? [
                        Container(
                          alignment: Alignment.center,
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
        children.add(_listViewChildrenContainer(containerListChildren));

        containerListChildren.add(Column(
          children: [
            Text(
              'Total:${_homePageService.totalAmount(itemList[i].groupId - 1)}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ));
        containerListChildren = [];
      }

      containerListChildren.add(_listViewChildrenContainerRow(itemList, i));

      if (i == itemListLength - 1) {
        children.add(_listViewChildrenContainer(containerListChildren));
        containerListChildren.add(Column(
          children: [
            Text(
              'Total:${_homePageService.totalAmount(itemList.last.groupId)}',
              style: TextStyle(fontSize: 20),
            ),
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
        Checkbox(
            value: (itemList[i].isDone == 1) ? true : false,
            onChanged: (value) async {
              ItemModel updatedItem = ItemModel(
                  id: itemList[i].id,
                  groupId: itemList[i].groupId,
                  isDone: (value == true) ? 1 : 0,
                  amountPerItem: itemList[i].amountPerItem,
                  itemName: itemList[i].itemName,
                  itemQuantity: itemList[i].itemQuantity);
              if (_homePageService.checkIsSorted(itemList[i].groupId)) {
                Get.snackbar('', 'Your Item Appear in Archive',
                    snackPosition: SnackPosition.TOP,
                    mainButton:
                        TextButton(onPressed: () {
                          Get.put(TabService()).goPage(1);
                        }, child: Text('Go archive')),
                    duration: Duration(milliseconds: 1500));
              }
              await _homePageService.updateDb(updatedItem);
            }),
        Text('${itemList[i].itemName}',
            style: (itemList[i].isDone == 1)
                ? TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.red,
                    decorationThickness: 3,
                  )
                : TextStyle()),
        Text('${itemList[i].itemQuantity}',
            style: (itemList[i].isDone == 1)
                ? TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.red,
                    decorationThickness: 3,
                  )
                : TextStyle()),
        SizedBox(
            width: (Get.width / 3) - 35,
            height: 35,
            child: TextFormField(
                onChanged: (value) async {
                  ItemModel updatedItem = ItemModel(
                      id: itemList[i].id,
                      groupId: itemList[i].groupId,
                      isDone: itemList[i].isDone,
                      amountPerItem: int.parse(value),
                      itemName: itemList[i].itemName,
                      itemQuantity: itemList[i].itemQuantity);
                  await _homePageService.updateDb(updatedItem);
                },
                keyboardType: TextInputType.number,
                initialValue: (itemList[i].amountPerItem == 0)
                    ? ''
                    : '${itemList[i].amountPerItem}',
                decoration: InputDecoration(
                  labelText: 'Amount',
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.black12, width: 1.5)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.5)),
                ))),
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
