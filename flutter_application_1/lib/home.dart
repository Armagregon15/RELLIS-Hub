// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'authmain.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('The Hub @ RELLIS'),
        backgroundColor: const Color(0xFF500000),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: const Icon(Icons.person),
            label: const Text('logout'),
            textColor: Colors.white,
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}
