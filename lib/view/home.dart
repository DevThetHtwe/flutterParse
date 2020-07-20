import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:x/controller/Utils.dart';
import 'package:x/model/usermodel.dart';
import 'package:x/view/createItem.dart';
import 'package:x/view/createcategory.dart';
import 'package:x/view/dataview.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Utils utils = new Utils();

  @override
  void initState() {
    utils.initializeParseServer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Parse Test', style: GoogleFonts.aBeeZee()),
      ),
      body: SafeArea(
        child: Container(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton(
                        color: Colors.purple,
                        onPressed: () {
                          jumper(CreateCategory());
                        },
                        child: mytext('Add Category', false, Colors.white),
                      ),
                      FlatButton(
                        color: Colors.purple,
                        onPressed: () {
                          jumper(CreateItem());
                        },
                        child: mytext('Add Item', false, Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: FlatButton(
                  color: Colors.purple,
                  onPressed: () {
                    // jumper(DataView());
                    // utils.getPointer();
                    utils.getF();
                  },
                  child: mytext('Show Data', false, Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget mytext(String text, bool isbold, Color textcolor) {
    return Text(text, style: GoogleFonts.aBeeZee(color: textcolor));
  }

  void jumper(Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }
}
