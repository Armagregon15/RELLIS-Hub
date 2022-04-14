// ignore: file_names
// ignore_for_file: prefer_const_constructors, avoid_print, file_names, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_application_1/authenticate.dart';
import 'package:flutter_application_1/authmain.dart';
import 'calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

List<int> indexdb = [18];
final AuthService _auth = AuthService();
DatabaseService _dbs = DatabaseService(uid: '');

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
    );
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
          backgroundColor: const Color(0xFF500000),
          onPressed: () async {
            try {
              var uid = await _auth.getUID();
              //MyUser _auth.user.uid;
              indexdb = _dbs.getTheList();
              print('to user ->');
              print(indexdb);

              DatabaseService(uid: uid).updateUserData(indexdb);
              //DatabaseService(uid: uid).getIndexDB();

              print('new test');
              print(indexdb);
              print('new test');
            } catch (error) {
              print(error.toString());
              return null;
            }
            //print(_dbs.getTheList());
            //indexdb = _dbs.getTheList();
            //print('new test');
            //print(indexdb);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          },
        ));
  }
}

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
  //indexdb = [18];
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
          String stuff = _dbs.getIndexDB().toString();
          //print(stuff);
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

// ignore: must_be_immutable
class MainPage extends StatefulWidget {
  @override
  List<int> indexFeed = [];

  MainPage();
  HomePage createState() => HomePage();
}

class HomePage extends State<MainPage> {
  int _selectedIndex = 0;

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  static List? userEvents = [];
  _onItemTapped(int index) {
    indexdb = [18];
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => formStart()));
    setState(() {
      Calendar();
      _selectedIndex = index;
    });
  }

  // Builds container for each event displayed //
  Widget _buildHomeItem(BuildContext context, DocumentSnapshot document) {
    Timestamp t = document['EventDate'];
    DateTime d = t.toDate();

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

  @override
  Widget build(BuildContext context) {
    _dbs.getIndexDB();
    indexdb = _dbs.getTheList();

    print('first time');
    print(indexdb);
    

    //print(newIndex);
    //User user = Provider.of<User>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The HUB at RELLIS Home',
        home: Scaffold(
            body: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Events')
                    .where('GroupID', whereIn: indexdb)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading");
                  } else {
                    return ListView.builder(
                      itemExtent: MediaQuery.of(context).size.height / 3.5,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) =>
                          _buildHomeItem(context, snapshot.data!.docs[index]),
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
                    //onPressed: formStart(),
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
              label: const Text("Sign Out"),
              backgroundColor: const Color(0xFF500000),
              onPressed: () async {
                await _auth.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Authenticate()));
                // Implementation for saving selection goes here
              },
            )));
  }

  // String uid = FirebaseAuth.instance.currentUser!.uid;
  //print(DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).getIndexDB());
  //var uid = await _auth.getUID();
  //Future future = DatabaseService(uid: uid).getIndexDB();

  //List<int> newIndex = DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).getIndexDB() as List<int>;
  //List<int> newIndex = DatabaseService(uid: '').getIndexDB() as List<int>;
  //  List newIndex = await FirebaseFirestore.instance
  //      .doc(FirebaseAuth.instance.currentUser!.uid)
  //      .get('EventIDs');

  // Future getIndexDB(DocumentSnapshot document) async {
  //   FirebaseFirestore.instance.collection('Users').doc(uid).get();
  //   newIndex = document['GroupIDs'];
  //}
}
