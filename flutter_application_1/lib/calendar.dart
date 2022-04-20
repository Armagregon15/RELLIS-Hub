// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/setUp.dart';
//import 'package:table_calendar/table_calendar.dart';
import 'database_service.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

DatabaseService _dbs = DatabaseService(uid: '');

// ignore: use_key_in_widget_constructors
class calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

late Map<DateTime, List<Appointment>> _dataCollection;

class _CalendarState extends State<calendar> {
  late var _calendarDataSource;

  @override
  void initState() {
    _dataCollection = getAppointments();
    _calendarDataSource = MeetingDataSource(<Appointment>[]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // ignore: prefer_const_constructors
          title: Text("The Hub @ RELLIS"),
          backgroundColor: const Color(0xFF500000),
        ),
        body: SfCalendar(
          view: CalendarView.month,
          todayHighlightColor: const Color(0xFF500000),
          showDatePickerButton: true,
          monthViewSettings: MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              showAgenda: true,
              agendaStyle: AgendaStyle(
                  backgroundColor: const Color(0xFF500000),
                  dateTextStyle: TextStyle(color: Colors.white),
                  dayTextStyle: TextStyle(color: Colors.white))),
          dataSource: _calendarDataSource,
          loadMoreWidgetBuilder:
              (BuildContext context, LoadMoreCallback loadMoreAppointments) {
            return FutureBuilder(
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
        ));
  }

//appointments is a collection that is given in sync
//need to get user and event collections
  Map<DateTime, List<Appointment>> getAppointments() {
    final List<int> _subjectCollection = indexdb;
    _dbs.getIndexDB();
    indexdb = _dbs.getTheList();
    //final List<String> _subjectCollection = indexdb as List<String>;
    /*
    _subjectCollection.add('General Meeting');
    _subjectCollection.add('Plan Execution');
    _subjectCollection.add('Project Plan');
    _subjectCollection.add('Consulting');
    _subjectCollection.add('Support');
    _subjectCollection.add('Development Meeting');
    _subjectCollection.add('Scrum');
    _subjectCollection.add('Project Completion');
    _subjectCollection.add('Release updates');
    _subjectCollection.add('Performance Check');
*/
    final List<Color> _colorCollection = <Color>[];
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

//just list the array of events randomly.
    final Random random = Random();
    var _dataCollection = <DateTime, List<Appointment>>{};
    final DateTime today = DateTime.now();
    final DateTime rangeStartDate = DateTime(today.year, today.month, today.day)
        .add(const Duration(days: -1000));
    final DateTime rangeEndDate = DateTime(today.year, today.month, today.day)
        .add(const Duration(days: 1000));
    for (DateTime i = rangeStartDate;
        i.isBefore(rangeEndDate);
        i = i.add(Duration(days: 1 + random.nextInt(2)))) {
      final DateTime date = i;
      final int count = 1 + random.nextInt(3);
      for (int j = 0; j < count; j++) {
        final DateTime startDate = DateTime(
            date.year, date.month, date.day, 8 + random.nextInt(8), 0, 0);
        final int duration = random.nextInt(3);
        final Appointment meeting = Appointment(
            //this is what shows the array in each calendar box
            subject: indexdb.toString(),
            startTime: startDate,
            endTime:
                startDate.add(Duration(hours: duration == 0 ? 1 : duration)),
            color: _colorCollection[random.nextInt(9)],
            isAllDay: false);

        if (_dataCollection.containsKey(date)) {
          final List<Appointment> meetings = _dataCollection[date]!;
          meetings.add(meeting);
          _dataCollection[date] = meetings;
        } else {
          _dataCollection[date] = [meeting];
        }
      }
    }
    return _dataCollection;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }

  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
    await Future.delayed(Duration(seconds: 1));
    final List<Appointment> meetings = <Appointment>[];
    DateTime appStartDate = startDate;
    DateTime appEndDate = endDate;

    while (appStartDate.isBefore(appEndDate)) {
      final List<Appointment>? data = _dataCollection[appStartDate];
      if (data == null) {
        appStartDate = appStartDate.add(Duration(days: 1));
        continue;
      }
      for (final Appointment meeting in data) {
        if (appointments!.contains(meeting)) {
          continue;
        }
        meetings.add(meeting);
      }
      appStartDate = appStartDate.add(Duration(days: 1));
    }
    appointments!.addAll(meetings);
    notifyListeners(CalendarDataSourceAction.add, meetings);
  }
}
/*
class _CalendarState extends State<Calendar> {
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text("The Hub @ RELLIS"),
        backgroundColor: const Color(0xFF500000),
      ),
      body: Column(children: [
        TableCalendar(
          focusedDay: DateTime.now(),
          firstDay: DateTime(1999),
          lastDay: DateTime(2050),
          calendarFormat: format,
          onFormatChanged: (CalendarFormat _format) {
            setState(() {
              format = _format;
            });
          },
          startingDayOfWeek: StartingDayOfWeek.sunday,
          daysOfWeekVisible: true,
          //Day Changed
          onDaySelected: (DateTime selectDay, DateTime focusDay) {
            setState(() {
              selectedDay = selectDay;
              focusedDay = focusDay;
            });
          },
          selectedDayPredicate: (DateTime date) {
            return isSameDay(selectedDay, date);
          },

          eventLoader: _getEventsfromDay,

          //To style Calendar
          calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            selectedDecoration: BoxDecoration(
              color: const Color(0xFF500000),
              shape: BoxShape.circle,
            ),
            selectedTextStyle: TextStyle(color: Colors.white),
            todayDecoration: BoxDecoration(
              color: Color.fromARGB(186, 80, 0, 0),
              shape: BoxShape.circle,
            ),
          ),
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
        ),
        ..._getEventsfromDay(selectedDay)
            .map((Event event) => ListTile(title: Text(event.title))),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF500000),
        onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Add Event"),
                  backgroundColor: Color.fromARGB(171, 80, 0, 0),
                  titleTextStyle: TextStyle(color: Colors.white),
                  content: TextFormField(
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    controller: _eventController,
                  ),
                  actions: [
                    TextButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child:
                          Text("Submit", style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        if (_eventController.text.isEmpty) {
                        } else {
                          if (selectedEvents[selectedDay] != null) {
                            selectedEvents[selectedDay]!.add(
                              Event(title: _eventController.text),
                            );
                          } else {
                            selectedEvents[selectedDay] = [
                              Event(title: _eventController.text)
                            ];
                          }
                          Navigator.pop(context);
                          _eventController.clear();
                          setState(() {});
                          return;
                        }
                      },
                    ),
                  ],
                )),
        label: Text("Add Event"),
        icon: Icon(Icons.add),
      ),
    );
  }
}

class Event {
  final String title;
  Event({required this.title});

  String toString() => this.title;
}
*/