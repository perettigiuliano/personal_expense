import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  List<Transaction> _transactions;

  Chart(this._transactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double dayTotal = 0.0;

      for (Transaction trx in _transactions) {
        if ((trx.date.day == weekDay.day) &&
            (trx.date.month == weekDay.month) &&
            (trx.date.year == weekDay.year)) {
          dayTotal += trx.amount;
        }
      }
      String x = DateFormat.E().format(weekDay).substring(0, 1);
      return {"day": x, "amount": dayTotal, "date": weekDay};
    }).reversed.toList();
  }

  double get weekTotal {
    final x = groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + element["amount"];
    });
    return x == 0 ? 1 : x;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar("${e["day"]}", e["amount"],
                  (e["amount"] as double) / weekTotal, e["date"]),
            );
          }).toList(),
        ),
      ),
/* Column(
        children: <Widget>[
          SizedBox(height: 5),
          Text(
            "Last week transactions",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: groupedTransactionValues.map((e) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar("${e["day"]}", e["amount"],
                      (e["amount"] as double) / weekTotal, e["date"]),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 5),
        ],
      ), */
    );
    // return Container(
    //   width: double.infinity,
    //   margin: EdgeInsets.only(left: 10, right: 10),
    //   child: Card(
    //     color: Colors.yellow,
    //     child: Text(
    //       "Chart",
    //       textAlign: TextAlign.center,
    //     ),
    //     elevation: 5,
    //   ),
    // );
  }
}
