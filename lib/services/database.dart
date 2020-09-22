import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeorder/models/order.dart';
import 'package:coffeeorder/models/userd.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference orderCollection = FirebaseFirestore.instance.collection('brew');

  Future updateUserData(String sugars,String name, int strength) async{
    return await orderCollection.doc(uid).set({
      'sugars':sugars,
      'name':name,
      'strength':strength,
    });
  }
  //orderlist from snapshot
  List<Order> _orderListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Order(
        name: doc.data()['name']??'',
        sugars: doc.data()['sugars']??'0',
        strength: doc.data()['strength']??0,
      );
    }).toList();
  }
  //userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      sugars: snapshot.data()['sugars'],
      strength: snapshot.data()['strength'],
    );
  }
  //get order stream
  Stream<List<Order>> get order{
    return orderCollection.snapshots()
      .map((_orderListFromSnapshot));
  }
  //get user doc stream
  Stream<UserData> get userData{
    return orderCollection.doc(uid).snapshots()
      .map(_userDataFromSnapshot);
  }
}

