import 'package:flutter/material.dart';
import 'package:personal_expense/utils/utils.dart';
import '../models/transaction.dart';
import 'transaction-card.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransactionHandler;

  TransactionList(this._transactions, this._deleteTransactionHandler);

  Widget _transactionList(List<Transaction> trxList, BuildContext context) {
    if (!trxList.isEmpty) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return TransactionCard(
              _transactions[index], _deleteTransactionHandler);
        },
        itemCount: _transactions.length,
        scrollDirection: Axis.vertical,
      );
    } else {
      return LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Text(
              "No transactions",
              style: Theme.of(context).textTheme.title,
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
                height: Utils.calculateHeight(constraints, 0.6),
                child: Image.asset(
                  "assets/images/waiting.png",
                  fit: BoxFit.cover,
                )),
          ],
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _transactionList(_transactions, context);
  }
}
