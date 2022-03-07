// ignore: file_names
// ignore_for_file: prefer_const_constructors, avoid_print, file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import './result.dart';
import 'firebase_options.dart';

class formStart extends StatefulWidget {
  @override
  State<formStart> createState() => _formStartState();
}

class _formStartState extends State<formStart> {
  @override
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // List of Widgets index //
  static const List<Widget> _widgetOptions = <Widget>[
    schoolForm(),
    clubForm(),
    interestForm(),
  ];

  // Variables for Checkboxes //
  bool click = true;
  bool boolCheck = false;
  bool newValue = false;

// Parent Page //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF500000),
        title: const Text('The Hub @ Rellis'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 15,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedIconTheme: IconThemeData(
          color: Colors.white,
          size: 35,
        ),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        backgroundColor: const Color(0xFF500000),
        elevation: 90,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.school,
              color: Colors.white,
            ),
            label: 'Schools',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: 'Clubs',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            label: 'Interests',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Schools Form //
class schoolForm extends StatefulWidget {
  const schoolForm({Key? key}) : super(key: key);

  @override
  State<schoolForm> createState() => _schoolFormState();
}

class _schoolFormState extends State<schoolForm> {
  bool click = true;
  bool boolCheck = false;
  bool newValue = false;

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return Card(
      child: CheckboxListTile(
        title: Text(document['GroupName'], style: TextStyle(fontSize: 18.0)),
        value: boolCheck,
        onChanged: (bool? newValue) {
          setState(() {
            boolCheck = !boolCheck;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Groups').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading");
            } else {
              return ListView.builder(
                itemExtent: 80.0,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) =>
                    _buildListItem(context, snapshot.data!.docs[index]),
              );
            }
          }),
    );
  }
}

// Clubs Form //
class clubForm extends StatelessWidget {
  const clubForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 221, 165, 139),
      child: Center(
        child: Text(
          "Clubs",
          style: TextStyle(
            color: Color.fromARGB(255, 253, 253, 253),
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// Interests Form //
class interestForm extends StatelessWidget {
  const interestForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 162, 132, 230),
      child: Column(
        children: [
          Center(
            child: Text(
              "Interests",
              style: TextStyle(
                color: Color.fromARGB(255, 253, 253, 253),
                fontSize: 45,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.circle,
              color: Colors.black,
            ),
            tooltip: 'Submit',
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            },
          ),
        ],
      ),
    );
  }
}
