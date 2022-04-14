import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter_application_1/calendar.dart';
import 'user.dart';
import 'events.dart';
//import 'package:firebase_core/firebase_core.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('Users');

  Future<void> updateUserData(List<int> groupIDs) async {
    return await brewCollection
        .doc(uid)
        .set({'GroupIDs': groupIDs, 'UserID': uid});
  }
//get users stream

  //Stream<QuerySnapshot> get users {
  // return brewCollection.snapshots();
  //}

  List<Events> _eventListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((d) {
        return Events(
          uid: d.get('UserID'),
          //eventName: doc.get("eventName") ?? "",
          //groupName: d.get("groupName") ?? "",
          groupID: d.get("GroupIDs"),
          //eventDate: doc.get("eventDate") ?? '',
        );
      }).toList();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return [];
    }
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: '',
      groupIDs: snapshot.get("GroupIDs"),
    );
  }

  Stream<List<Events>> get users {
    return brewCollection.snapshots().map(_eventListFromSnapshot);
  }

  Future<List<UserData>> get userData {
    return brewCollection
        .doc(uid)
        .snapshots()
        .map(_userDataFromSnapshot)
        .toList();
  }
}
