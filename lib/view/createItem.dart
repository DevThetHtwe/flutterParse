import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:x/controller/Utils.dart';

class CreateItem extends StatefulWidget {
  @override
  _CreateItemState createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  //
  TextEditingController model = new TextEditingController();
  TextEditingController username = new TextEditingController();
  Utils utils = new Utils();

  List<String> categories = [];
  var currentcategory = 'Category';

  @override
  void initState() {
    utils.getCategoryData();
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
        title: mytext('Create Item', false, Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              utils.categorylist.forEach(
                (e) {
                  if (e.category == currentcategory) {
                    print(e.objId);
                    utils.additem(e.objId, model.text, username.text);
                  }
                },
              );

              model.clear();
              username.clear();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      DropdownButton<String>(
                        hint: Text(currentcategory),
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
                          setState(() {
                            currentcategory = v;
                          });
                        },
                      ),
                      TextField(
                        controller: username,
                        decoration: InputDecoration(hintText: 'Username'),
                      ),
                      TextField(
                        controller: model,
                        decoration: InputDecoration(hintText: 'Model'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mytext(String text, bool isbold, Color textcolor) {
    return Text(text, style: GoogleFonts.aBeeZee(color: textcolor));
  }
}
