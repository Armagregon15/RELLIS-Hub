import 'package:flutter/material.dart';
import 'package:flutter_application_1/setUp.dart';
import 'package:flutter_application_1/user.dart';
//import 'package:flutter_application_1/user.dart';
import 'events.dart';
//import 'user.dart';
//import 'database_service.dart';

class EventTile extends StatelessWidget {
  //final Events event;
  final Events event;
  //final UserData user;
  // ignore: use_key_in_widget_constructors
  const EventTile({required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.red,
            //backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(event.groupID.toString()),
          textColor: Colors.black,
          subtitle: Text(event.groupID.toString()),
        ),
      ),
    );
  }
}
