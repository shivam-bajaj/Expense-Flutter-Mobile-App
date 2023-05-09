import 'package:flutter/material.dart';
import 'package:xpenses/models/expenses.dart';

class NewExpense extends StatefulWidget {
  //final Function addTx;

  NewExpense();

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  DateTime? _selectedDate;
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  void _datePicker() async {
    final currentDate = DateTime.now();
    final firstDate =
        DateTime(currentDate.year - 1, currentDate.month, currentDate.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: firstDate,
        lastDate: currentDate);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void submitData() {
    final enteredText = _titleController.text;
    final enteredAmount = int.parse(_amountController.text);
    if (enteredText.isEmpty || enteredAmount <= 0) {
      return;
    }

    //   widget.addTx(enteredText, enteredAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              maxLength: 40,
              controller: _titleController,
              onSubmitted: (_) => submitData(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    decoration:
                        InputDecoration(label: Text('Amount'), prefixText: '₹'),
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => submitData(),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Row(
                  children: [
                    Text(_selectedDate == null
                        ? ' No Date Selected'
                        : dateFormatter.format(_selectedDate!)),
                    IconButton(
                      icon: Icon(Icons.calendar_month),
                      onPressed: _datePicker,
                    )
                  ],
                )
              ],
            ),
            Row(
              children: [
                TextButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.pop(context)),
                ElevatedButton(
                  child: Text("Add Transaction"),
                  onPressed: submitData,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
