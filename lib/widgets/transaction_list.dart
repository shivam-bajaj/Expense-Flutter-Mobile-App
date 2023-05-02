
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;

  TransactionList(this.transactions, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300   ,
      child: ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  child: Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 17),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 3, color: Colors.purpleAccent)),
                        child: Text(
                          '₹${transactions[index].amount}', //String interpolation
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactions[index].title,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat.yMMMd().format(transactions[index].date),
                            style: TextStyle(
                                color: Colors.grey, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                );
            },
            itemCount: transactions.length,

              
            ),
    );
  }
}