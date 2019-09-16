import 'package:flutter/material.dart';
import 'package:flutter_firebase/CrudApp/crud_sample.dart';
import 'package:flutter_firebase/WallpaperApp/wall_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter demo',
      theme: new ThemeData(
        primarySwatch:  Colors.blue,
      ),
//      home: new CrudSample(),
    home: new WallScreen(),
    );
  }
}
