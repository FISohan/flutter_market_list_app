class ItemModel {
  int id;
  int groupId;
  int isDone;
  int amountPerItem;
  String itemName;
  String itemQuantity;

  ItemModel({
    required this.id,
    required this.groupId,
    required this.isDone,
    required this.amountPerItem,
    required this.itemName,
    required this.itemQuantity,
  });
  // map to object
  ItemModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        groupId = map['groupId'],
        isDone = map['isDone'],
        amountPerItem = map['amountPerItem'],
        itemName = map['itemName'],
        itemQuantity = map['itemQuantity'];

//object to map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> _map = Map<String, dynamic>();
    _map['id'] = id;
    _map['groupId'] = groupId;
    _map['isDone'] = isDone;
    _map['amountPerItem'] = itemQuantity;
    _map['itemName'] = itemName;
    _map['itemQuantity'] = itemQuantity;
    return _map;
  }
}
