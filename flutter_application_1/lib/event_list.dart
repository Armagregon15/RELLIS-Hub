//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/event_tile.dart';
import 'package:flutter_application_1/setUp.dart';
//import 'home.dart';
import 'event_tile.dart';
import 'package:provider/provider.dart';
import 'events.dart';
import 'setUp.dart';
import 'user.dart';

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    //final events = Provider.of<List<Events>>(context);
    final users = Provider.of<List<Events>>(context);

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        return EventTile(event: users[index]);
      },
    );
  }
}
