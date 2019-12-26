import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/Transactions.dart';
import './Chart_dia.dart'; 
class Chart extends StatelessWidget {
  final List<Transactions>list;
  Chart(this.list);
var sum =0.0;
  List<Map<String,Object>> get groupTransactionValue{
    return List.generate(7, (index){
       final weekDay = DateTime.now().subtract( Duration(days: index));
       double totalSum = 0.0;

      for(var i = 0;i<list.length;i++)
      {
        if(list[i].date.day==weekDay.day&&list[i].date.month==weekDay.month&&list[i].date.year==weekDay.year)
        {totalSum +=  list[i].amount;}
 
      }
     sum+=totalSum;
    return {'day':DateFormat.E().format(weekDay).substring(0,1),'amount':totalSum};
    }).reversed.toList();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation : 6,
      
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:groupTransactionValue.map((data){
        return Flexible (
        
          child: BarChart(data['day'],sum==0.0?0.0:(data['amount']as double)/sum  ,data['amount'],));
       
      }).toList(),
      ),
    );
  }
}