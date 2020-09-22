import 'package:coffeeorder/screens/home/order_list.dart';
import 'package:coffeeorder/screens/home/settings_form.dart';
import 'package:coffeeorder/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:coffeeorder/services/database.dart';
import 'package:provider/provider.dart';
import 'package:coffeeorder/models/order.dart';

class Home extends StatelessWidget {
  final AuthServices _auth=AuthServices();
  
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }
    return StreamProvider<List<Order>>.value(
      value: DatabaseService().order,
      child: Scaffold(
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
            },),
            FlatButton.icon(
                onPressed: ()=> _showSettingsPanel(),
                icon: Icon(Icons.settings),
                label: Text("Settings"))
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/coffee_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: OrderList()),
        ),
    );
  }
}