import 'package:coffeeorder/models/userd.dart';
import 'package:flutter/material.dart';
import 'package:coffeeorder/screens/home/home.dart';
import 'package:coffeeorder/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user= Provider.of<Theuser>(context) ?? null;
    //return home or authenticate
    if(user==null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}