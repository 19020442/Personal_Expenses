import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/chart_bar.dart';
import 'package:my_app/transaction.dart';
import './transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalAmount += recentTransaction[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  Chart(this.recentTransaction);
  Widget build(BuildContext context) {
    return Card(
        elevation: 20,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          child: (Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues.map((data) {
                return Flexible(
                  fit:FlexFit.tight,
                  child: ChartBar(
                      data['day'],
                      data['amount'],
                      totalSpending == 0
                          ? 0.0
                          : ((data['amount'] as double) / totalSpending)),
                );
              }).toList())),
        ));
  }
}
