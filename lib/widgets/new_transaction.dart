import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: use_key_in_widget_constructors
class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  DateTime _selectedDate;
  final _amountController = TextEditingController();

  void _addTxn() {
    if (_amountController.text.isEmpty) return;
    final enteredTittle = _titleController.text;
    final enteredamount = double.parse(_amountController.text);

    if (enteredTittle.isEmpty || enteredamount <= 0 || _selectedDate == null)
      return;
    widget.addTransaction(enteredTittle, enteredamount, _selectedDate);
    //to close the top most screen in the app
    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null)
        return;
      else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        color: Colors.green[50],
        child: Container(
            padding:  EdgeInsets.only(
              top: 10.0,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom+10,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    controller: _titleController,
                    onSubmitted: (_) => _addTxn(),
                    // onChanged: ((value) => titleInput = value),
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _amountController,
                    // onChanged: (val) => amountInput = val,
                    decoration: InputDecoration(
                      labelText: '₹ Amount',
                    ),
                    onSubmitted: (_) => _addTxn(),
                  ),
                  Container(
                    height: 70,
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(_selectedDate == null
                                ? "No Date Choosen"
                                : "Picked Date: ${DateFormat.yMd().format(_selectedDate)}")),
                        FlatButton(
                            textColor: Theme.of(context).primaryColor,
                            onPressed: presentDatePicker,
                            child: Text(
                              "Choose Date",
                            ))
                      ],
                    ),
                  ),
                  RaisedButton(
                      onPressed: _addTxn,
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).textTheme.button.color,
                      child: Text(
                        "Submit",
                      ))
                ])),
      ),
    );
  }
}
