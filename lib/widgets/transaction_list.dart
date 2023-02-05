import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Txt.dart';
import '../main.dart';

class transactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function deleteTxn ;
  transactionList(@required this._userTransactions , this.deleteTxn);
  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
          ? Column(
              children: [
                Text(
                  "I'm Sleeping..",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                    height: MediaQuery.of(context).size.height*0.3,
                      width: MediaQuery.of(context).size.width*0.9,
                    child: FittedBox(
                        child :Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )))
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 6,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                            child: Text("₹${_userTransactions[index].amount}")),
                      ),
                    ),
                    title: Text(
                      "${_userTransactions[index].title}",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(DateFormat.yMMMd()
                        .format(_userTransactions[index].date)),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: (){
                        deleteTxn(_userTransactions[index].id);
                      },
                    ),
                  ),
                );
              },
              itemCount: _userTransactions.length,

    );
  }
}
