import 'package:flutter/material.dart';
import 'package:personal_expense/utils/utils.dart';

class ChartBar extends StatelessWidget {
  String label;
  double amount;
  double percentage;
  DateTime date;

  ChartBar(this.label, this.amount, this.percentage, this.date);

  @override
  Widget build(BuildContext context) {
    return /* GestureDetector(
      onTap: () {
        print(this.date);
      },
      child:  */
        LayoutBuilder(builder: (bc, constraints) {
      return Column(
        children: <Widget>[
          Container(
            height: Utils.calculateHeight(constraints, 0.7),
            width: 50,
            child: Tooltip(
              message: "\$${this.amount.toStringAsFixed(2)}",
              child: Stack(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: Color.fromRGBO(220, 200, 220, 1),
                    borderRadius: BorderRadius.circular(20),
                  )),
                  FractionallySizedBox(
                      heightFactor: this.percentage,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20)),
                      )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: Utils.calculateHeight(constraints, 0.1),
          ),
          Container(
              height: Utils.calculateHeight(constraints, 0.2),
              child: Text(this.label))
        ],
      );
    })
        /* ) */;
  }
}
