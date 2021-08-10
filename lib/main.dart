import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses/Widgets/chart.dart';

import '/Widgets/transaction_list.dart';
import 'Models/transaction.dart';
import '/Widgets/new_transaction.dart';

void main() {
  //A lazy sol for the fucked up landscape mode orientation

  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]); 

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //This is the name of the app on your phone
      title: "Personal-Expenses",
      // theme: ThemeData(
      //   primarySwatch: Colors.indigo,
      //   accentColor: Colors.amber,
      // ),

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //The user_transaction File
  var idCounter = 0;
  final List<Transaction> userTransactions = [];
  
  bool _showChart = false;

  void _addNewTrnasactions(String txName, double txPrice, DateTime chosenDate) {
    idCounter += 1;
    final newTx = Transaction(
        name: txName, price: txPrice, id: idCounter, dateTime: chosenDate);

    setState(() {
      userTransactions.add(newTx);
    });
  }

  void _removeTransaction(var id){
    setState(() {
      userTransactions.removeWhere((tx) {
        return tx.id == id;
      });  
    }); 
  }

  //End of user_transaction file
  void startNewTransactionModal(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addNewTrnasactions),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Transaction> get recentTransactions{
    return userTransactions.where((tx) {
      return tx.dateTime.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  ////////////////////////////
  /// SOME BUILDER METHODS ///
  ////////////////////////////
  
  Widget _buildLandscapeContent (){

  }

  Widget _buildPortraitContent (){

  }


  @override
  Widget build(BuildContext context) {
    var isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return MaterialApp(
      
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: "Quicksand",

          //This is foe everything else if you need anothe font styling data
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                button: TextStyle(
                  color: Colors.white,
                ),
              ),

          //this is specific for the appBar only
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 20,
                  ),
                ),
          )),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Personal Expenses"),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => startNewTransactionModal(context),
            ),
          ],
        ),
        
        

        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isLandscape ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Show Chart"),
                  Switch.adaptive(value: _showChart, onChanged: (val){
                    setState(() {
                      _showChart = val;
                    });
                  })
                ],
              ) :

              isLandscape ? _showChart 
              ? Container(
                  width: double.infinity,
                  child: Chart(recentTransactions)
                )

              :TransactioList(userTransactions, _removeTransaction)
              
              : Container(
                width: double.infinity,
                child: Chart(recentTransactions)
              ),
              TransactioList(userTransactions, _removeTransaction)
            ],
          ),
        ),

        // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => startNewTransactionModal(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
