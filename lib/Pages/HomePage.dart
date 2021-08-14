import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:market_list/Models/ItemModel.dart';
import 'package:market_list/Services/HomePageService.dart';

class HomePage extends StatelessWidget {
  HomePageService _homePageService = Get.put(HomePageService());
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

        containerListChildren.add(Column(
          children: [
            Text(
                'Total:${_homePageService.totalAmount(itemList![i].groupId - 1)}'),
            OutlinedButton(
                onPressed: () {},
                child: Text(
                  'Complete',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ));
        containerListChildren = [];
      }

      containerListChildren.add(_listViewChidrenContainerRow(itemList, i));

      if (i == itemListLength - 1) {
        children.add(_listViewChidrenContainer(containerListChildren));
        containerListChildren.add(Column(
          children: [
            Text(
                'Total:${_homePageService.totalAmount(itemList.last.groupId)}'),
            OutlinedButton(
                onPressed: () {},
                child: Text(
                  'Complete',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ));
        containerListChildren = [];
      }
    }
    return children;
  }

  Row _listViewChidrenContainerRow(List<ItemModel> itemList, int i) {
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
              await _homePageService.updateDb(updatedItem);
            }),
        Text('${itemList[i].itemName}'),
        Text('${itemList[i].itemQuantity}'),
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

  Padding _listViewChidrenContainer(List<Widget> containerListChildren) {
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
