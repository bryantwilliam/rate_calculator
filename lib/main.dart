import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'number_picker.dart';
import 'picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rate Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Final Expense Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum PlanType {
  finalExpense,
  twentyPay,
  modified,
}

extension PlanTypeExtension on PlanType {
  String get text {
    switch (this) {
      case PlanType.finalExpense:
        return "Final Expense";
      case PlanType.twentyPay:
        return "20 Pay";
      case PlanType.modified:
        return "Modified";
      default:
        return "Undefined";
    }
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String _planType = "";
  double _coverageAmount = 0;
  int _childRiderUnits = 0;
  int _adNdRiderUnits = 0;
  int _numChildren = 0;
  int _age = 0;

  double get _premium {
    double pac = 1; // TODO get pac

    bool is20Pay = _planType == PlanType.twentyPay.text;

    double adNdRider;
    if (_age <= 70) {
      adNdRider = is20Pay ? 1.5 : 1;
    } else if (_age <= 75) {
      adNdRider = is20Pay ? 2 : 1.5;
    } else if (_age <= 80) {
      adNdRider = is20Pay ? 2.5 : 2;
    } else {
      adNdRider = 2.25; // Can't go over 80 with 20Pay so no need to check.
    }
    adNdRider *= _adNdRiderUnits;

    double childRider =
        (is20Pay ? 2.25 : 2.0) * _childRiderUnits * _numChildren;

    return (pac * (_coverageAmount / 1000)) + adNdRider + childRider + 3;
  }

  void _clear() {
    setState(() {
      Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false, // For overflow from keyboard
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _clear,
              child: Icon(Icons.cleaning_services),
            ),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              color: Color.fromRGBO(54, 69, 79, 1),
              child: Column(
                children: [
                  Text(
                    "Premium",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    NumberFormat.simpleCurrency().format(_premium),
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Picker(
                    title: "Gender",
                    description: "Male or Female?",
                    options: ["Male", "Female"],
                    onSelected: (String selected) {},
                  ),
                  Picker(
                    title: "Plan Type",
                    description: "Which plan type?",
                    options: PlanType.values.map((e) => e.text).toList(),
                    onSelected: (String selected) {
                      setState(() {
                        _planType = selected;
                      });
                    },
                  ),
                  Picker(
                    title: "Smoking",
                    description: "Smoking?",
                    options: ["No", "Non-Tobacco", "Tobacco"],
                    showFirstOptionPlaceholder: true,
                    onSelected: (String selected) {},
                  ),
                  NumberPicker(
                    title: "Age",
                    increment: 10,
                    maxValue: _planType == PlanType.twentyPay.text ? 80 : 85,
                    onChanged: (double value) {
                      setState(() {
                        _age = value.toInt();
                      });
                    },
                  ),
                  NumberPicker(
                    title: "Coverage amount",
                    increment: 1000,
                    maxValue:
                        _planType == PlanType.modified.text ? 15000 : 35000,
                    monetary: true,
                    onChanged: (double value) {
                      setState(() {
                        _coverageAmount = value;
                      });
                    },
                  ),
                  NumberPicker(
                    title: "AD&D Rider",
                    increment: 1,
                    maxValue: 8,
                    onChanged: (double value) {
                      setState(() {
                        _adNdRiderUnits = value.toInt();
                      });
                    },
                  ),
                  NumberPicker(
                    title: "Child Unit Rider Units",
                    increment: 1,
                    maxValue: 5,
                    onChanged: (double value) {
                      setState(() {
                        _childRiderUnits = value.toInt();
                      });
                    },
                  ),
                  NumberPicker(
                    title: "Number of Children",
                    increment: 1,
                    maxValue: 8,
                    onChanged: (double value) {
                      setState(() {
                        _numChildren = value.toInt();
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
