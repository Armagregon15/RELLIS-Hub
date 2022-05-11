//class definition for MyUser, used to store uid
class MyUser {
  final String uid;
  MyUser({required this.uid});
}
//class definition for UserData, used to store uid and groupIDs
class UserData {
  final String? uid;
  final List<int>? groupIDs;

  UserData({this.uid, this.groupIDs});
}
