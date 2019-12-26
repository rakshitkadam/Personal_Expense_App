import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/model/Transactions.dart';
class TransactionList extends StatelessWidget {
  final Function handler;
  final List<Transactions> userTransactions;
  TransactionList(this.userTransactions,this.handler); 

  @override
  Widget build(BuildContext context) {
    
    return Container(
      //transform: Matrix4.rotationZ(0.09),
      child: userTransactions.isEmpty? 
      
      LayoutBuilder(
        builder: (ctx,constraint){return
          Column(children: <Widget>[
        Card(
    
                  child: Text('No Transactions added yet!',
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(height: constraint.maxHeight*0.05),
        Card(
            child: Container(
            height: constraint.maxHeight*0.7 ,
            child: Image.asset(
             'assets/images/image.png',
             fit: BoxFit.contain)
             ),
        ),
      ],
      );
        },
       
      )
      :
       ListView.builder(
        itemBuilder: (ctx,index)
        {
              return Card(
                          elevation: 6,
                          margin:EdgeInsets.all(5),
                              child: ListTile(
                  leading: CircleAvatar(
                    radius:30,
                    child: Padding(
                      padding:EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('\$${userTransactions[index].amount}')
                        )
                        ),
                  ),
                  title: Text('${userTransactions[index].title}',
                  style: Theme.of(context).textTheme.title,
 
                  ),
                   subtitle: Text(DateFormat.yMMMEd().format(userTransactions[index].date)),
                   trailing: MediaQuery.of(context).size.width>460?
                   FlatButton(child:Text('Delete',style: TextStyle(color: Colors.white),),color: Colors.red,onPressed:(){ 
                     handler(userTransactions[index].id);
                     }  ,)
                    : IconButton (icon: Icon(Icons.delete_outline,),onPressed: (){ 
                     handler(userTransactions[index].id);
                     } ,color: Colors.red,),
                ),
              );
        },
       itemCount: userTransactions.length,
      ),
    );
  } 
}