import 'package:coffeeorder/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:coffeeorder/services/auth.dart';
import 'package:coffeeorder/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  bool loading=false;

  String email = "";
  String pswd = "";
  String error="";

  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign Up to Coffee order"),
        actions: [
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text("Sign In"))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
        ),

        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration:textInputDecoration,
                validator: (val)=>val.isEmpty?'Enter an Email': null,
                onChanged: (val) {
                  setState(() {
                    return email = val;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration:textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val)=>val.length<6?'Enter a password of 6+ length': null,
                onChanged: (val) {
                  setState(() {
                    return pswd = val;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                 if(_formKey.currentState.validate()){
                   setState(() {
                     loading=true;
                   });
                   dynamic result = await _auth.regWithEmail(email, pswd);
                   if(result==null){
                     setState(() {
                       error='Please provide a valid email';
                       loading=false;
                     });
                   }
                 }
                },
              ),
              SizedBox(height: 20.0,),
              Text(error,style: TextStyle(color: Colors.red, fontSize: 14.0),),
            ],
          ),
        ),
      ),
    );
  }
}
