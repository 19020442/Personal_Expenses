import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPcOfTotal;
  ChartBar(this.label, this.spendingAmount, this.spendingPcOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, contraints) {
      return Column(
        children: [
          Container(
              height: contraints.maxHeight *0.15,
              child: FittedBox(
                  child: Text('\$${spendingAmount.toStringAsFixed(0)}',
                      style: TextStyle(fontWeight: FontWeight.bold)))),
          SizedBox(height: contraints.maxHeight *0.05),
          Container(
            height: contraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                )),
                FractionallySizedBox(
                  heightFactor: spendingPcOfTotal,
                  child: Container(
                      decoration:
                          BoxDecoration(color: Theme.of(context).primaryColor)),
                )
              ],
            ),
          ),
          SizedBox(height: contraints.maxHeight * 0.05),
          Container(height: contraints.maxHeight *0.15,child: FittedBox(child: Text(label))),
        ],
      );
    });
  }
}
