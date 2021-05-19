import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget{
  AccountPage({Key key}) : super(key: key);
  @override 
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Page'),
      ),

      body: Column(
        children: [

        ],
      ),
      
    );
  }
}