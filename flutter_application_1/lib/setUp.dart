// ignore: file_names
// ignore_for_file: prefer_const_constructors, avoid_print, file_names, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_application_1/authenticate.dart';
import 'package:flutter_application_1/authmain.dart';
import 'calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'loading.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'admin_calendar.dart';

List<int> indexdb = [18];
final AuthService _auth = AuthService();
DatabaseService _dbs = DatabaseService(uid: '123');
bool loading = false;

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
    return loading
        ? Loading()
        : Scaffold(
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
    return loading
        ? Loading()
        : Card(
            child: _buildItem(
                title: document['GroupName'], value: document['GroupID']),
          );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Groups')
                    .where('GroupType', isEqualTo: 'School')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading");
                  } else {
                    return loading
                        ? Loading()
                        : ListView.builder(
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
                  //var uid = await _auth.getUID();
                  //MyUser _auth.user.uid;
                  // indexdb = _dbs.getTheList();
                  // print('to user ->');
                  // print(indexdb);
                  loading ? Loading() : _dbs.updateUserData(indexdb);
                  //DatabaseService(uid: uid).getIndexDB();

                  print('new test');
                  print(indexdb);
                  print('new test');
                } catch (error) {
                  loading ? Loading() : print(error.toString());

                  return null;
                }
                //print(_dbs.getTheList());
                //indexdb = _dbs.getTheList();
                //print('new test');
                //print(indexdb);
                loading
                    ? Loading()
                    : Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainPage()));
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
  bool click = true;
  bool boolCheck = false;
  bool newValue = false;

  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    bool isSelect = true;
    return loading
        ? Loading()
        : Card(
            child: _buildItem(
                title: document['GroupName'], value: document['GroupID']),
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
                return loading
                    ? Loading()
                    : Center(
                        child: Text(
                        "Loading",
                      ));
              } else {
                return loading
                    ? Loading()
                    : ListView.builder(
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
              //var uid = await _auth.getUID();
              //MyUser _auth.user.uid;
              // indexdb = _dbs.getTheList();
              // print('to user ->');
              // print(indexdb);
              loading ? Loading() : _dbs.updateUserData(indexdb);
              //DatabaseService(uid: uid).getIndexDB();

              print('new test');
              print(indexdb);
              print('new test');
            } catch (error) {
              loading ? Loading() : print(error.toString());

              return null;
            }
            //print(_dbs.getTheList());
            //indexdb = _dbs.getTheList();
            //print('new test');
            //print(indexdb);
            loading
                ? Loading()
                : Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage()));
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
              //var uid = await _auth.getUID();
              //MyUser _auth.user.uid;
              // indexdb = _dbs.getTheList();
              // print('to user ->');
              // print(indexdb);
              loading ? Loading() : _dbs.updateUserData(indexdb);
              //DatabaseService(uid: uid).getIndexDB();

              print('new test');
              print(indexdb);
              print('new test');
            } catch (error) {
              loading ? Loading() : print(error.toString());

              return null;
            }
            //print(_dbs.getTheList());
            //indexdb = _dbs.getTheList();
            //print('new test');
            //print(indexdb);
            loading
                ? Loading()
                : Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage()));
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
  List<int> tempIndex = [18];
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
          //String stuff = _dbs.getIndexDB().toString();
          //print(stuff);
          if (selected == false) {
            if (!indexdb.contains(widget.value) && indexdb.length < 10) {
              indexdb.add(widget.value);
            }
          } else if (indexdb.contains(widget.value)) {
            indexdb.remove(widget.value);
            print(indexdb);
          } else {
            print('cannot select more than 10 options');
          }
        });
      },
    );
  }
}

// Joe work on this //
//there is already a loading page
class LoadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _dbs.checkIfAdmin();
    _dbs.getIndexDB().then((value) {
      // Future.delayed(
      // const Duration(seconds: 2));

      indexdb = _dbs.getTheList(value);
      print('first time');
      print(indexdb);
      print('am i the admin');
      
      if (_dbs.getIsAdmin()) {
        print('yeah, you the boss');
      } else {
        print('nope, you are a chump');
      }
    });
    Timer(Duration(seconds: 1), () {
      if (indexdb.length == 1) {
        print('after timer');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => formStart()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      }
    });
    return Container(
      color: Colors.white,
      child: const Center(
        child: SpinKitChasingDots(
          color: Color(0xFF500000),
          size: 50.0,
        ),
      ),
    );
  }
}

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

  _onItemTapped(int index) async {
    _dbs.checkIfAdmin();
    //indexdb = [18];
    _selectedIndex = index;
    print(_selectedIndex);
    print(index);
    if (_selectedIndex == 0) {
      print('I went there');
      indexdb = [18];
      await _dbs.updateUserData(indexdb);
      _dbs.setTheList(indexdb);
      return loading
          ? Loading()
          : Navigator.push(
              context, MaterialPageRoute(builder: (context) => formStart()));
    }
    if (_selectedIndex == 1) {
      return loading
          ? Loading()
          : Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainPage()));
    }

    if (_selectedIndex == 2 && _dbs.getIsAdmin()) {
      return loading
          ? Loading()
          : Navigator.push(context,
              MaterialPageRoute(builder: (context) => AdminCalendar()));
    }
    if (_selectedIndex == 2) {
      return loading
          ? Loading()
          : Navigator.push(
              context, MaterialPageRoute(builder: (context) => Calendar()));
    }
    return loading
        ? Loading()
        : setState(() {
            //Calendar();
          });
  }

  // Builds container for each event displayed //
  Widget _buildHomeItem(BuildContext context, DocumentSnapshot document) {
    Timestamp t = document['EventDate'];
    DateTime d = t.toDate();

    return loading
        ? Loading()
        : Container(
            //color: Colors.white10,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
                backgroundBlendMode: BlendMode.srcOver,
                border: Border.all(
                    color: Color.fromARGB(255, 180, 179, 175),
                    width: 10,
                    style: BorderStyle.solid)),
            height: MediaQuery.of(context).size.height / 4.5,
            child: Center(
              child: Card(
                child: Column(
                  children: [
                    SizedBox(
                      height: 190,
                      child: Column(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                  child: Text(
                                document['GroupName'],
                                style: TextStyle(fontSize: 20),
                              ))),
                          Container(
                              padding: const EdgeInsets.all(8),
                              child:
                                  Center(child: Text(document['EventName']))),
                          Container(
                              padding: const EdgeInsets.all(8),
                              child: Center(child: Text(d.toString()))),
                          IconButton(
                            color: Color.fromARGB(255, 234, 195, 18),
                            icon: const Icon(
                              Icons.menu_book,
                              color: Color.fromARGB(255, 255, 174, 1),
                            ),
                            alignment: Alignment.bottomCenter,
                            padding: new EdgeInsets.all(10.0),
                            onPressed: () {},
                          ),
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
    //return loading ? Loading() :
    _dbs.checkIfAdmin();
    //Navigator.push(
    //  context, MaterialPageRoute(builder:(context) => Loading()));

    // _dbs.getIndexDB();
    // indexdb = _dbs.getTheList();
    // print('first time');
    // print(indexdb);

    _dbs.getIndexDB().then((value) {
      // Future.delayed(
      // const Duration(seconds: 2));

      indexdb = _dbs.getTheList(value);
      print('first time');
      print(indexdb);
    });
    Future.delayed(const Duration(seconds: 2));
    print('after delay');
    Timer(Duration(seconds: 1), () {
      print('after timer');
    });
    // if (indexdb.length == 1) {
    //   print('the index is 18');
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => MainPage()));
    // }
    // int semaphore = _dbs.getSemaphore();
    // if (semaphore == 1) {
    //   Navigator.push(
    //        context, MaterialPageRoute(builder: (context) => MainPage()));
    // }
    // _dbs.getHomeList(context);
    // print('second time');
    // print(indexdb);
    //print(newIndex);
    //User user = Provider.of<User>(context);
    if (_dbs.getIsAdmin()) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'The HUB at RELLIS Home',
          home: Scaffold(
              appBar: AppBar(
                // ignore: prefer_const_constructors
                title: InkWell(
                    onTap: () {
                      //"The Hub @ RELLIS",
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  loading ? Loading() : MainPage()));
                    },
                    child: Text(
                      "The Hub @ RELLIS",
                      style: TextStyle(fontFamily: "Roboto", fontSize: 30),
                    )),
                backgroundColor: const Color(0xFF500000),
              ),
              body: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Events')
                      //.where('GroupID', whereIn: indexdb)
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
      //}); return MainPage();
    } else {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'The HUB at RELLIS Home',
          home: Scaffold(
              appBar: AppBar(
                // ignore: prefer_const_constructors
                title: InkWell(
                    onTap: () {
                      //"The Hub @ RELLIS",
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  loading ? Loading() : MainPage()));
                    },
                    child: Text(
                      "The Hub @ RELLIS",
                      style: TextStyle(fontFamily: "Roboto", fontSize: 30),
                    )),
                backgroundColor: const Color(0xFF500000),
              ),
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
