import 'package:flutter/material.dart';

import 'setUp.dart';

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
