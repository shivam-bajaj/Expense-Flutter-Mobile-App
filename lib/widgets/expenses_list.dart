import 'package:flutter/material.dart';
import 'package:xpenses/widgets/expense_item.dart';
import '../models/expenses.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;

  const ExpensesList({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) {
          return ExpenseItem(expenses[index]);
        },
      ),
    );
  }
}
