import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xpenses/widgets/new_transaction.dart';
import 'package:xpenses/widgets/transaction_list.dart';

import 'models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xpenses',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   final List<Transaction> _userTransactions=[
    Transaction(id: 't1', title: 'cigg', amount: 330, date: DateTime.now()),
    // Transaction(id: 't2', title: 'cigg1', amount: 300, date: DateTime.now()),
    // Transaction(id: 't3', title: 'cigg2', amount: 350, date: DateTime.now()),
    // Transaction(id: 't3', title: 'cigg2', amount: 350, date: DateTime.now()),
    // Transaction(id: 't3', title: 'cigg2', amount: 350, date: DateTime.now()),
    // Transaction(id: 't3', title: 'cigg2', amount: 350, date: DateTime.now()),
    // Transaction(id: 't3', title: 'cigg2', amount: 350, date: DateTime.now()),
    Transaction(id: 't3', title: 'cigg2', amount: 350, date: DateTime.now()),
  ];

  void _addNewTransaction(String title, int amount){
    final newTx = Transaction(id: DateTime.now().toString(), title: title, amount: amount, date: DateTime.now());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx){

    showModalBottomSheet(context: ctx, builder:((_) {
      return NewTransaction(_addNewTransaction);
    }
    ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xpenses'),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Colors.deepPurpleAccent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        toolbarHeight: 70,
        actions: [
          IconButton(icon: Icon(Icons.add_outlined), onPressed:(() => _startAddNewTransaction(context))),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed:(() => _startAddNewTransaction(context)),),
      body: SingleChildScrollView(
        child: Column(
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
            TransactionList(_userTransactions),
          ],
        ),
      ),
    );
  }
}
