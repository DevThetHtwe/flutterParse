class ItemData {
  final String objId;
  final String username;
  final String model;

  bool selected = false;
  ItemData({this.username, this.model, this.objId});

  factory ItemData.fromJson(Map<String, dynamic> json) {
    return new ItemData(
      objId: json['objectId'],
      username: json['username'],
      model: json['model'],
    );
  }
}
