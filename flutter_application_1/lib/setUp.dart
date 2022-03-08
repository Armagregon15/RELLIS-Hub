// ignore_for_file: prefer_const_constructors, avoid_print, file_names
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './result.dart';

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
    return Card(
      child: _buildItem(title: document['GroupName']),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Groups')
                //.where(FieldPath.documentId, isEqualTo: "School")
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
        floatingActionButton: FloatingActionButton.extended(
          label: const Text("Save"),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          },
        ));
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
  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return Card(
      child: _buildItem(title: document['GroupName']),
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
            label: const Text("Save"),
            onPressed: () {
              // Implementation for saving selection goes here
            }));
  }
}

// Interests Form //
class interestForm extends StatefulWidget {
  const interestForm({Key? key}) : super(key: key);

  @override
  State<interestForm> createState() => _interestFormState();
}

class _interestFormState extends State<interestForm> {
  bool _boolCheck = false;
  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return Card(
      child: _buildItem(title: document['GroupName']),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Groups')
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
            // Implementation for saving selection goes here
          },
        ));
  }
}

// Builds Items //
class _buildItem extends StatefulWidget {
  final title;

  _buildItem({required this.title});

  @override
  __buildItemState createState() => __buildItemState();
}

class __buildItemState extends State<_buildItem> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        //key: ValueKey(record.name),
        title: Text(widget.title, style: TextStyle(fontSize: 18.0)),
        value: selected,
        onChanged: (bool? val) {
          setState(() {
            selected = val!;
          });
        });
  }
}

/*
class Record {
    final String refGroupName;
    final DocumentReference refGroupID;

    Record(this.refGroupName, this.refGroupID);

    Record.fromMap(Map<String, dynamic> map, {required this.refGroupID})
      : assert(map['GroupName'] != null),
        refGroupName = map['GroupName'];

   Record.fromCollection(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

    @override
    String toString() => "Record<$refGroupName:>";
    }
    */