import 'dart:math';
import 'package:flutter/scheduler.dart';
import 'authmain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/setUp.dart';
import 'database_service.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'loading.dart';

DatabaseService _dbs = DatabaseService(uid: '');
final AuthService _auth = AuthService();

//go back until list<color> is final
// ignore: use_key_in_widget_constructors
class Calendar extends StatefulWidget {
  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  final List<Color> _colorCollection = <Color>[];
  final fireStoreReference = FirebaseFirestore.instance;
  MeetingDataSource? events;
  final List<String> options = <String>['Add', 'Delete', 'Update'];
  bool isInitialLoaded = false;
  int _selectedIndex = 0;
  @override
  void initState() {
    _dbs.getIndexDB().then((value) {
      List<int> indexdb = _dbs.getTheList(value);
    });
    _initializeEventColor();
    getDataFromFireStore().then((results) {
      //Adds events to calendar based on timestamp (date)
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    // will listen in the events collection for any changes
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
            //listens for if a event was added to database
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
            // listens for if a event was removed from database
            Events meeting = events!.appointments![index];
            events!.appointments!.remove(meeting);
            events!.notifyListeners(CalendarDataSourceAction.remove, [meeting]);
          });
        }
      }
    });
    super.initState();
  }

//Gets the collection data from databse and specifc to users choices
  Future<void> getDataFromFireStore() async {
    await _dbs.getIndexDB().then((value) {
      List<int> indexdb = _dbs.getTheList(value);
    });
    var snapShotsValue = await fireStoreReference
        .collection("Events")
        .where("GroupID", whereIn: indexdb)
        .get();
    final Random random = Random();
    //maps the events and will put data to a list to show on calendar
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
            ))
        .toList();
    setState(() {
      events = MeetingDataSource(list);
    });
  }

//widget that actually builds calendar mainly at
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
            : Navigator.push(
                context, MaterialPageRoute(builder: (context) => Calendar()));
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
                      builder: (context) => loading ? Loading() : MainPage()));
            },
            child: const Text(
              "The Hub @ RELLIS",
              style: TextStyle(fontFamily: "Roboto", fontSize: 30),
            )),
        backgroundColor: const Color(0xFF500000),
      ),
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

  //assigns random color to each event on calendar
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
}

//gets data and will show as a appointment in calendar
//appointments is used from the syncfusion package.
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

//Creates the event class and all the necessary attributes
class Events {
  String? eventName;
  int? groupID;
  Timestamp? eventDate;
  String? groupName;
  DateTime? from;
  DateTime? to;
  Color? background;
  bool? isAllDay;

  //Constructor
  Events({
    this.eventName,
    this.groupID,
    this.eventDate,
    this.groupName,
    this.from,
    this.to,
    this.background,
    this.isAllDay,
  });

  // gets data from database and is assigned to a object of events.
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
    );
  }

  void printDate() {
    print(this.eventDate.toString());
  }
}
