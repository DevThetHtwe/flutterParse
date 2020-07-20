import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:x/controller/Utils.dart';

class CreateCategory extends StatefulWidget {
  @override
  _CreateCategoryState createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  Utils utils = new Utils();
  //
  TextEditingController user = new TextEditingController();
  TextEditingController category = new TextEditingController();

  @override
  void initState() {
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
              utils.addcategory(user.text, category.text);
              user.clear();
              category.clear();
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
                      TextField(
                        controller: user,
                        decoration: InputDecoration(hintText: 'Company'),
                      ),
                      TextField(
                        controller: category,
                        decoration: InputDecoration(hintText: 'Category'),
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
