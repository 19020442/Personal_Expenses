import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function transactionHandler;

  NewTransaction(this.transactionHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _choosenDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredAmount <= 0 || enteredTitle.isEmpty || _choosenDate == null) {
      return;
    }
    widget.transactionHandler(enteredTitle, enteredAmount, _choosenDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      setState(() {
        _choosenDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        elevation: 20,
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              top: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                  onSubmitted: (_) => _submitData()),
              TextField(
                  controller: _amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _submitData()),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      (_choosenDate == null)
                          ? 'No Date Choosen!'
                          : '${DateFormat.yMMMd().format(_choosenDate)}',
                    ),
                  ),
                  
                  FlatButton(
                    onPressed: _presentDatePicker,
                    // child: Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold),) ,
                    // ignore: deprecated_member_use
                    child: (Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
              RaisedButton(
                  onPressed: _submitData,
                  child: Text(
                    'Add Transaction',
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color)
            ],
          ),
        ),
      ),
    );
  }
}
