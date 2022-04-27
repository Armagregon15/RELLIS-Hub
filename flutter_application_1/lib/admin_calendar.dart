//import 'dart:html';
//import 'dart:html';
import 'dart:math';
//import 'package:flutter_application_1/events.dart';

import 'package:flutter/scheduler.dart';
//import 'package:flutter_application_1/events.dart';
//import 'package:flutter_application_1/events.dart';
//import 'dart:collection';
import 'authmain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/setUp.dart';
//import 'package:table_calendar/table_calendar.dart';
import 'database_service.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

import 'loading.dart';
//import 'package:firebase_database/firebase_database.dart';

DatabaseService _dbs = DatabaseService(uid: '');
final AuthService _auth = AuthService();

//go back until list<color> is final
// ignore: use_key_in_widget_constructors
class AdminCalendar extends StatefulWidget {
  @override
  AdminCalendarState createState() => AdminCalendarState();
}

//late Map<DateTime, List<Appointment>> _dataCollection;
//Map<DateTime, List<_Meeting>> _dataCollection = <DateTime, List<_Meeting>>{};

class AdminCalendarState extends State<AdminCalendar> {
  final List<Color> _colorCollection = <Color>[];
  final fireStoreReference = FirebaseFirestore.instance;
  MeetingDataSource? events;
  final List<String> options = <String>['Add', 'Delete', 'Update'];
  bool isInitialLoaded = false;

  @override
  void initState() {
    _dbs.getIndexDB().then((value) {
      // Future.delayed(
      // const Duration(seconds: 2));

      List<int> indexdb = _dbs.getTheList(value);
      print('first time');
      print(indexdb);
    });
    _initializeEventColor();
    getDataFromFireStore().then((results) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    fireStoreReference
        .collection("Events")
        .where("GroupID", whereIn: indexdb)
        .snapshots()
        .listen((event) {
      for (var element in event.docChanges) {
        // print('element printed');

        //print(element);
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

  Future<void> getDataFromFireStore() async {
    await _dbs.getIndexDB().then((value) {
      // Future.delayed(
      // const Duration(seconds: 2));

      List<int> indexdb = _dbs.getTheList(value);
      print('first time calendar');
      print(indexdb);
    });
    var snapShotsValue = await fireStoreReference
        .collection("Events")
        //.where("GroupID", whereIn: indexdb)
        .get();
    print("Get data from fire store");
    print(indexdb);
    print('snap shots value');
    print(snapShotsValue);
    print('snap shots value');
    final Random random = Random();
    List<Events> list = snapShotsValue.docs
        .map((e) => Events(
              eventName: e.data()['EventName'],
              from: e.data()['EventDate'].toDate(),
              to: e.data()['EventDate'].toDate(),
              /*
              from: DateFormat('yyyy-mm-dd HH:mm:ss')
                  .parse(e.data()['EventDate']),
              to: DateFormat('yyyy-mm-dd HH:mm:ss')
                  .parse(e.data()['EventDate']),
                  */
              eventDate: e.data()['EventDate'],
              //eventDateTime: e.data()['EventDate'].toDate(),
              background: _colorCollection[random.nextInt(9)],
              isAllDay: false,
              groupID: e.data()['GroupID'],
              groupName: e.data()['GroupName'],
            ))
        .toList();
    setState(() {
      events = MeetingDataSource(list);
      print('List in get data');
      print(indexdb);
      print(events.toString());
      //list[0].printDate();
      // print(snapShotsValue.docs['EventDate'][0]);
      // print(list[0]['eventDate']);
      // print([0]['eventDate']);
      // print(list.eventDate.toString());
      print('List in get data');
    });
  }

  /*
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
              child: const Text(
                "The Hub @ RELLIS",
                style: TextStyle(fontFamily: "Roboto", fontSize: 30),
              )),
          backgroundColor: const Color(0xFF500000),
        )
        */
  @override
  Widget build(BuildContext context) {
    isInitialLoaded = true;
    return Scaffold(
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
                child: const Text(
                  "The Hub @ RELLIS",
                  style: TextStyle(fontFamily: "Roboto", fontSize: 30),
                )),
            backgroundColor: const Color(0xFF500000),
            leading: PopupMenuButton<String>(
              icon: Icon(Icons.settings),
              itemBuilder: (BuildContext context) =>
                  options.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList(),
              onSelected: (String value) {
                if (value == 'Add') {
                  fireStoreReference.collection("Events").doc().set({
                    'EventDate': 1 - 6 - 2022,
                    'EventName': 'Hello',
                    'GroupID': 18,
                    'GroupName': "RELLIS"
                  });
                } else if (value == "Delete") {
                  try {
                    fireStoreReference
                        .collection('CalendarAppointmentCollection')
                        .doc('1')
                        .delete();
                  } catch (e) {}
                } else if (value == "Update") {
                  try {
                    fireStoreReference
                        .collection('CalendarAppointmentCollection')
                        .doc('1')
                        .update({'Subject': 'Meeting'});
                  } catch (e) {}
                }
              },
            )),
        body: SfCalendar(
          view: CalendarView.month,
          todayHighlightColor: const Color(0xFF500000),
          showDatePickerButton: true,
          //backgroundColor: const Color(0xFF500000),
          monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              showAgenda: true,
              agendaStyle: AgendaStyle(
                  backgroundColor: Color(0xFF500000),
                  dateTextStyle: TextStyle(color: Colors.white),
                  dayTextStyle: TextStyle(color: Colors.white))),
          dataSource: events,
          /*
          loadMoreWidgetBuilder:
              (BuildContext context, LoadMoreCallback loadMoreAppointments) {
            return FutureBuilder<void>(
              //initialData: 'loading',
              future: loadMoreAppointments(),
              builder: (context, snapShot) {
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(const Color(0xFF500000)),
                  ),
                );
              },
            );
          },
          */
        ));
  }

  void _initializeEventColor() {
    // ignore: deprecated_member_use
    //this._colorCollection = <Color>[];
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
    return appointments![index].eventName;
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
  Timestamp? eventDate;
  String? groupName;
  DateTime? from;
  DateTime? to;
  Color? background;
  bool? isAllDay;
  Events({
    //required this.eventDate,
    //required this.eventName,
    //required this.groupName,
    this.eventName,
    this.groupID,
    this.eventDate,
    //this.eventDateTime,
    this.groupName,
    this.from,
    this.to,
    this.background,
    this.isAllDay,
  });
  static Events fromFireBaseSnapShotData(dynamic element, Color color) {
    return Events(
      eventName: element.doc.data()!['EventName'],
      from: element.doc.data()!('EventDate').toDate(),
      to: element.doc.data()!('EventDate').toDate(),

      //from: DateFormat('yyyy-mm-dd HH:mm:ss')
      //.parse(element.doc.data()!['EventDate']),
      //to: DateFormat('yyyy-mm-dd HH:mm:ss')
      //.parse(element.doc.data()!['EventDate']),

      eventDate: element.doc.data()!['EventDate'],
      //eventDateTime: element.doc.data()!['EventDate'].toDate(),
      background: color,
      isAllDay: false,
      groupID: element.doc.data()!['GroupID'],
      groupName: element.doc.data()!['GroupName'],
    );
    //key: element.doc.id);
  }

  void printDate() {
    print(this.eventDate.toString());
  }
}
