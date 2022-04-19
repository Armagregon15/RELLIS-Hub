class MyUser {
  final String uid;
  //final List<int>? groupIDs;

  MyUser({required this.uid});
}

class UserData {
  final String uid;
  final List<int> groupIDs;

  UserData({
    required this.uid,
    required this.groupIDs,
  });
}

class UserData {
  final String? uid;
  final List<int>? groupIDs;

  UserData({this.uid, this.groupIDs});


  
}
