import 'package:flutter/material.dart';

import '../Models/transaction.dart';
import './transaction_item.dart';

class TransactioList extends StatelessWidget {
  final List<Transaction> transactions;
  var removeTrans;
  TransactioList(this.transactions, this.removeTrans);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .6,
      //To align everything in the container
      alignment: Alignment.center,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    "No Transactions Added",
                    style: Theme.of(context).textTheme.title,
                  ),

                  //instead of margin you can add a SizedBox with a height
                  const SizedBox(
                    height: 10,
                  ),

                  Container(
                    margin: const EdgeInsets.all(10),
                    height: constraints.maxHeight * .6,
                    child: Image.asset(
                      'assets/image/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return TransactionItem(
                  transaction: transactions[index],
                  removeTrans: removeTrans,
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
