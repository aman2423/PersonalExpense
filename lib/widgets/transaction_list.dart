import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints){
          return Column(
            children: <Widget>[
              Text(
                'No transactions done yet!',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Color(0XFF5E085E),
                ),
              ),
              Container(
                  height: constraints.maxHeight*0.75,
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  )),
            ],
          );
    },)
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 7, horizontal: 8),
                elevation: 2,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text(
                          '₹${transactions[index].amount}',
                        ))),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 20,
                        color: Color(0XFF5E385E),
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    DateFormat('EEE, MMM d, y')
                        .format(transactions[index].date),
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteTx(transactions[index].id),
                    color: Theme.of(context).errorColor,
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
