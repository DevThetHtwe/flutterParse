import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../model/usermodel.dart';
import '../model/categorymodel.dart';

class Utils extends ChangeNotifier {
  factory Utils() {
    if (_this == null) _this = Utils._();
    return _this;
  }
  static Utils _this;
  Utils._() : super();

  //crud

  void initializeParseServer() async {
    await Parse()
        .initialize("myAppId", "http://192.168.100.103:1337/parse",
            masterKey: "myMasterKey", debug: false)
        .whenComplete(
      () {
        print('Initializing parse server completed.');
        getItemData();
        getCategoryData();
        notifyListeners();
      },
    );
  }

  void additem(String categoryid, String model, String username) {
    ParseObject itemone = Ite()..set('model', model)..set('username', username);
    itemone.save().then(
      (value) {
        ParseObject cate = Cate()..objectId = categoryid;
        var relation = cate.getRelation('keys');
        relation.add(itemone);
        cate.save();
      },
    );
  }

  void addcategory(String companyname, String category) {
    ParseObject cate = Cate()
      ..set('user', companyname)
      ..set('category', category);
    cate.save().then((value) => print(value));
  }

  List<ItemData> filterlist = List<ItemData>();
  void getcateRelation(String categoryname) async {
    var queryBuilder = QueryBuilder<ParseObject>(ParseObject('CategoryClass'));
    var res = await queryBuilder.query();

    res.results.forEach(
      (e) async {
        if (e['category'] == categoryname) {
          QueryBuilder<ParseObject> query =
              QueryBuilder<ParseObject>(ParseObject('ItemClass'))
                ..whereRelatedTo('keys', 'CategoryClass', e['objectId']);
          var a = await query.query();

          final List<dynamic> json =
              const JsonDecoder().convert(a.results.toString());
          filterlist = json.map((data) => new ItemData.fromJson(data)).toList();
          print(filterlist.length);

          show = filterlist;
        }
      },
    );
  }

  void setPointer(String model, String username, String categoryid) async {
    ParseObject itemone = Ite()..set('model', model)..set('username', username);
    itemone.save().then(
      (value) {
        ParseObject cate = Cate()..objectId = categoryid;
        // var relation = cate.getRelation('keys');
        // relation.add(itemone);

        cate.save();
      },
    );
  }

  void getF() async {
    final ParseCloudFunction function = ParseCloudFunction('Hello');
    final ParseResponse result =
        await function.executeObjectFunction<ParseObject>();
    if (result.success) {
      if (result.result is ParseObject) {
        final ParseObject parseObject = result.result;
        print(parseObject.parseClassName);
      }
    }
  }

  void getPointer() async {
    // QueryBuilder<ParseObject> queryItem =
    //     QueryBuilder<ParseObject>(ParseObject('ItemClass'))
    //       ..whereValueExists('username', true);

    // QueryBuilder<ParseObject> queryCate =
    //     QueryBuilder<ParseObject>(ParseObject('CategoryClass'))
    //       ..whereMatchesQuery('keys', queryItem);

    QueryBuilder<ParseObject> queryCate =
        QueryBuilder<ParseObject>(ParseObject('CategoryClass'))
          ..whereEqualTo('objectId', 'HLHEHC8SXT');

    var apiResponse = await queryCate.query();

    print(apiResponse.results);
  }

  //item_lists
  List<ItemData> get list => show;
  List<ItemData> lists = List<ItemData>();
  List<ItemData> show = List<ItemData>();
  //
  void getItemData() async {
    try {
      var apiResponse = await ParseObject('ItemClass').getAll();
      if (apiResponse.success) {
        final List<dynamic> json =
            const JsonDecoder().convert(apiResponse.result.toString());
        print(json);
        lists.clear();
        lists = json.map((data) => new ItemData.fromJson(data)).toList();

        show = lists;

        notifyListeners();
        print(show.length);
      }
    } catch (e) {
      print("No ItemData or No Internet");
    }
    notifyListeners();
  }

  //category_lists
  List<CategoryData> get clist => cshow;
  List<CategoryData> categorylist = List<CategoryData>();
  List<CategoryData> cshow = List<CategoryData>();
  //
  void getCategoryData() async {
    try {
      var apiResponse = await ParseObject('CategoryClass').getAll();
      if (apiResponse.success) {
        final List<dynamic> json =
            const JsonDecoder().convert(apiResponse.result.toString());
        categorylist.clear();
        categorylist =
            json.map((data) => new CategoryData.fromJson(data)).toList();

        cshow = categorylist;

        notifyListeners();
        print(cshow.length);
      }
    } catch (e) {
      print("No ItemData or No Internet");
    }
    notifyListeners();
  }
}

class Ite extends ParseObject implements ParseCloneable {
  Ite() : super(_keyTableName);
  Ite.clone() : this();

  @override
  clone(Map map) => Ite.clone()..fromJson(map);

  static const String _keyTableName = 'ItemClass';

  static const String keyName = 'objectId';
  static const String keyUser = 'model';
  static const String keyUsername = 'username';

  String get name => get<String>(keyName);
  String get model => get<String>(keyUser);
  String get username => get<String>(keyUsername);

  set name(String name) => set<String>(keyName, name);
  set model(String model) => set<String>(keyUser, model);
  set username(String username) => set<String>(keyUsername, username);
}

class Cate extends ParseObject implements ParseCloneable {
  Cate() : super(_keyTableName);
  Cate.clone() : this();

  @override
  clone(Map map) => Cate.clone()..fromJson(map);

  static const String _keyTableName = 'CategoryClass';

  static const String kobjectId = 'objectId';
  static const String keyUser = 'model';
  static const String keyCategory = 'category';
  static const String keyss = 'keys';

  String get name => get<String>(kobjectId);
  String get model => get<String>(keyUser);
  String get category => get<String>(keyCategory);
  String get keysss => get<String>(keyss);

  set name(String name) => set<String>(kobjectId, name);
  set model(String model) => set<String>(keyUser, model);
  set category(String category) => set<String>(keyCategory, category);
  set keysss(String keyss) => set<String>(keyss, keysss);
}
