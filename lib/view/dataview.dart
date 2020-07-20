import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:x/controller/Utils.dart';
import 'package:x/model/usermodel.dart';

class DataView extends StatefulWidget {
  @override
  _DataViewState createState() => _DataViewState();
}

class _DataViewState extends State<DataView> {
  Utils utils = new Utils();
  List<String> categories = [];
  var currentcategory = 'Category';
  //
  List<ItemData> flist = new List<ItemData>();

  @override
  void initState() {
    utils.categorylist.forEach(
      (e) {
        setState(() {
          categories.add(e.category);
        });
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          DropdownButton<String>(
            iconEnabledColor: Colors.white,
            hint: Text(currentcategory,
                style: GoogleFonts.aBeeZee(color: Colors.white)),
            items: categories.map(
              (e) {
                return DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                );
              },
            ).toList(),
            onChanged: (v) {
              print(v);
              setState(
                () {
                  currentcategory = v;
                  //
                  utils.getcateRelation(v);
                  //
                  setState(() {
                    //
                  });
                  //
                },
              );
            },
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            itemBuilder: (c, i) {
              return ListTile(
                title: Text(utils.show[i].model,
                    style: GoogleFonts.aBeeZee(color: Colors.black)),
              );
            },
            itemCount: utils.show.length,
          ),
        ),
      ),
    );
  }
}
