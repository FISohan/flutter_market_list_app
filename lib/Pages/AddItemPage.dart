import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:market_list/Services/AddItemService.dart';

class AddItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return GetX<AddItemService>(
        init: AddItemService(),
        builder: (c) => Scaffold(
              backgroundColor: Colors.white60,
              body: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: c.items.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Padding(
                          padding: const EdgeInsets.only(top:3.0),
                          child: Container(
                            color: Colors.blueGrey,
                            height: 45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('${i + 1}'),
                                Text('${c.items[i].itemName}'),
                                Text('${c.items[i].itemQuantity}'),
                                IconButton(
                                  onPressed: () {
                                    c.removeItemFromItems(i);
                                  },
                                  icon: Icon(Icons.clear),
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                  Divider(indent: 100,endIndent: 100,color: Colors.blueGrey,),
                  Form(
                      key: _formKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                              width: (Get.width / 2) - 40,
                              height: 45,
                              child: TextFormField(
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return;
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  c.itemName = value.toString();
                                },
                                decoration: _inputDecoration('Item Name'),
                              )),
                          SizedBox(
                              width: (Get.width / 2) - 40,
                              height: 45,
                              child: TextFormField(
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return 'input Text';
                                  }
                                  return null;
                                },
                                onSaved: (v) {
                                  c.itemQuantity = v.toString();
                                },
                                decoration: _inputDecoration('Item Quantity'),
                              ))
                        ],
                      )),
                  Padding(
                    //width of button -> 65
                    padding: EdgeInsets.only(
                        left: (Get.width / 2) - 65,
                        right: (Get.width / 2) - 65),
                    child: MaterialButton(
                      onPressed: () {
                        if (!(_formKey.currentState!.validate())) {
                          _formKey.currentState!.reset();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'PLEASE! Input Item Name Or Item Quantity'),
                            backgroundColor: Colors.red,
                          ));
                        } else {
                          _formKey.currentState!.save();
                          c.addItem();
                          _formKey.currentState!.reset();
                        }
                      },
                      child: Text('Add'),
                      color: Colors.blueGrey,
                    ),
                  )
                ],
              ),
              appBar: AppBar(
                title: Text('Add items to List',),
                centerTitle: true,
                backgroundColor: Colors.blueGrey,
                actions: [
                  IconButton(
                      onPressed: () async {
                        await c.saveItemsToDB();
                        Get.back();
                      },
                      icon: Icon(
                        Icons.check_sharp,
                        size: 35,
                        color: Colors.green,
                      ))
                ],
              ),
            ));
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black12, width: 1.5)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.5)),
    );
  }
}
