import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final nameString = TextEditingController();
  final priceString = TextEditingController();
  var _selectedDate = DateTime.now();

  void SubmitData() {
    var transName = nameString.text;
    var transPrice = double.parse(priceString.text);

    if (transName.isEmpty ||
        transPrice.isNegative ||
        priceString.text.isEmpty ||
        _selectedDate == null ||
        priceString.text.isEmpty) {
      print("Wrong Data Entered");
      return;
    }
    widget.addTx(transName, transPrice, _selectedDate);
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      _selectedDate = (pickedDate) as DateTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.fromLTRB(
            10,
            10,
            10,
            MediaQuery.of(context).viewInsets.bottom + 120,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Title"),
                controller: nameString,
                cursorColor: Theme.of(context).canvasColor,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Price"),
                controller: priceString,
                cursorColor: Theme.of(context).canvasColor,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Text(_selectedDate == null
                        ? "No Date Chosen!"
                        : "Picked Date: ${DateFormat.yMd().format(_selectedDate)}"
                    ),
                    FlatButton(
                      onPressed: _presentDatePicker,
                      child: const Text(
                        "Choose Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Colors.purple,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                child: const Text('Add Transaction'),
                color: Colors.purple,
                textColor: Colors.white,
                onPressed: SubmitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
