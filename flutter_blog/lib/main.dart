import 'package:flutter/material.dart';
import 'package:flutter_blog/LoginRegisterPage.dart';
import 'package:flutter_blog/HomePage.dart';
import 'Mapping.dart';
import 'Authentication.dart';

void main() => runApp(new BlogApp());

class BlogApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: new ThemeData(
        primarySwatch: Colors.pink,
      ),
//      home: new LoginRegisterPage(),
      home: new MappingPage(auth: Auth(), ),

    );
  }
}
