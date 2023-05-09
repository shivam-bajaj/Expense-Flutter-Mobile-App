import 'package:flutter/material.dart';
import 'package:xpenses/widgets/new_expense.dart';
import 'package:xpenses/widgets/expenses_list.dart';

import 'models/expenses.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xpenses',
      theme: ThemeData(useMaterial3: true),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
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

  // void _addNewTransaction(String title, int amount) {
  //   final newTx = Expense(
  //       title: title,
  //       amount: amount,
  //       date: DateTime.now());
  //   setState(() {
  //     _userExpenses.add(newTx);
  //   });
  // }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        context: context,
        builder: ((ctx) {
          return NewExpense();
          //return NewExpense(_addNewTransaction);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xpenses'),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Colors.deepPurpleAccent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        toolbarHeight: 70,
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 100,
              padding: new EdgeInsets.only(bottom: 10),
              child: Card(
                child: Text("Chart"),
                color: Colors.blue,
                elevation: 7,
              )),
          Expanded(
            child: ExpensesList(
              expenses: _userExpenses,
            ),
          ),
        ],
      ),
    );
  }
}
