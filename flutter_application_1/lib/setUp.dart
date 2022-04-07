// ignore: file_names
// ignore_for_file: prefer_const_constructors, avoid_print, file_names, unused_element

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/loginPage.dart';
import 'package:provider/provider.dart';
import 'authentication_service.dart';
import 'firebase_options.dart';

List<int> indexdb = [18];

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

// Schools Form //
class schoolForm extends StatefulWidget {
  const schoolForm({Key? key}) : super(key: key);

  @override
  State<schoolForm> createState() => _schoolFormState();
}

class _schoolFormState extends State<schoolForm> {
  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    bool isSelect = true;
    return Card(
      child:
          _buildItem(title: document['GroupName'], value: document['GroupID']),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Groups')
              .where('GroupType', isEqualTo: 'School')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading");
            } else {
              return ListView.builder(
                itemExtent: 80.0,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) =>
                    _buildList(context, snapshot.data!.docs[index]),
              );
            }
          }),
    );
  }
}

// Clubs Form //
class clubForm extends StatefulWidget {
  const clubForm({Key? key}) : super(key: key);

  @override
  State<clubForm> createState() => _clubFormState();
}

class _clubFormState extends State<clubForm> {
  @override
  bool click = true;

  bool boolCheck = false;

  bool newValue = false;

  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    bool isSelect = true;
    return Card(
      child:
          _buildItem(title: document['GroupName'], value: document['GroupID']),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Groups')
                .where('GroupType', isEqualTo: 'Club')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: Text(
                  "Loading",
                ));
              } else {
                return ListView.builder(
                  itemExtent: 80.0,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) =>
                      _buildList(context, snapshot.data!.docs[index]),
                );
              }
            }),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text("Sign Out"),
          onPressed: () async {
            context.read<AuthenticationService>().signOut();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginHub()));
            // Implementation for saving selection goes here
          },
        ));
  }
}

// Interests Form //
class interestForm extends StatefulWidget {
  const interestForm({Key? key}) : super(key: key);

  @override
  State<interestForm> createState() => _interestFormState();
}

class _interestFormState extends State<interestForm> {
  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    int currentIndex = 0;
    return Card(
      child:
          _buildItem(title: document['GroupName'], value: document['GroupID']),
    );
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Groups')
                //.where(FieldPath.documentId, isEqualTo: "School")
                .where('GroupType', isEqualTo: 'Interest')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("Loading");
              } else {
                return ListView.builder(
                  itemExtent: 80.0,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) =>
                      _buildList(context, snapshot.data!.docs[index]),
                );
              }
            }),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text("Submit"),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          },
        ));
  }
}

// Builds Items //
/*class _buildItem extends StatefulWidget {
  final title;
   final value;
  _buildItem({required this.title, required this.value});

  @override
  __buildItemState createState() => __buildItemState();
}

class __buildItemState extends State<_buildItem> {
  bool selected = false;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: Text(widget.title, style: TextStyle(fontSize: 18.0)),
        value: selected,
        onChanged: (bool? val) {
          setState(() {
            selected = val!;
          });
        });
  }
}
*/

class _buildItem extends StatefulWidget {
  final title;
  final value;
  _buildItem({required this.title, required this.value});

  @override
  __buildItemState createState() => __buildItemState();
}

class __buildItemState extends State<_buildItem> {
  bool selected = true;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          child: Text(widget.title, style: TextStyle(fontSize: 18.0)),
          color: selected ? Colors.white : Color.fromARGB(255, 206, 203, 203)),
      onTap: () {
        setState(() {
          selected = !selected;
          print(widget.value);
          if (selected == false) {
            indexdb.add(widget.value);
          } else
            indexdb.remove(widget.value);
          print(indexdb);
        });
      },
    );
  }
}

// Joe work on this //

class MainPage extends StatefulWidget {
  @override
  List<int> indexFeed = [];

  MainPage();
  HomePage createState() => HomePage();
}

class HomePage extends State<MainPage> {
  int _selectedIndex = 0;

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

/*
  Widget _buildContainer(
      BuildContext context, DocumentSnapshot document, int index) {
    int currentIndex = 0;
    Timestamp t = document['EventDate'];
    DateTime d = t.toDate();

    if (indexdb.contains(index)) {
      // indexdb.remove(i);
      return Container(
          color: Colors.white10,
          height: MediaQuery.of(context).size.height / 4.5,
          child: Center(
            child: Card(
              child: Column(
                children: [
                  Container(
                    height: 190,
                    child: Column(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.menu_book,
                            color: Colors.black,
                          ),
                          alignment: Alignment.topCenter,
                          padding: new EdgeInsets.all(10.0),
                          onPressed: () {},
                        ),
                        Container(
                            padding: const EdgeInsets.all(8),
                            child: Center(child: Text(document['GroupName']))),
                        Container(
                            padding: const EdgeInsets.all(8),
                            child: Center(child: Text(document['EventName']))),
                        Container(
                            padding: const EdgeInsets.all(8),
                            child: Center(child: Text(d.toString()))),
                      ],
                    ),
                  ),
                ],
              ),
              elevation: 6,
            ),
          ));
    }
    return Container(height: .001);
  }
*/
  Widget _bigBooty(BuildContext context, DocumentSnapshot document) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Events')
              .where('GroupType', isEqualTo: 'Interest')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading");
            } else {
              return ListView.builder(
                itemExtent: 80.0,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) =>
                    _buildList(context, snapshot.data!.docs[index]),
              );
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The HUB at RELLIS Home',
        home: Scaffold(
            body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:
                    FirebaseFirestore.instance.collection('Users').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading");
                  } else {
                    return ListView(
                      children: snapshot.data!.docs.map((document) {
                        return Text(document['GroupIDs'].toString());
                      }).toList(),
                    );
                  }
                }),
            bottomNavigationBar: BottomNavigationBar(
              selectedFontSize: 15,
              // ignore: prefer_const_constructors
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              // ignore: prefer_const_constructors
              selectedIconTheme: IconThemeData(
                color: Colors.white,
                size: 35,
              ),
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.white,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              backgroundColor: const Color(0xFF500000),
              elevation: 90,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: 'Profile',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  label: 'Refresh',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.event,
                    color: Colors.white,
                  ),
                  label: 'Calendar',
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              label: const Text("Submit"),
              onPressed: () {
                // Implementation for saving selection goes here
              },
            )));
  }
}
