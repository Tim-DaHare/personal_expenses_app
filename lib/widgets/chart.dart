import 'package:flutter/material.dart';
import 'package:personal_expenses_app/widgets/chart_bar.dart';
import '../classes/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({this.recentTransactions});

  double get totalRecentSpending {
    return groupedTransactions.fold(0.0, (sum, tsx) => sum + tsx["amount"]);
  }

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var dayAmount = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          dayAmount += recentTransactions[i].amount;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 2),
        "amount": dayAmount,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: groupedTransactions
              .map((gTsx) {
                return Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: ChartBar(
                    label: gTsx["day"],
                    spendingAmount: gTsx["amount"],
                    spendingPctOfTotal: totalRecentSpending != 0.0
                        ? (gTsx["amount"] as double) / totalRecentSpending
                        : 0.0,
                  ),
                );
              })
              .toList()
              .reversed
              .toList(),
        ),
      ),
    );
  }
}
