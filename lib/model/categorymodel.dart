class CategoryData {
  final String objId;
  final String user;
  final String category;

  bool selected = false;
  CategoryData({this.user, this.category, this.objId});

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return new CategoryData(
      objId: json['objectId'],
      user: json['user'],
      category: json['category'],
    );
  }
}
