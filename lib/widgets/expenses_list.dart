import 'package:flutter/material.dart';
import 'package:xpenses/main.dart';
import 'package:xpenses/widgets/expense_item.dart';
import '../models/expenses.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          // color: kColorScheme.error,
          color: Theme.of(context).colorScheme.error,
        ),
        onDismissed: (direction) => onRemoveExpense(expenses[index]),
        key: ValueKey(expenses[index]),
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
