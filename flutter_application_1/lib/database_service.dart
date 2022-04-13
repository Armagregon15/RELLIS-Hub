import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('Users');

  Future<void> updateUserData(groupIDs) async {
    return await brewCollection.doc(uid).set({
      'GroupIDs': groupIDs, 'UserID' : uid
    });
  }

  Stream<QuerySnapshot> get users {
    return brewCollection.snapshots();
  }
}
