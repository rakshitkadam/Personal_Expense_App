import 'package:flutter/material.dart';
class BarChart extends StatelessWidget {
  final String label;
  final double percent;
  final double totalSum;
  BarChart(this.label,this.percent,this.totalSum);
  @override
  Widget build(BuildContext context) {
   return LayoutBuilder(
     builder: (ctx,constraits){
     return Container(
          padding: EdgeInsets.all(constraits.maxHeight*0.05),
          child: Column(children: <Widget>[
        Container(
          height:constraits.maxHeight*0.12,
          child: FittedBox(
            child: Text('\$${totalSum.toStringAsFixed(0)}')
            ),
        ),
        SizedBox(height: constraits.maxHeight*0.05),
        Container(
          width:10,
          height: constraits.maxHeight*0.5,
          child: Stack(children: <Widget>[
            Container(decoration: BoxDecoration(
              border: Border.all(color: Colors.grey,width: 1.0),
              color:Color.fromRGBO(220, 220, 220, 1),
              borderRadius: BorderRadius.circular(10)
            ),),
            FractionallySizedBox(heightFactor: percent,child: Container(decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10)
            ),),)
          ],
          )
        ),
        SizedBox(height: constraits.maxHeight*0.05,),
        Container(height:constraits.maxHeight*0.11,child: FittedBox(child: Text(label))),
      ],
      ),
    );
     }
   );
  }
}