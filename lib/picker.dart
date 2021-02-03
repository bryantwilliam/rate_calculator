import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'card_item.dart';
import 'size_config.dart';

class Picker extends StatefulWidget {
  final String title;
  final String description;
  final List<String> options;
  final bool showFirstOptionPlaceholder;
  final Function(String selected) onSelected;

  const Picker({
    @required this.title,
    @required this.description,
    @required this.options,
    @required this.onSelected,
    this.showFirstOptionPlaceholder = false,
  });

  @override
  _State createState() => _State();
}

class _State extends State<Picker> {
  var _result = "";

  String getResult() {
    return _result;
  }

  List<CupertinoActionSheetAction> get _actions {
    List<CupertinoActionSheetAction> actionList = [];
    for (String optionName in widget.options) {
      actionList.add(
        CupertinoActionSheetAction(
          child: Text(optionName),
          onPressed: () {
            setState(() {
              _result = optionName;
            });
            widget.onSelected(optionName);

            Navigator.pop(context);
          },
        ),
      );
    }
    return actionList;
  }

  @override
  Widget build(BuildContext context) {
    return CardItem(
        child: Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal),
          child: Text(
            "${widget.title}:",
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
                left: SizeConfig.safeBlockHorizontal,
                top: SizeConfig.safeBlockVertical,
                bottom: SizeConfig.safeBlockVertical),
            color: Colors.white24,
            child: Center(
              child: Text(
                _result == "" && widget.showFirstOptionPlaceholder
                    ? widget.options[0]
                    : _result,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            vertical: SizeConfig.safeBlockVertical,
            horizontal: SizeConfig.blockSizeHorizontal,
          ),
          child: MaterialButton(
            color: Colors.white70,
            child: Text(
              'Choose',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) => CupertinoActionSheet(
                  title: Text(widget.description),
                  actions: _actions,
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}
