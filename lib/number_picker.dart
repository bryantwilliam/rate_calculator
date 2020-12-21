import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'card_item.dart';

class NumberPicker extends StatefulWidget {
  final int increment;
  final int maxValue;
  final String title;
  final bool monetary;
  final Function(double value) onChanged;
  final int initialValue;

  const NumberPicker(
      {@required this.increment,
      @required this.title,
      @required this.maxValue,
      @required this.onChanged,
      this.monetary = false,
      this.initialValue = 0});

  @override
  _NumberPickerState createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {
  final _amountController = TextEditingController();
  final _formatCurrency = NumberFormat.simpleCurrency();

  void _setValue(double newValue) {
    if (newValue < 0) {
      newValue = 0;
    } else {
      double max = widget.maxValue.toDouble();

      if (newValue >= max) {
        newValue = max;
      }
    }

    widget.onChanged(newValue.toDouble());

    _amountController.text = widget.monetary
        ? _formatCurrency.format(newValue)
        : newValue.toInt().toString();
  }

  double _parseCurrentValue() {
    if (widget.monetary) {
      try {
        return _formatCurrency.parse(_amountController.text);
      } on FormatException catch (_) {
        return _formatCurrency.parse("0");
      }
    }
    return double.tryParse(_amountController.text) ?? 0;
  }

  // add true: add
  // add false: subtract
  void _increment(double increment) {
    if (increment == 0) {
      return;
    }

    if (_amountController.text == "") {
      _amountController.text = "0";
    }

    double newValue = _parseCurrentValue() + increment;

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
        _increment(increment.toDouble());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_amountController.text != "") {
      WidgetsBinding.instance.addPostFrameCallback(
        // wait for the build to complete so that there is no setState() called during build.
        (_) => _setValue(_parseCurrentValue()),
      );
    }

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
                          _setValue(_parseCurrentValue());
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
