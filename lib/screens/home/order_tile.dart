import 'package:flutter/material.dart';
import 'package:coffeeorder/models/order.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  OrderTile({this.order});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[order.strength],
            backgroundImage: AssetImage("images/coffee_icon.png"),
          ),
          title: Text(order.name),
          subtitle: Text("Takes ${order.sugars} sugar(s)"),
        ),
        elevation: 4.0,
      ),
    );
  }
}
