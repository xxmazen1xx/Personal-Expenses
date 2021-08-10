import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double SpendingPctOfTot;

  ChartBar(this.label, this.spendingAmount, this.SpendingPctOfTot);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder( builder: (ctx, constraints){
      return Column(children: [
        Container(
          height: constraints.maxHeight * .15,
          child: FittedBox(
            child: Text(
              "\$${spendingAmount.round()}",
            ),
          ),
        ),
        SizedBox(height: constraints.maxHeight * .05 ,),
        
        Container(
          height: constraints.maxHeight * .6,
          width: constraints.maxWidth * .3,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1,),
                borderRadius: BorderRadius.circular(20),
                color: Color.fromRGBO(220, 220, 220, 1),
              ),
            ),
            FractionallySizedBox(
              heightFactor: SpendingPctOfTot,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
    
    
          ],),
        ),
        SizedBox(height: constraints.maxHeight * .05 ,),
    
        Container(
          height: constraints.maxHeight * .15,
          child: FittedBox(
            child: Text(
              label
            ),
          ),
        ),
    
      ],);
    });

  }
}