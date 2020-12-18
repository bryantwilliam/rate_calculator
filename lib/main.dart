import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  var planPickerController = PickerController(); // TODO use this.

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
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Premium",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    "0",
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
                  ),
                  Picker(
                    title: "Plan Type",
                    description: "Which plan type?",
                    options: ["Final Expense", "20 Pay", "Modified"],
                    controller: planPickerController,
                  ),
                  Picker(
                    title: "Smoking",
                    description: "Smoking?",
                    options: ["No", "Non-Tobacco", "Tobacco"],
                    showFirstOptionPlaceholder: true,
                  ),
                  NumberPicker(
                    title: "Coverage amount",
                    increment: 1000,
                    maxValue:
                        /*planPickerController != null &&
                            planPickerController.selection != null &&
                            planPickerController.selection == "Modified"
                        ? 15000
                        : */
                        35000,
                    conditional: Conditional(
                      // BUG the max doesn't change to the alternative max automatically after plantype is changed.
                      planPickingController: planPickerController,
                      plan: "Modified",
                      alternativeMax: 15000,
                    ),
                    monetary: true,
                  ),
                  NumberPicker(
                    title: "Age",
                    increment: 10,
                    maxValue: 85,
                    conditional: Conditional(
                      planPickingController: planPickerController,
                      plan: "20 Pay",
                      alternativeMax: 80,
                    ),
                  ),
                  NumberPicker(
                    title: "AD&D Rider", // TODO units
                    increment: 1,
                    maxValue: 8,
                  ),
                  NumberPicker(
                    title: "Child Unit Rider Units", //TODO units
                    increment: 1,
                    maxValue: 5,
                  ),
                  NumberPicker(
                    title: "Number of Children",
                    increment: 1,
                    maxValue: 8,
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
