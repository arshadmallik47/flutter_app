import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/chart_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/models/transaction.dart';

// ignore: camel_case_types
class chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  const chart(this.recentTransactions, {super.key});

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum = recentTransactions[i].amout;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalspending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'],
                  data['amount'],
                  totalspending == 0
                      ? 0
                      : (data["amount"] as double) / totalspending

                  // (data['amount'] as double) / totalspending,
                  ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
     
    

