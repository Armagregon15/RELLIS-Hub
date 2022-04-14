// ignore_for_file: deprecated_member_use

//import 'package:flutter_application_1/user.dart';

import 'package:flutter_application_1/setUp.dart';
import 'package:stream_feed/stream_feed.dart';

import 'authenticate.dart';
import 'authmain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database_service.dart';
import 'event_list.dart';
//import 'event_tile.dart';
import 'events.dart';
import 'settings.dart';
import 'user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              //child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Events>>.value(
      value: DatabaseService(uid: '').users,
      //initialData: [],
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('The Hub @ RELLIS'),
          backgroundColor: const Color(0xFF500000),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              textColor: Colors.white,
              onPressed: () async {
                await _auth.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Authenticate()));
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              textColor: Colors.white,
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: EventList(),
      ),
    );
  }
}
