import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  void _clear() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
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
              padding: EdgeInsets.all(10),
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
                  ),
                  Picker(
                    title: "Smoking",
                    description: "Smoking?",
                    options: ["No", "Non-Tobacco", "Tobacco"],
                    showFirstOptionPlaceholder: true,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
