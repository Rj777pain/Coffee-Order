import 'package:coffeeorder/models/userd.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class AuthServices{

  //create user object based on usercredintial
  Theuser _userFromUserCredintial(User user){
    return user != null ? Theuser(uid: user.uid):null;
  }

  final FirebaseAuth _auth= FirebaseAuth.instance;
  //sign in anon
  Future signinAnon() async{
    try{
      // ignore: deprecated_member_use
     // FirebaseUser user = await _auth.signInAnonymously() as FirebaseUser;
      UserCredential userCredential=await _auth.signInAnonymously();
      User user=userCredential.user;
      return _userFromUserCredintial(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //auth change user stream
  Stream<Theuser> get thisuser{
    
    return _auth.authStateChanges()
      //.map((User user) => _userFromUserCredintial(user));
      .map(_userFromUserCredintial);
  }
  //sign in email
  Future signInWithEmail(String email, String pswd) async{
    try{
      UserCredential userCredential=await _auth.signInWithEmailAndPassword(email: email, password: pswd);
      User user= userCredential.user;
      return _userFromUserCredintial(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //register
  Future regWithEmail(String email, String pswd) async{
    try{
      UserCredential userCredential=await _auth.createUserWithEmailAndPassword(email: email, password: pswd);
      User user= userCredential.user;
      return _userFromUserCredintial(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //signout
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}