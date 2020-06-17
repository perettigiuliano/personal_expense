import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _newTransactionHandler;

  NewTransaction(this._newTransactionHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _trxTitleController = TextEditingController();
  final _trxAmountController = TextEditingController();
  final _trxDateController = TextEditingController();
  DateTime selectedDate;
  bool _isTitleOk = false;
  bool _isAmountOk = false;
  bool _isDateOk = false;
  bool _isSaveButtonEnabled = false;

  void newTransaction([String val]) {
    if ((_trxTitleController.text.length > 0) &&
        (_trxAmountController.text.length > 0) &&
        (_trxDateController.text.length >= 0)) {
      widget._newTransactionHandler(_trxTitleController.text,
          double.parse(_trxAmountController.text), selectedDate);
    }
    Navigator.of(context).pop();
  }

  void isSaveEnabled() {
    _isTitleOk = (_trxTitleController.text.length >= 3);
    _isAmountOk = (_trxAmountController.text.length >= 1);
    _isDateOk = (_trxDateController.text.length > 0);
    if (_isTitleOk && _isAmountOk && _isDateOk) {
      setState(() {
        _isSaveButtonEnabled = true;
      });
    }
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      selectedDate = value;
      _trxDateController.text = DateFormat.yMMMMd().format(selectedDate);
      isSaveEnabled();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              onSubmitted: newTransaction,
              controller: _trxTitleController,
              decoration: InputDecoration(labelText: "Title:"),
              onChanged: (value) {
                isSaveEnabled();
              },
            ),
            TextField(
              onSubmitted: newTransaction,
              keyboardType: TextInputType.number,
              controller: _trxAmountController,
              decoration: InputDecoration(labelText: "Amount:"),
              onChanged: (value) {
                isSaveEnabled();
              },
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      onSubmitted: newTransaction,
                      keyboardType: TextInputType.datetime,
                      controller: _trxDateController,
                      decoration: InputDecoration(labelText: "Date:"),
                      onChanged: (value) {
                        isSaveEnabled();
                      },
                    ),
                  ),
                  RaisedButton(
                    color: Colors.white,
                    textColor: Colors.red,
                    onPressed: () {
                      _showDatePicker();
                    },
                    child: Text('Choose'),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, right: 10),
              child: RaisedButton(
                child: Text(
                  "Save",
                ),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _isSaveButtonEnabled ? newTransaction : null,
              ),
            )
          ],
        ),
      ),
    );
  }
}
