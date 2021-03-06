// ignore: file_names
// ignore_for_file: prefer_const_constructors, avoid_print, file_names, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_application_1/authenticate.dart';
import 'package:flutter_application_1/authmain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'database_service.dart';
import 'loading.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'admin_calendar.dart';
import 'calendar.dart';
import 'package:intl/intl.dart';
import 'authenticate.dart';
import 'authmain.dart';

// Declaration of some constants //

// Default Color //
Color maroon = const Color(0xFF500000);

// List used for saving user selection of groups //
List<int> indexdb = [18];
final AuthService _auth = AuthService();
DatabaseService _dbs = DatabaseService(uid: '123');
bool loading = false;

// Creates stateful widget //
class formStart extends StatefulWidget {
  @override
  State<formStart> createState() => _formStartState();
}

class _formStartState extends State<formStart> {
  @override
  int _selectedIndex = 0;

// Keeps track of index used to navigate with bottom nav //
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
              backgroundColor: maroon,
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
              backgroundColor: maroon,
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
              backgroundColor: maroon,
              onPressed: () async {
                try {
                  loading ? Loading() : _dbs.updateUserData(indexdb);
                } catch (error) {
                  loading ? Loading() : print(error.toString());

                  return null;
                }
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
          backgroundColor: maroon,
          onPressed: () async {
            try {
              loading ? Loading() : _dbs.updateUserData(indexdb);
            } catch (error) {
              loading ? Loading() : print(error.toString());
              return null;
            }
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
          backgroundColor: maroon,
          onPressed: () async {
            try {
              loading ? Loading() : _dbs.updateUserData(indexdb);
            } catch (error) {
              loading ? Loading() : print(error.toString());

              return null;
            }
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
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          child: Text(widget.title, style: TextStyle(fontSize: 18.0)),
          color: selected ? Colors.white : Color.fromARGB(255, 206, 203, 203)),
      onTap: () {
        setState(() {
          selected = !selected;
          if (selected == false) {
            if (!indexdb.contains(widget.value) && indexdb.length < 10) {
              indexdb.add(widget.value);
            }
          } else if (indexdb.contains(widget.value)) {
            indexdb.remove(widget.value);
          } else {
            print('cannot select more than 10 options');
          }
        });
      },
    );
  }
}

//there is already a loading page
class LoadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _dbs.checkIfAdmin();
    _dbs.getIndexDB().then((value) {
      indexdb = _dbs.getTheList(value);
    });
    Timer(Duration(seconds: 1), () {
      if (indexdb.length == 1) {
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
  bool isPressed = false;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  static List? userEvents = [];

  _onItemTapped(int index) async {
    _dbs.checkIfAdmin();
    _selectedIndex = index;
    if (_selectedIndex == 0) {
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
    return loading ? Loading() : setState(() {});
  }

  // Builds container for each event displayed //

  Widget _buildHomeItem(BuildContext context, DocumentSnapshot document) {
    Timestamp t = document['EventDate'];
    Timestamp from = document['EventDate'];
    Timestamp to = document['to'];
    String docID = document.id;
    DateTime d = t.toDate();
    DateTime firstHere = from.toDate();
    DateTime here = to.toDate();
    String formattedDate = DateFormat("yyyy-MM-dd").format(d);
    String formattedFrom = DateFormat("h:mm a").format(firstHere);
    String formattedTo = DateFormat("h:mm a").format(here);
    int likedValue = document["Interest"];

    // Function that creates popup for extra info //
    infoPage() {
      return AlertDialog(
        title: Text(document["EventName"]),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text("Group's Name: " + document["GroupName"] + "\n"),
              Text("Event Date: " + formattedDate + "\n"),
              Text("Event Time: " + formattedFrom + " - " + formattedTo + "\n"),
              Text("Event Location: " + document["Location"] + "\n"),
              Text("Contact Organizer: " + document["Organizer"] + "\n"),
            ],
          ),
        ),
      );
    }

    // Builds the items on homepage creates a containers, centers them, creates a card in that container //
    // Than puts a column in each card that you can fill with text widgets //
    return loading
        ? Loading()
        : Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
                backgroundBlendMode: BlendMode.srcOver,
                border: Border.all(
                    color: Color.fromARGB(255, 180, 179, 175),
                    width: 10,
                    style: BorderStyle.solid)),
            child: Center(
              child: Card(
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(15),
                        child: Center(
                            child: Text(
                          document['GroupName'],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ))),
                    Container(
                        padding: EdgeInsets.all(20),
                        child: Center(child: Text(document['EventName']))),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Center(
                            child: Text(formattedDate +
                                "  " +
                                formattedFrom +
                                " - " +
                                formattedTo))),
                    Row(
                      // Extra info button that calls function infopage //
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) => infoPage(),
                              ),
                              icon: Icon(Icons.info),
                              color: maroon,
                            ),
                          ],
                        ),
                        Row(
                          // Attempt at a like button, not yet working fully //
                          children: [
                            IconButton(
                              padding: EdgeInsets.all(.1),
                              onPressed: null, //isPressed == true
                              // : () {
                              //     setState(() {
                              //       // likedValue += 1;
                              //       // FirebaseFirestore.instance
                              //       //     .collection("Events")
                              //       //     .doc(docID)
                              //       //     .update({'Interest': likedValue});
                              //       isPressed = !isPressed;
                              //     });
                              //   },
                              icon: Icon(Icons.favorite),
                              color: maroon,
                            ),
                            Text(document["Interest"].toString())
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                elevation: 6,
              ),
            ),
          );
  }

  // This builds the homepage //
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2));
    Timer(Duration(seconds: 1), () {});

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The HUB at RELLIS Home',
        home: Scaffold(
            appBar: AppBar(
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
              backgroundColor: maroon,
            ),
            // Starts creation of Streambuilder //
            body: StreamBuilder<QuerySnapshot>(
                // Querys database for information that will be used in streambuidler from database //
                stream: FirebaseFirestore.instance
                    .collection('Events')
                    .orderBy('EventDate', descending: false)
                    .snapshots(),
                // Builder for the steambuilder, builds the items that will be displayed //
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading");
                  } else {
                    // Using listview to display the contents //
                    return ListView.builder(
                      // How big the items can be //
                      itemExtent: 250,
                      // How many items there will be //
                      itemCount: snapshot.data?.docs.length,
                      // Method that will be used to build items //
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
              backgroundColor: maroon,
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
              label: const Text("Sign Out"),
              backgroundColor: maroon,
              onPressed: () async {
                await _auth.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Authenticate()));
              },
            )));
  }
}
