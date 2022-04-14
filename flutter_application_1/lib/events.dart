class Events {
  late final String uid;
  //final String eventDate;
  //final String eventName;
  //final String groupName;
  late final List<int> groupID;
  Events(
      { //required this.eventDate,
      //required this.eventName,
      //required this.groupName,
      required this.uid,
      required this.groupID});

  // Events.fromMap(Map<String, dynamic> data) {
  // uid = data['UserID'];
  //groupID = data['groupIDs'];
  //}
}
