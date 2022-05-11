import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'user.dart';
import 'authmain.dart';
import 'setUp.dart';

//class to work with the database
class DatabaseService {
  final String uid; //current user's id
  bool isAdmin = false; //true if current user is admin
  int semaphore = 0;
  List<int> thelist = []; //stores user's selected group ids
  DatabaseService({required this.uid});
  final AuthService _auth = AuthService(); //instanciates auth
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  final CollectionReference eventCollection =
      FirebaseFirestore.instance.collection('Events');
  
  //function to save the users list of groups in a non async variable
  void setTheList(List<int> newList) {
    thelist = newList;
  }
  
  //function to get list for Home
  void getHomeList(context) {
    if (semaphore == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    }
  }

  //function to get the isAdmin bool
  bool getIsAdmin() {
    return isAdmin;
  }

  //async function to chech if current user is admin
  Future<void> checkIfAdmin() async {
    if (_auth.admin == await _auth.getUID()) {
      isAdmin = true;
    } else {
      isAdmin = false;
    }
  }

  //function to get the users list of group ids
  List<int> getTheList(thelist) {
    Future.delayed(const Duration(seconds: 2));
    if (thelist.isNotEmpty) {
      return thelist;
    } else {
      return [18];
    }
  }

  //function to push new list of groups to database
  Future<void> updateUserData(groupIDs) async {
    var uid = await _auth.getUID();
    return await userCollection
        .doc(uid)
        .set({'GroupIDs': groupIDs, 'UserID': uid});
  }

  //function to return a snapshot of events for a user async
  Future<Stream<QuerySnapshot<Object?>>> getSnaps() async {
    Future<List> newIndex =
        DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
            .getIndexDB();
    return FirebaseFirestore.instance
        .collection('Events')
        .where('GroupID', whereIn: await newIndex)
        .snapshots();
  }

  //function to return a snapshot of events for a user not async
  Stream<QuerySnapshot> get events {
    return eventCollection.snapshots();
  }

  //function to get current users data from database
  UserData userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(uid: uid, groupIDs: snapshot.get('GroupIDs'));
  }

  //async function to get a users group selections and save in a class variable for non async functions to grab
  Future<List<int>> getIndexDB() async {
    var uid = await _auth.getUID();
    var thisguy = await userCollection.doc(uid.toString()).get();

    Map<String, dynamic> data = thisguy.data() as Map<String, dynamic>;
    thelist = [];
    for (int i = 0; i <= data['GroupIDs'].length - 1; i++) {
      if (!thelist.contains(data['GroupIDs'][i])) {
        thelist.add(data['GroupIDs'][i]);
      }
    }

    return thelist;
  }

  //function to return user data in a stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(userDataFromSnapshot);
  }

  //function to return user collection in a stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }
}
