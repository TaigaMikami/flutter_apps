import 'package:flutter/material.dart';
import 'package:handling_routes/screens/home.dart';
import 'package:handling_routes/screens/about.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    routes: <String, WidgetBuilder>{
      AboutPage.routeName: (BuildContext context) => AboutPage(),
    },
  ));
}
