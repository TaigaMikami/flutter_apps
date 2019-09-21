import 'package:flutter/material.dart';
import 'package:recipes_app/auth/auth.dart';
import 'package:recipes_app/login_admin/root_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RootPage(auth: Auth(),),
    );
  }
}
