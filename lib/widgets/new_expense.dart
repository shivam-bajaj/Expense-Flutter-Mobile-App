import 'package:flutter/material.dart';
import 'package:xpenses/models/expenses.dart';

class NewExpense extends StatefulWidget {
  final Function(Expense expense) addExpense;

  const NewExpense({super.key, required this.addExpense});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;
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

  void submitExpense() {
    final enteredText = _titleController.text;
    final enteredAmount = int.tryParse(_amountController.text);
    final inValidAmount = enteredAmount == null || enteredAmount <= 0;
    if (enteredText.trim().isEmpty || inValidAmount || _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Invalid input'),
              content: const Text(
                  'Please make sure you entered a valid title, amount and date.'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Okay'))
              ],
            );
          });
      return;
    }
    widget.addExpense(Expense(
        title: enteredText,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));
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
              onSubmitted: (_) => submitExpense(),
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
                    onSubmitted: (_) => submitExpense(),
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
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
                const Spacer(),
                TextButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.pop(context)),
                ElevatedButton(
                  child: Text("Add Transaction"),
                  onPressed: submitExpense,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
