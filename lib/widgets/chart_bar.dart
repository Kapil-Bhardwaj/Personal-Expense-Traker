import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPct;
  ChartBar(this.label, this.spendingAmount, this.spendingPct);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, Constraints){
     return  Column(
       children: [
         Container(
             height: Constraints.maxHeight*0.15,
             child: FittedBox(
                 child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
         SizedBox(
           height: Constraints.maxHeight*0.05,
         ),
         Container(
           height: Constraints.maxHeight *0.6,
           width: Constraints.maxWidth*0.25,
           child: Stack(
             children: [
               Container(
                 decoration: BoxDecoration(
                   border: Border.all(color: Colors.grey, width: 1.0),
                   color: Color.fromRGBO(220, 220, 220, 1),
                   borderRadius: BorderRadius.circular(10),
                 ),
               ),
               FractionallySizedBox(
                 heightFactor: spendingPct,
                 child: Container(
                   decoration: BoxDecoration(
                     color: Theme.of(context).primaryColor,
                     borderRadius: BorderRadius.circular(10),
                   ),
                 ),
               )
             ],
           ),
         ),
           SizedBox(height: Constraints.maxHeight*0.05,),
         Container(
           height: Constraints.maxHeight*0.15,
           child: Text('$label',style: TextStyle(
             fontWeight: FontWeight.w700,
           ),),
         )
       ],
     );
    },);

  }
}
