import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void _submitData() {
    String enteredTitle = titleController.text;
    double enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) return;
    widget.addTx(
      enteredTitle,
      enteredAmount,
      selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null)
        return;
      else {
        setState(() {
          selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom+10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    labelText: 'Title', hintText: 'Enter the item purchased'),
                controller: titleController,
                onSubmitted: (val) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Amount',
                    hintText: 'Enter the transaction amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (val) => _submitData(),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat('MMM d, y').format(selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    splashColor: Color(0XFFEEC8FF),
                    child: Text(
                      'Choose Date',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: Color(0XFF6F2A8E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
              RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text(
                  'Add Transaction',
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Color(0XFF5E385E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  _submitData();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
