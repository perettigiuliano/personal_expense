import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Transaction trx;
  final Function _deleteTransactionHandler;

  TransactionCard(this.trx, this._deleteTransactionHandler);

  @override
  Widget build(BuildContext context) {
    // final numberFormat = NumberFormat("#,##0.00", "it_IT");
    final numberFormat = NumberFormat.simpleCurrency();
    final double appWidth = MediaQuery.of(context).size.width;
    return Card(
      elevation: 2,
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
              padding: const EdgeInsets.all(5),
              child:
                  FittedBox(child: Text(numberFormat.format(this.trx.amount)))),
        ),
        title: Text(
          "${this.trx.title}",
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMMd().format(this.trx.date),
          style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        trailing: appWidth > 460
            ? FlatButton.icon(
                textColor: Theme.of(context).errorColor,
                onPressed: () {
                  _deleteTransactionHandler(this.trx);
                },
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: Theme.of(context).errorColor,
                ),
                label: const Text("Delete"))
            : IconButton(
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () {
                  _deleteTransactionHandler(this.trx);
                },
              ),
      ),
    );
  }
}
