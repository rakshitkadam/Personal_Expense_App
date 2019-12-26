import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UTextField extends StatefulWidget {
  final Function handler;
  UTextField(this.handler);

  @override
  _UTextFieldState createState() => _UTextFieldState();
}

class _UTextFieldState extends State<UTextField> {
  final titleController = TextEditingController();
  DateTime recDate;
  final amountController = TextEditingController();

  void _addtrans() {
    final extractTitleController = titleController.text;
    if (amountController.text.isEmpty) return;
    final extractamount = double.parse(amountController.text);

    if (extractamount <= 0 ||
        extractTitleController.isEmpty ||
        recDate == null) {
      return;
    }
    widget.handler(extractTitleController, extractamount, recDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null) {
        return;
      } else {
        setState(() {
          recDate = date;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    
    // return SingleChildScrollView(
           return Card(
        elevation: 10,
        child: Container(
         
          margin: EdgeInsets.all(10),
         padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title '),
                controller: titleController,
                onSubmitted: (_) => _addtrans(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount '),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _addtrans(),
                //For ios devices use keyboard_type numberWithOptions.
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(recDate == null
                            ? 'No Date chosen'
                            : 'Picked date:${DateFormat.yMd().format(recDate)}')),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text('Choose Date',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: _presentDatePicker,
                    )
                  ],
                ),
              ),
              FlatButton(
                  color: Colors.purple,
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: _addtrans)
            ],
          ),
        ),
      
    );
  }
}
