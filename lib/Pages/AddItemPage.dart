import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_list/Services/AddItemService.dart';

class AddItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<AddItemService>(
        init: AddItemService(),
        builder: (c)=>ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            ListView.builder(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: c.items.length,
                itemBuilder: (BuildContext context,int i){
              return Text('${c.items[0].itemName}');
            }),
            ElevatedButton(onPressed: (){
            }, child:Text('Add') )
          ],
        ),
      ),
      appBar: AppBar(title: Text('add'),),
    );
  }
}
