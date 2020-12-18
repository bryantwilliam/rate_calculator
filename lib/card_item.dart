import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final Widget child;

  CardItem({this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      elevation: 15,
      margin: EdgeInsets.symmetric(
        vertical: 2.5,
        horizontal: 10,
      ),
      child: child,
    );
  }
}
