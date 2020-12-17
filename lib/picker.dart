import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Picker extends StatefulWidget {
  final String title;
  final String description;
  final List<String> options;
  final bool showFirstOptionPlaceholder;

  const Picker({
    @required this.title,
    @required this.description,
    @required this.options,
    this.showFirstOptionPlaceholder = false,
  });

  @override
  _State createState() => _State();
}

class _State extends State<Picker> {
  var _result = "";

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
    return Card(
      color: Colors.blueGrey,
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 1,
        horizontal: 10,
      ),
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
            );
          },
        ),
      ),
    );
  }
}
