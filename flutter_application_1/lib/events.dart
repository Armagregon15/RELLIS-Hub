import 'package:cloud_firestore/cloud_firestore.dart';

class Events {
  String? eventName;
  //final String eventDate;
  //final String eventName;
  //final String groupName;
  int? groupID;
  Timestamp? eventDate;
  String? groupName;

  Events({
    //required this.eventDate,
    //required this.eventName,
    //required this.groupName,
    this.eventName,
    this.groupID,
    this.eventDate,
    this.groupName,
  });

  // Events.fromMap(Map<String, dynamic> data) {
  // uid = data['UserID'];
  //groupID = data['groupIDs'];
  //}
}
