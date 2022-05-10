import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'user.dart';
import 'authmain.dart';
import 'setUp.dart';

class DatabaseService {
  final String uid;
  bool isAdmin = false;
  int semaphore = 0;
  List<int> thelist = [];
  DatabaseService({required this.uid});
  final AuthService _auth = AuthService();
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  final CollectionReference eventCollection =
      FirebaseFirestore.instance.collection('Events');
  void setTheList(List<int> newList) {
    thelist = newList;
  }

  void getHomeList(context) {
    if (semaphore == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    }
  }

  bool getIsAdmin() {
    return isAdmin;
  }

  Future<void> checkIfAdmin() async {
    if (_auth.admin == await _auth.getUID()) {
      isAdmin = true;
    } else {
      isAdmin = false;
    }
  }

  List<int> getTheList(thelist) {
    Future.delayed(const Duration(seconds: 2));
    print('why');
    print(thelist);
    print('why');
    if (thelist.isNotEmpty) {
      return thelist;
    } else {
      print('i did a thing that was bad');
      return [18];
    }
  }

  Future<void> updateUserData(groupIDs) async {
    var uid = await _auth.getUID();
    print('updating');
    print(uid);
    print(groupIDs);
    return await userCollection
        .doc(uid)
        .set({'GroupIDs': groupIDs, 'UserID': uid});
  }

  Future<Stream<QuerySnapshot<Object?>>> getSnaps() async {
    Future<List> newIndex =
        DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
            .getIndexDB();
    return FirebaseFirestore.instance
        .collection('Events')
        .where('GroupID', whereIn: await newIndex)
        .snapshots();
  }

  Stream<QuerySnapshot> get events {
    return eventCollection.snapshots();
  }

  UserData userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(uid: uid, groupIDs: snapshot.get('GroupIDs'));
  }

  Future<List<int>> getIndexDB() async {
    var uid = await _auth.getUID();
    print(uid);
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

  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(userDataFromSnapshot);
  }

  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }
}
