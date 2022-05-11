import 'package:cloud_firestore/cloud_firestore.dart';

//class to store event information from database
class Events {
  String? eventName;
  int? groupID;
  Timestamp? eventDate;
  String? groupName;

  Events({
    this.eventName,
    this.groupID,
    this.eventDate,
    this.groupName,
  });

  void printDate() {
    print(eventDate.toString());
  }
}
