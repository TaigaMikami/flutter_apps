import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CountLabel extends StatefulWidget {
  final int favoriteCount;

  const CountLabel({
    Key key,
    @required this.favoriteCount,
  }) : assert(favoriteCount >= 0),
       super(key:key);

  @override
  CountLabelState createState() => CountLabelState();
}

class CountLabelState extends State<CountLabel> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.favoriteCount.toString(),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 35.0,
        color: Colors.pink
      ),
    );
  }
}
