
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:market_list/Services/AddItemService.dart';

class AddItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: GetX<AddItemService>(
        init: AddItemService(),
        builder: (c) => ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: c.items.length,
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('${c.items[i].itemName}'),
                        Text('${c.items[i].itemQuantity}')
                      ],
                    ),
                  );
                }),
            Divider(),
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
                           // c.itemName = value.toString();
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
                         //   c.itemQuantity = v.toString();
                          },
                          decoration: _inputDecoration('Item Quantity'),
                        ))
                  ],
                )),
            Padding(
              //width of button -> 65
              padding: EdgeInsets.only(
                  left: (Get.width / 2) - 65, right: (Get.width / 2) - 65),
              child: MaterialButton(
                onPressed: () {
                  if (!(_formKey.currentState!.validate())) {
                    _formKey.currentState!.reset();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('PLEASE! Input Item Name Or Item Quantity'),
                      backgroundColor: Colors.red,
                    ));
                  } else {
                    _formKey.currentState!.save();
                    c.addItem();
                  }
                },
                child: Text('Add'),
                color: Colors.blueGrey,
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('add'),
      ),
    );
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
