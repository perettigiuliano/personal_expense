import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
import 'package:personal_expense/utils/utils.dart';
import 'package:personal_expense/widgets/chart.dart';
import 'package:personal_expense/widgets/new_transaction.dart';
import 'package:personal_expense/widgets/transaction_list.dart';

import 'models/transaction.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PERSONAL EXPANSES',
      theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          fontFamily: "CascadiaPL",
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: "CascadiaPL",
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
                button: TextStyle(fontSize: 20)),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
        id: "1",
        title: "First",
        amount: 10.0,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        id: "2",
        title: "Second",
        amount: 20.0,
        date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(id: "3", title: "Third", amount: 30.0, date: DateTime.now()),
    Transaction(
        id: "1",
        title: "First",
        amount: 10.0,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        id: "2",
        title: "Second",
        amount: 20.0,
        date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(id: "3", title: "Third", amount: 30.0, date: DateTime.now()),
    Transaction(
        id: "1",
        title: "First",
        amount: 10.0,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        id: "2",
        title: "Second",
        amount: 20.0,
        date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(id: "3", title: "Third", amount: 30.0, date: DateTime.now()),
  ];
  bool _showChart = false;

  // List<Transaction> get _weekTransactions {
  //   return _transactions.where((element) {
  //     return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
  //   }).toList();
  // }

  void _addTransaction(String title, double amount, DateTime date) {
    Transaction newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);
    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _deleteTransaction(Transaction trx) {
    if (trx == null) {
      return;
    }
    setState(() {
      _transactions.remove(trx);
    });
  }

  void _showNewTxPanel(BuildContext bCtx) {
    showModalBottomSheet(
        context: bCtx,
        builder: (ctx) {
          return NewTransaction(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final portrait = mediaQueryData.orientation == Orientation.portrait;
    final appBar = AppBar(
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              _showNewTxPanel(context);
            })
      ],
      title: Center(
        child: Text(
          'PERSONAL EXPANSES',
          textAlign: TextAlign.center,
        ),
      ),
    );
    final txList = Container(
        height: Utils.calculateHeight(context, portrait ? 0.8 : 0.8,
            appBar.preferredSize.height + mediaQueryData.padding.top),
        child: TransactionList(_transactions, _deleteTransaction));
    final chart = Container(
        height: Utils.calculateHeight(context, portrait ? 0.3 : 0.8,
            appBar.preferredSize.height + mediaQueryData.padding.top),
        child: Chart(_transactions));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                  children: !portrait
                      ? <Widget>[
                          Container(
                              margin: EdgeInsets.all(5),
                              child: Text("Show chart")),
                          Switch(
                              value: _showChart,
                              onChanged: (val) {
                                setState(() {
                                  _showChart = val;
                                });
                              })
                        ]
                      : []),
              if (portrait) chart,
              if (portrait) txList,
              if (!portrait) _showChart ? chart : txList
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showNewTxPanel(context);
        },
      ),
    );
  }
}
