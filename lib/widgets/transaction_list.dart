import 'package:flutter/material.dart';
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
      return Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            "No transactions",
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(
            height: 50,
          ),
          Container(
              height: 300,
              child: Image.asset(
                "assets/images/waiting.png",
                fit: BoxFit.cover,
              )),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _transactionList(_transactions, context);
  }
}
