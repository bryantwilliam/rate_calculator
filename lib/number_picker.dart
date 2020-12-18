import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rate_calculator/picker.dart';

import 'card_item.dart';

class NumberPicker extends StatefulWidget {
  final int increment;
  final int maxValue;
  final String title;
  final bool monetary;
  final Conditional conditional;

  const NumberPicker({
    @required this.increment,
    @required this.title,
    @required this.maxValue,
    this.monetary = false,
    this.conditional,
  });

  @override
  _NumberPickerState createState() => _NumberPickerState();
}

class Conditional {
  final String plan;
  final int alternativeMax;
  final PickerController planPickingController;

  Conditional({
    @required this.planPickingController,
    @required this.plan,
    @required this.alternativeMax,
  });
}

class _NumberPickerState extends State<NumberPicker> {
  final _amountController = TextEditingController();
  final _formatCurrency = NumberFormat.simpleCurrency();

  void _setValue(num newValue) {
    if (newValue < 0) {
      newValue = 0;
    } else {
      var max = widget.maxValue;

      // BUG this doesn't run automatically after plantype is changed.
      var conditional = widget.conditional;
      if (conditional != null) {
        var planPickingController = conditional.planPickingController;
        if (planPickingController != null) {
          var conditionalPlan = conditional.planPickingController.selection;
          if (conditionalPlan == conditional.plan) {
            max = conditional.alternativeMax;
          }
        }
      }

      if (newValue >= max) {
        newValue = max;
      }
    }

    _amountController.text = widget.monetary
        ? _formatCurrency.format(newValue)
        : newValue.toString();
  }

  num parseCurrentValue() {
    return widget.monetary
        ? _formatCurrency.parse(_amountController.text)
        : double.parse(_amountController.text).toInt();
  }

  // add true: add
  // add false: subtract
  void _increment(int increment) {
    if (increment == 0) {
      return;
    }

    if (_amountController.text == "") {
      _amountController.text = "0";
    }

    num newValue = parseCurrentValue() + increment;

    _setValue(newValue);
  }

  FlatButton _getincrementButton(int increment) {
    return FlatButton(
      color: Colors.white70,
      padding: EdgeInsets.all(7),
      minWidth: 10,
      height: 10,
      child: Icon(
        increment < 0 ? Icons.remove : Icons.add,
        color: Colors.black87,
      ),
      onPressed: () {
        _increment(increment);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CardItem(
      child: Padding(
        padding: const EdgeInsets.all(0.05),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(widget.title),
              ),
            ),
            Expanded(
              flex: 7,
              child: Row(
                children: [
                  _getincrementButton(-widget.increment),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.white24,
                      child: TextField(
                        enableInteractiveSelection: false,
                        decoration: InputDecoration.collapsed(
                          hintText: "Enter Amount",
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        controller: _amountController,
                        onSubmitted: (_) {
                          _setValue(parseCurrentValue());
                        },
                        onTap: () {
                          _amountController.text = "";
                        },
                      ),
                    ),
                  ),
                  _getincrementButton(widget.increment),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
