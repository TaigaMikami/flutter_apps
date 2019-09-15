import 'package:flutter/material.dart';
import 'package:flutter_todo/screens/home.dart';
import 'package:flutter_todo/screens/dialog.dart';
import 'package:flutter_todo/screens/navigator.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    routes: <String, WidgetBuilder> {
      DialogPage.routeName: (BuildContext context) => DialogPage(),
      NavigatorPage.routeName: (BuildContext context) => NavigatorPage(),
    }
  ));
}
