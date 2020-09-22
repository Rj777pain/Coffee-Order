import 'package:coffeeorder/models/userd.dart';
import 'package:coffeeorder/services/database.dart';
import 'package:coffeeorder/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:coffeeorder/shared/constant.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Theuser>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your Order settings.',
                    style: TextStyle(fontSize: 18.0, color: Colors.brown[1000]),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    style: TextStyle(color: Colors.brown[900]),
                    decoration: textInputDecoration.copyWith(
                        hintText: "Name", fillColor: Colors.brown[50]),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 10.0),
//                Container(
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(15.0),
//                    color: Colors.brown[50],
//                  ),
//
//                  child: Row(
//                    children: [
//                      SizedBox(width: 5.0,),
                  DropdownButtonFormField(
                    dropdownColor: Colors.brown[100],
                    value: _currentSugars ?? userData.sugars,
                    decoration: textInputDecoration.copyWith(
                        fillColor: Colors.brown[50]),
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text(
                          '$sugar sugars',
                          style: TextStyle(color: Colors.brown[900]),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars = val),
                  ),

//                      SizedBox(width: 5.0,),
//                    ],
//                  ),
//                  ),

                  SizedBox(height: 10.0),
                  Slider(
                    min: 100.0,
                    activeColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    max: 900.0,
                    divisions: 8,
                    value: (_currentStrength ?? 100).toDouble(),
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugars ?? userData.sugars,
                              _currentName ?? userData.name,
                              _currentStrength ?? userData.strength);
                          Navigator.pop(context);
                        }
                      }),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
