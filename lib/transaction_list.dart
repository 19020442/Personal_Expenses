import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transaction.dart';

class TransactionList extends StatelessWidget {
  final Function deleteTransaction;
  final List<Transaction> transactions;
  TransactionList(this.transactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, contraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transaction add yet!',
                    // ignore: deprecated_member_use
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: contraints.maxHeight * 0.3,
                  ),
                  Container(
                      height: contraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                // return Card(
                //     child: Row(children: <Widget>[
                //   Container(
                //     margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                //     decoration: BoxDecoration(
                //         border: Border.all(
                //             color: Theme.of(context).primaryColor, width: 10)),
                //     padding: EdgeInsets.all(10),
                //     child: Text(
                //       '\$${transactions[index].amount.toStringAsFixed(2)}',
                //       style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: 30,
                //           color: Theme.of(context).primaryColor),
                //     ),
                //   ),
                //   Column(
                //     children: <Widget>[
                //       Text(
                //         transactions[index].title,
                //         style: Theme.of(context).textTheme.title,
                //       ),
                //       Text(DateFormat.yMMMd().format(transactions[index].date)),
                //     ],
                //   )
                // ]));
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                  elevation: 10,
                  child: ListTile(
                      leading: CircleAvatar(
                          radius: 30,
                          child: Container(
                              padding: EdgeInsets.all(5),
                              child: FittedBox(
                                  child: Text(
                                      '\$${transactions[index].amount}')))),
                      title: Text(
                        transactions[index].title,
                        // ignore: deprecated_member_use
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                          DateFormat.yMMMd().format(transactions[index].date)),
                      trailing: MediaQuery.of(context).size.width > 400
                          ? FlatButton.icon(
                              label: Text('Delete'),
                              textColor: Theme.of(context).errorColor,
                              icon: Icon(Icons.delete),
                              onPressed: () =>
                                  deleteTransaction(transactions[index].id),
                            )
                          : IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () =>
                                  deleteTransaction(transactions[index].id),
                            )),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
