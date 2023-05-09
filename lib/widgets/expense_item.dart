import 'package:flutter/material.dart';
import '../models/expenses.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  const ExpenseItem(this.expense, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(expense.title),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text('₹${expense.amount}'), //String interpolation
                const Spacer(),
                Row(
                  children: [
                    // checkout value of expense.category in text widget
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 7),
                    Text(
                      expense.formattedDate,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
