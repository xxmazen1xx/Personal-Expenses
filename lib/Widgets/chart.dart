import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/Models/transaction.dart'; 
import 'chart_bar.dart';


class Chart extends StatelessWidget {
  List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final dayWeek = DateTime.now().subtract(Duration(days: index), );
      var totalPrice = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if(recentTransactions[i].dateTime.day == dayWeek.day &&
         recentTransactions[i].dateTime.month == dayWeek.month &&
          recentTransactions[i].dateTime.year == dayWeek.year){
          totalPrice += recentTransactions[i].price;
        }
      }
      return {
        'day': DateFormat.E().format(dayWeek).substring(0, 1),
        'price': totalPrice,
      };
    }
    ).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactions.fold(0.0, (sum, item) {
      return sum + (item['price']as double);
    });
  }


  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height * .22,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.all(20),
        
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: groupedTransactions.map((data) {
              // return Text("${data['day']}: ${data['price']}");
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  (data['day']) as String, 
                  (data['price']) as double, 
                  totalSpending == 0.0
                      ? 0.0
                      : (data['price'] as double) / totalSpending,
                ),
              );

            }).toList(),
          ),
        ),
      ),
    );
  }
}
