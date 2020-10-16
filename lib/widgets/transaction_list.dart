import 'package:flutter/material.dart';

import './transaction_item.dart';
import '../classes/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function onPressDeleteItem;

  TransactionList({this.transactions = const [], this.onPressDeleteItem});

  @override
  Widget build(BuildContext context) {
    return transactions.isNotEmpty
        ? ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return TransactionItem(
                  transaction: transactions[index],
                  onPressDeleteItem: onPressDeleteItem);
            },
          )
        : LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    "No transactions added yet!",
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      "assets/img/waiting.png",
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          );
  }
}
