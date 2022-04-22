import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'user.dart';
import 'authmain.dart';
import 'setUp.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final String uid;
  int semaphore = 0;
  List<int> thelist = [];
  DatabaseService({required this.uid});
  final AuthService _auth = AuthService();
  //collection reference
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

  int getSemaphore() {
    return semaphore;
  }

  List<int> getTheList(thelist) {
    //List<int> thereallist = [];
    Future.delayed(
      const Duration(seconds: 2));
    print('why');
    print(thelist);
    print('why');
    if (thelist.isNotEmpty) {
      //   for (int i = 0; i < thelist.length; i++) {
      //     thereallist[i] = thelist[i] as int;
      //   }

      //   return thereallist;
      // } else {
      
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
    //print('groupids');
    //print(data['GroupIDs'].length);
    //print('groupids');
    thelist = [];
    for (int i = 0; i <= data['GroupIDs'].length - 1; i++) {
      if (!thelist.contains(data['GroupIDs'][i])) {
        thelist.add(data['GroupIDs'][i]);
      }
      //print('look here top');
      print(thelist);
      //print('look here bot');
    }

    //thelist = data['GroupIDs'] as List<int>;

    //print(thisguy.toString());
    //print(thisguy);

    //var docs = thisguy.docs.map(json.decode(json.encode(doc.data())));
    // for (var snapshot in thisguy.docs) {
    //   Map<String, dynamic> data = snapshot.get(1);
    //   List<int> indexdb = data['GroupIDs'] as List<int>;
    //   List<int> newIndex = [];
    //   print(indexdb.length);
    //   for (int i = 0; i < indexdb.length; i++) {
    //     print(indexdb[i]);
    //     newIndex.add(indexdb[i]);
    //   }
    //   if (newIndex == null) {
    //     return [18];
    //   }
    //   return newIndex;
    // }
    // semaphore++;
    // print('semaphore');
    // print(semaphore);
    return thelist;
  }
  // Future getIndexDB() async {
  //   var uid = await _auth.getUID();

  //   //thisguy(document['GroupIDs'], value: indexDB);
  //   //['GroupIDs'];
  //   //return answer;
  //   //return userCollection.doc(result?.uid).get('EventIDs');
  // }

  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(userDataFromSnapshot);
  }

  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }
}
