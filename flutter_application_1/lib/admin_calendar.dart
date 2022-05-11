import 'dart:math';
import 'package:flutter/scheduler.dart';
import 'authmain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/setUp.dart';
import 'database_service.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'loading.dart';

DatabaseService _dbs = DatabaseService(uid: '');
final AuthService _auth = AuthService();

//go back until list<color> is final
// ignore: use_key_in_widget_constructors
class AdminCalendar extends StatefulWidget {
  @override
  AdminCalendarState createState() => AdminCalendarState();
}

class AdminCalendarState extends State<AdminCalendar> {
  // Declaration of all variables used throughout AdminCalendarState Class //
  final List<Color> _colorCollection = <Color>[];
  final fireStoreReference = FirebaseFirestore.instance;
  MeetingDataSource? events;
  final List<String> options = <String>['Add', 'Delete'];
  bool isInitialLoaded = false;
  String error = " ";

  // Used for bottomnavbar //
  int _selectedIndex = 0;

  // These variables are used when interacting with database both delete and add //
  String date = "";
  String toDate = "";
  String fromDate = "";
  String eventName = "";
  int? groupID = 0;
  String? docID = "";
  String groupName = "";
  String location = "";
  String organizer = "";

  // Creates a refrence object of a collection in database //
  CollectionReference oEvents = FirebaseFirestore.instance.collection('Events');

  // This is a function that adds a user to the database //
  Future? addUser(String date, String eventName, int? groupID, String toDate,
      String fromDate) {
    // This map needs to be taken out. At the moment it is how events are given a group name when adding a new event to the Events collection. //
    // It needs to be replaced by placing some kind of refrence at line 154 to the documents name //
    // This is a key value pair table that is a temporary fix to link the name of the group to the the groupID //
    Map<int, String> groups = {
      0: "Sports",
      1: "TAMUC",
      2: "Hiking",
      3: "Movies",
      4: "TAMUCT",
      5: "TAMUSA",
      6: "STUCO",
      7: "RELLIS Rangers",
      8: "SFA",
      9: "STACC",
      10: "TAMUT",
      11: "TAMUK",
      12: "TSU",
      13: "WTAMU",
      14: "Technology",
      15: "TAMUCC",
      16: "TAMIU",
      17: "PVAMU",
      18: "RELLIS"
    };

    // Parsing date //
    toDate = date + " " + toDate; // + ":00";
    fromDate = date + " " + fromDate; // + "00";

    try {
      DateTime toDates = DateFormat("yyyy-MM-dd h:mm a").parseStrict(toDate);
      DateTime fromDates =
          DateFormat("yyyy-MM-dd h:mm a").parseStrict(fromDate);
      Timestamp fromTimeStamp = Timestamp.fromDate(fromDates);
      Timestamp toTimeStamp = Timestamp.fromDate(toDates);
      // This is where the magic happens, the app takes the user input and assigns it to local variables which are then passed to the collection and creates a document //
      return fireStoreReference
          .collection("Events")
          .doc()
          .set({
            'EventDate': fromTimeStamp,
            "to": toTimeStamp,
            'Location': location,
            'Organizer': organizer,
            'Interest': 0,
            'EventName': eventName,
            'GroupID': groupID,
            'GroupName': groups[groupID]
          })
          .then((value) => print("Event Added"))
          .catchError((error) => print("Failed to add event: $error"));
    } catch (e) {
      Text(
        error,
        style: const TextStyle(color: Colors.red, fontSize: 14.0),
      );
      return null;
    }
  }

  // This function deletes the user by docID //
  Future delUser(String eventName, int? groupID) {
    return fireStoreReference
        .collection("Events")
        .doc(docID)
        .delete()
        .then((value) => print("Event Deleted"))
        .catchError((error) => print("Failed to add event: $error"));
  }

  Future<void> getDataFromFireStore() async {
    await _dbs.getIndexDB().then((value) {
      List<int> indexdb = _dbs.getTheList(value);
    });
    var snapShotsValue = await fireStoreReference.collection("Events").get();
    final Random random = Random();
    List<Events> list = snapShotsValue.docs
        .map((e) => Events(
              eventName: e.data()['EventName'],
              from: e.data()['EventDate'].toDate(),
              to: e.data()['to'].toDate(),
              eventDate: e.data()['EventDate'],
              background: _colorCollection[random.nextInt(9)],
              isAllDay: false,
              groupID: e.data()['GroupID'],
              groupName: e.data()['GroupName'],
              location: e.data()['Location'],
              organizer: e.data()['Organizer'],
            ))
        .toList();
    setState(() {
      events = MeetingDataSource(list);
    });
  }

  // This is the form that pops up after pressing the "Add Event" button //
  Widget _buildPopupDialogAdd(BuildContext context) {
    final addForm = GlobalKey<FormState>();
    // This variable is being used. I have no idea why it thinks it's not //
    int? newValue = 0;
    return AlertDialog(
      title: const Text('Add Event'),
      // Creates a form which has a key that gives it an identifier //
      content: Form(
        key: addForm,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // One of the fields that takes user input and assigns it to local var //
            TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Missing event name";
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() => eventName = val);
                },
                decoration: const InputDecoration(
                  hintText: 'Enter the event name...',
                  labelText: 'Event Name',
                )),
            // One of the fields that takes user input and assigns it to local var //
            TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Missing organizer email";
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() => organizer = val);
                },
                decoration: const InputDecoration(
                  hintText: 'Enter the organizer email...',
                  labelText: 'Organizer Email',
                )),
            // One of the fields that takes user input and assigns it to local var //
            TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Missing location";
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() => location = val);
                },
                decoration: const InputDecoration(
                  hintText: 'Enter the location...',
                  labelText: 'Event Location',
                )),
            // One of the fields that takes user input and assigns it to local var //
            TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Missing date";
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() => date = val);
                },
                decoration: const InputDecoration(
                  hintText: 'yyyy-mm-dd',
                  labelText: 'Date (yyyy-mm-dd)',
                )),
            // One of the fields that takes user input and assigns it to local var //
            TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Missing start time";
                  }
                },
                onChanged: (val) {
                  setState(() => fromDate = val);
                },
                decoration: const InputDecoration(
                  hintText: 'h:mm AM',
                  labelText: 'From (h:mm) (AM/PM)',
                )),
            // One of the fields that takes user input and assigns it to local var //
            TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Missing end time";
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() => toDate = val);
                },
                decoration: const InputDecoration(
                  hintText: 'h:mm PM',
                  labelText: 'To (h:mm) (AM/PM)',
                )),
            // This is a streambuilder that querys the database for all documents in the groups collection //
            // It then takes those ducments and populates a drop down menu with them so the user can choose what group the event belongs to //
            // For detailed info on how streambuilder works see setup.dart //
            StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Groups').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return DropdownButtonFormField<int>(
                    validator: (value) => value == null ? 'No Entry' : null,
                    onSaved: (newValue) => groupID,
                    onChanged: (value) {
                      setState(() {
                        groupID = value;
                        newValue = value;
                      });
                    },
                    items: snapshot.data?.docs.map((DocumentSnapshot document) {
                      return DropdownMenuItem<int>(
                          value: document["GroupID"],
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0)),
                            height: 50.0,
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
                            child: Text(document['GroupName']),
                          ));
                    }).toList(),
                  );
                }),
            Padding(
              // button that submits the field once filled using a validator to make sure the right info is entered //
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: const Color(0xFF500000)),
                onPressed: () {
                  if (addForm.currentState!.validate()) {
                    var results =
                        addUser(date, eventName, groupID, toDate, fromDate);

                    if (results == null) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => submitError(),
                      );
                    } else {
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        // Button that closes add / delete menu //
        TextButton(
          style: TextButton.styleFrom(
            primary: const Color(0xFF500000), // This is a custom color variable
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  // This function deletes events //
  // There is a bug with this feature where for a second there are two items in the drop down with the same unqiue identfier causing an error but quickly dissappears //
  // Blink and you miss it sort of thing //
  Widget _buildPopupDialogDelete(BuildContext context) {
    final delForm = GlobalKey<FormState>();
    String? newValue = "";
    return AlertDialog(
      title: const Text('Delete Event'),
      // Creates form so the app can take user submission //
      content: Form(
        // unique identifier //
        key: delForm,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // There are no text fields because all they need to do is choose and event and then press submit to confirm deletion //
            // For detailed info on how streambuilder works see setup.dart //
            StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Events').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return DropdownButtonFormField<String>(
                    validator: (value) => value == null ? 'No Entry' : null,
                    onSaved: (newValue) => docID,
                    onChanged: (value) {
                      setState(() {
                        docID = value;
                        newValue = value;
                      });
                    },
                    items: snapshot.data?.docs.map((DocumentSnapshot document) {
                      String gn = document['GroupName'];
                      String en = document['EventName'];
                      return DropdownMenuItem<String>(
                          value: document.id,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0)),
                            height: 50.0,
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
                            child: Text(gn + " - " + en),
                          ));
                    }).toList(),
                  );
                }),
            Padding(
              // Button for deletion confirmation //
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: const Color(0xFF500000)),
                onPressed: () {
                  if (delForm.currentState!.validate()) {
                    delUser(eventName, groupID);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        // Button for closing //
        TextButton(
          style: TextButton.styleFrom(
            primary: const Color(0xFF500000), // This is a custom color variable
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  // This is a function that pushes an error on the screen if all the fields are messed up in the add form //
  submitError() {
    return AlertDialog(
      title: const Text('Submission Error'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('Please make sure all fields are filled'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Okay'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

// Widget that builds the calendar itself //
  @override
  Widget build(BuildContext context) {
    _onItemTapped(int index) async {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        return loading
            ? Loading()
            : Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainPage()));
      }
      if (_selectedIndex == 1) {
        return loading
            ? Loading()
            : Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdminCalendar()));
      }
    }

    isInitialLoaded = true;
    return Scaffold(
      appBar: AppBar(
          title: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            loading ? Loading() : MainPage()));
              },
              child: const Text(
                "The Hub @ RELLIS",
                style: TextStyle(fontFamily: "Roboto", fontSize: 30),
              )),
          backgroundColor: const Color(0xFF500000),
          leading: PopupMenuButton<String>(
            icon: Icon(Icons.add),
            itemBuilder: (BuildContext context) => options.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList(),
            onSelected: (String value) {
              if (value == 'Add') {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      _buildPopupDialogAdd(context),
                );
              } else if (value == "Delete") {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      _buildPopupDialogDelete(context),
                );
              }
            },
          )),
      body: SfCalendar(
        view: CalendarView.month,
        todayHighlightColor: const Color(0xFF500000),
        showDatePickerButton: true,
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            showAgenda: true,
            agendaStyle: AgendaStyle(
                backgroundColor: Color(0xFF500000),
                dateTextStyle: TextStyle(color: Colors.white),
                dayTextStyle: TextStyle(color: Colors.white))),
        dataSource: events,
      ),
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
              Icons.arrow_back,
              color: Colors.white,
            ),
            label: 'Back',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            label: 'Refresh',
          ),
        ],
      ),
    );
  }

  void _initializeEventColor() {
    // ignore: deprecated_member_use
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }

  @override
  void initState() {
    _dbs.getIndexDB().then((value) {});
    _initializeEventColor();
    getDataFromFireStore().then((results) {
      SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    fireStoreReference
        .collection("Events")
        .where("GroupID", whereIn: indexdb)
        .snapshots()
        .listen((event) {
      for (var element in event.docChanges) {
        if (element.type == DocumentChangeType.added) {
          if (!isInitialLoaded) {
            return;
          }
          final Random random = Random();
          Events app = Events.fromFireBaseSnapShotData(
              element, _colorCollection[random.nextInt(9)]);
          setState(() {
            events!.appointments!.add(app);
            events!.notifyListeners(CalendarDataSourceAction.add, [app]);
          });
        } else if (element.type == DocumentChangeType.modified) {
          if (!isInitialLoaded) {
            return;
          }
          final Random random = Random();
          Events app = Events.fromFireBaseSnapShotData(
              element, _colorCollection[random.nextInt(9)]);
          setState(() {
            int index = events!.appointments!
                .indexWhere((app) => app.key == element.doc.id);
            Events meeting = events!.appointments![index];
            events!.appointments!.remove(meeting);
            events!.notifyListeners(CalendarDataSourceAction.remove, [meeting]);
            events!.appointments!.add(app);
            events!.notifyListeners(CalendarDataSourceAction.add, [app]);
          });
        } else if (element.type == DocumentChangeType.removed) {
          if (!isInitialLoaded) {
            return;
          }
          setState(() {
            int index = events!.appointments!
                .indexWhere((app) => app.key == element.doc.id);
            Events meeting = events!.appointments![index];
            events!.appointments!.remove(meeting);
            events!.notifyListeners(CalendarDataSourceAction.remove, [meeting]);
          });
        }
      }
    });
    super.initState();
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Events> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  @override
  String getSubject(int index) {
    String fullName =
        appointments![index].groupName + " - " + appointments![index].eventName;
    return fullName;
  }

  @override
  String getLocation(int index) {
    String loc = appointments![index].location;
    return loc;
  }

  @override
  String getOrganizer(int index) {
    String org = appointments![index].organizer;
    return org;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  DateTime getEventDateTime(int index) {
    return appointments![index].eventDate.toDate();
  }

  int getGroupID(int index) {
    return appointments![index].groupID;
  }

  String getGroupName(int index) {
    return appointments![index].groupName;
  }

  Timestamp getEventDate(int index) {
    return appointments![index].eventDate;
  }
}

class Events {
  String? eventName;
  int? groupID;
  String? docID;
  Timestamp? eventDate;
  String? groupName;
  DateTime? from;
  DateTime? to;
  Color? background;
  bool? isAllDay;
  String? location;
  String? organizer;

  Events({
    this.eventName,
    this.groupID,
    this.eventDate,
    this.groupName,
    this.from,
    this.to,
    this.background,
    this.isAllDay,
    this.location,
    this.organizer,
  });

  static Events fromFireBaseSnapShotData(dynamic element, Color color) {
    return Events(
      eventName: element.doc.data()!['EventName'],
      from: element.doc.data()!('EventDate').toDate(),
      to: element.doc.data()!('to').toDate(),
      eventDate: element.doc.data()!['EventDate'],
      background: color,
      isAllDay: false,
      groupID: element.doc.data()!['GroupID'],
      groupName: element.doc.data()!['GroupName'],
      location: element.doc.data()!['Location'],
      organizer: element.doc.data()!['Organizer'],
    );
  }
}
