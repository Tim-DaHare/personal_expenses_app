import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../classes/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function onPressDeleteItem;

  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.onPressDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 8,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Container(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                "\$${transaction.amount.toStringAsFixed(2)}",
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMMd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 450
            ? FlatButton.icon(
                onPressed: () => onPressDeleteItem(transaction.id),
                icon: Icon(Icons.delete),
                textColor: Theme.of(context).errorColor,
                label: Text("Delete"),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => onPressDeleteItem(transaction.id),
              ),
      ),
    );
  }
}
