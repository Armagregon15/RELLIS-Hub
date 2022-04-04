// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// ignore: use_key_in_widget_constructors
class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

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
