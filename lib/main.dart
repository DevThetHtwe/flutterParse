import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'controller/Utils.dart';
import 'view/home.dart';

void main() => runApp(Test());

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Utils>(create: (_) => Utils()),
      ],
      child: MaterialApp(
        title: 'Parse Test',
        home: Home(),
        theme: ThemeData(primarySwatch: Colors.purple),
      ),
    );
  }
}
