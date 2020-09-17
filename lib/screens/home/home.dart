import 'package:coffeeorder/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final AuthServices _auth=AuthServices();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Coffee Order"),
        actions: <Widget>[
          FlatButton.icon(
             icon: Icon(Icons.person), label: Text("Logout"),
             onPressed: () async{
              await _auth.signOut();
          },)
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
       
        ),
      );
  }
}