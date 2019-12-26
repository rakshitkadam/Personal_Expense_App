import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import './model/Transactions.dart';
import './widgets/TextField.dart';
import './widgets/Transaction_list.dart';
import './widgets/Chart.dart';
void main()
{
  // SystemChrome.setPreferredOrientations([
  //  DeviceOrientation.portraitUp,
  // DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amberAccent,
        fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(title:TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 22
        )),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(title: TextStyle(
            fontFamily: 'OpenSans',
          fontSize: 30,
          )
          )
      ),
      ),
      home: MyHomePage(),
      title: 'Flutter App',
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 final titleController = TextEditingController();
 bool _status=true;
  List<Transactions> get _lastweektrans{
    return _userrTransactions.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))); 
    }).toList();
  }
 final amountController = TextEditingController();
final List<Transactions> _userrTransactions=[];
   void addTr(String title,double amount,DateTime date)
  {
    final newTran = Transactions(amount: amount,title: title, date: date,id: DateTime.now().toString());
    setState(() {
      _userrTransactions.add(newTran); 
    });
  }
  void showModel(BuildContext context)
  {
   showModalBottomSheet(
     context: context,
     builder: (_)
     {
       return GestureDetector(
         onTap: (){},
         child:  UTextField(addTr),
         behavior: HitTestBehavior.opaque,
       );
        
     },
   );
 
  }
   void _deleteTransaction(String id)
  {
    setState(() {
      
         _userrTransactions.removeWhere((tx){
           return tx.id==id;
      });
    });
    
  }
  @override
  Widget build(BuildContext context) {
    final _mediaquery = MediaQuery.of(context);
    final appBar = AppBar(title: Text('Personal Expense'),actions: <Widget>[
        IconButton(icon:Icon(Icons.add),onPressed: ()=>showModel(context))
      ],);
       final _orie = MediaQuery.of(context).orientation==Orientation.landscape?true:false;
    return Scaffold(
       
      appBar: appBar,

      body: SingleChildScrollView(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start ,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[ 
                 if(_orie)
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                    
                    Text('Show chart?',style: TextStyle(fontSize: 18),),
                   Switch(value: _status ,onChanged: (boool)
                  {
                    setState(() {
                      _status = boool;
                    });
                  },),
                 ],)
                  
                ,
               
              if(_orie==true)   _status?
              Container(child: Chart(_lastweektrans),
              width: double.infinity,
              height: (_mediaquery.size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top )*0.7
              )
             :
                  
             Container(
               width: double.infinity,
               height: (_mediaquery.size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7  ,
               child: TransactionList(_userrTransactions,_deleteTransaction)) ,
             if(_orie==false)
                 Container(child: Chart(_lastweektrans),
              width: double.infinity,
              height: (_mediaquery.size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top )*0.35
              ),   
               if(_orie==false)
             Container(
               width: double.infinity,
               height: (_mediaquery .size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.6 ,
               child: TransactionList(_userrTransactions,_deleteTransaction))
            ],
            ),
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton:FloatingActionButton(child: Icon(Icons.add),onPressed: (){showModel(context);},),
    );
  }
}