import 'package:flutter/material.dart';
import 'package:xpenses/widgets/new_expense.dart';
import 'package:xpenses/widgets/expenses_list.dart';

import 'models/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent);

void main() => runApp(MaterialApp(
      title: 'Xpenses',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
          centerTitle: true,
          elevation: 10,
          toolbarHeight: 40,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.primary,
          foregroundColor: kColorScheme.primaryContainer,
        )),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
          backgroundColor: kColorScheme.secondary,
          foregroundColor: kColorScheme.secondaryContainer,
        )),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: kColorScheme.primary,
              ),
            ),
      ),
      home: const HomePage(),
    ));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Expense> _userExpenses = [
    Expense(
        title: 'cig1',
        amount: 330,
        date: DateTime.now(),
        category: Category.food),
    Expense(
      title: 'cig2',
      amount: 334,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
        title: 'c4',
        amount: 340,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: 'c5',
        amount: 350,
        date: DateTime.now(),
        category: Category.food),
  ];

  void _addNewExpense(Expense expense) {
    setState(() {
      _userExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _userExpenses.indexOf(expense);
    setState(() {
      _userExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense Deleted'),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _userExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: ((ctx) {
          return NewExpense(
            addExpense: _addNewExpense,
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = ExpensesList(
      expenses: _userExpenses,
      onRemoveExpense: _removeExpense,
    );
    if (_userExpenses.isEmpty) {
      mainContent = const Center(
        child: Text("No Expense found, Start adding some"),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Xpenses'),
        actions: [
          IconButton(
              icon: const Icon(Icons.add_outlined),
              onPressed: _openAddExpenseOverlay),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _openAddExpenseOverlay,
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.only(bottom: 10),
              child: Text("Chart")),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
