// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/setUp.dart';
import 'calendar.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Container(
          height: 80,
          width: 150,
          decoration: BoxDecoration(
              color: Color(0xFF500000),
              borderRadius: BorderRadius.circular(10)),
          // ignore: deprecated_member_use
          child: FlatButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SetUp()));
            },
            child: Text(
              'Welcome',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }
}
