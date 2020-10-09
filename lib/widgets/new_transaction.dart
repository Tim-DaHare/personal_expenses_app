import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/widgets/adaptive_flatbutton.dart';

class NewTransaction extends StatefulWidget {
  final Function onAddTransaction;

  NewTransaction({this.onAddTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _transactionDate;

  void _onSubmit() {
    if (_titleController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _transactionDate == null) return;

    final titleInput = _titleController.text;
    final amountInput = double.tryParse(_amountController.text);

    if (amountInput == null) return;

    widget.onAddTransaction(titleInput, amountInput, _transactionDate);
  }

  void _showDatePicker() async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: this.context,
      initialDate: DateTime.now(),
      firstDate: DateTime(now.year),
      lastDate: now,
    );

    setState(() {
      _transactionDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: _titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _onSubmit(),
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _transactionDate == null
                          ? "No Date Chosen"
                          : "Picked Date: ${DateFormat.yMMMMd().format(_transactionDate)}",
                    ),
                    AdaptiveFlatButton(
                      text: "Choose Date",
                      onPressed: _showDatePicker,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _onSubmit,
                child: Text("Add Transaction"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
