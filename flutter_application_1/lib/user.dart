class MyUser {
  final String uid;
  MyUser({required this.uid});
}

class UserData {
  final String? uid;
  final List<int>? groupIDs;

  UserData({this.uid, this.groupIDs});
}
