import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'card_item.dart';

class Picker extends StatefulWidget {
  final String title;
  final String description;
  final List<String> options;
  final bool showFirstOptionPlaceholder;
  final PickerController controller;

  const Picker({
    @required this.title,
    @required this.description,
    @required this.options,
    this.showFirstOptionPlaceholder = false,
    this.controller,
  });

  @override
  _State createState() => _State();
}

class PickerController {
  String selection;
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
      child: ListTile(
        leading: Text(
          "${widget.title}:",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        title: Container(
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
        subtitle: MaterialButton(
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
            ).whenComplete(() {
              if (widget.controller != null) {
                setState(() {
                  widget.controller.selection = _result;
                });
              }
            });
          },
        ),
      ),
    );
  }
}
