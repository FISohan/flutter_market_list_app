class ItemModel {
  int id;
  int groupId;
  int isDone;
  int amountPerItem;
  String itemName;
  String itemQuantity;
  String time;
  ItemModel({
    required this.id,
    required this.groupId,
    required this.isDone,
    required this.amountPerItem,
    required this.itemName,
    required this.itemQuantity,
    required this.time
  });
  // map to object
  ItemModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        groupId = map['groupId'],
        isDone = map['isDone'],
        amountPerItem = map['amountPerItem'],
        itemName = map['itemName'],
        itemQuantity = map['itemQuantity'],
        time = map['time'];
//object to map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> _map = Map<String, dynamic>();
    _map['id'] = id;
    _map['groupId'] = groupId;
    _map['isDone'] = isDone;
    _map['amountPerItem'] = amountPerItem;
    _map['itemName'] = itemName;
    _map['itemQuantity'] = itemQuantity;
    _map['time'] = time;
    return _map;
  }
}
