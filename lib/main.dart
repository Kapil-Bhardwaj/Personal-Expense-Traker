import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:karcha_tracker/widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'models/Txt.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          applyElevationOverlayColor: true,
          fontFamily: 'QuickSand',
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'Opensans',
                      fontSize: 78,
                      fontWeight: FontWeight.w900),
                  button: TextStyle(color: Colors.white),
                ),
          )),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(id: "t1", title: "New Shoes", amount: 30, date: DateTime.now()),
    Transaction(id: "t2", title: "cycle", amount: 90, date: DateTime.now())
  ];

  List<Transaction> get _recentTxt {
    return _userTransactions.where((tx) {
      tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }



  void _addTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTxn(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (Ctx) {
          return NewTransaction(_addTransaction);
        });
  }

void deleteTxn( String id)
{
  setState(() {
    _userTransactions.removeWhere((txn) => txn.id==id);
  });
}

  bool _ShowValue = false;

  @override
  Widget build(BuildContext context) {

    final oppBar =AppBar(
      title: Text('Personal Expense tracker'),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTxn(context), icon: Icon(Icons.add)),
      ],
    );
    final txnListWidget = Container(
        height: (MediaQuery.of(context).size.height- oppBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
        child: transactionList(_userTransactions,deleteTxn));

    final isPotrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(

      appBar: oppBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
           if(!isPotrait) Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Show Chart"),
                Switch(value: _ShowValue, onChanged: (val){
                 setState((){
                 _ShowValue = val;
                 });


                })
              ],
            ),

            //chart part here
        if(isPotrait)
          Container(
              height: (MediaQuery.of(context).size.height- oppBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.3,
              child: Chart(_userTransactions)),
         if(isPotrait) txnListWidget,
         if(!isPotrait)  _ShowValue? Container(
                height: (MediaQuery.of(context).size.height- oppBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
                child: Chart(_userTransactions))
                 :
            Container(
                height: (MediaQuery.of(context).size.height- oppBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
                child: transactionList(_userTransactions,deleteTxn)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTxn(context),
      ),
    );
  }
}
