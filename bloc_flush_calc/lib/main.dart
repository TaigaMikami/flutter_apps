import 'package:flutter/material.dart';
import 'package:bloc_flush_calc/blocs/calc_provider.dart';
import 'screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalcBlocProvider(
        child: CalcScreen(),
      )
    );
  }
}
