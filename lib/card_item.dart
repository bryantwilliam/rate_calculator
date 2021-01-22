import 'package:flutter/material.dart';
import 'package:rate_calculator/size_config.dart';

class CardItem extends StatelessWidget {
  final Widget child;

  CardItem({this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      elevation: 15,
      margin: EdgeInsets.symmetric(
        vertical: SizeConfig.blockSizeVertical * 0.5,
        horizontal: SizeConfig.blockSizeHorizontal,
      ),
      child: child,
    );
  }
}
