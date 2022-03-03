import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/moor_database.dart';

class Home extends StatefulWidget {
  Home({required Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final database = Provider.of<AppDatabase>(context);
  final eventNameController = TextEditingController();
  final groupNameController = TextEditingController();
  final eventDateController = TextEditingController();
  final groupIDController = TextEditingController();
  final eventIDController = TextEditingController();
  @override
  void dispose() {
    eventNameController.dispose();
    groupNameController.dispose();
    eventDateController.dispose();
    groupIDController.dispose();
    eventIDController.dispose();
    super.dispose();
  }

  void createEvent(
      {required AppDatabase database,
      required String eventName,
      required String groupName,
      required String eventDate,
      required int groupID,
      required int eventID}) async {
    Event event = Event(
        group_name: groupName,
        group_id: groupID,
        event_name: eventName,
        event_date: eventDate,
        event_id: eventID);

    database.insertEvent(event);
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    final _eventname = Padding(
        padding:
            EdgeInsets.only(top: 0.0, bottom: 0.0, left: 30.0, right: 30.0),
        child: TextField(
          // hintText: 'event name',
          controller: eventNameController,
        ));

    final _groupname = Padding(
        padding:
            EdgeInsets.only(top: 20.0, bottom: 0.0, left: 30.0, right: 30.0),
        child: TextField(
          // hintText: 'group name',
          controller: groupNameController,
        ));

    final _eventDate = Padding(
        padding:
            EdgeInsets.only(top: 20.0, bottom: 0.0, left: 30.0, right: 30.0),
        child: TextField(
          // hintText: 'event date',
          controller: eventDateController,
        ));

    final _groupID = Padding(
        padding:
            EdgeInsets.only(top: 20.0, bottom: 0.0, left: 30.0, right: 30.0),
        child: TextField(
          // hintText: 'group id',
          controller: groupIDController,
        ));

    final _eventID = Padding(
        padding:
            EdgeInsets.only(top: 20.0, bottom: 0.0, left: 30.0, right: 30.0),
        child: TextField(
          // hintText: 'event id',
          controller: eventIDController,
        ));

    final _createButton = Padding(
      padding: EdgeInsets.only(top: 50.0, bottom: 0.0, right: 50.0, left: 50.0),
      child: ElevatedButton(
        onPressed: () => createEvent(
          database: database,
          eventName: eventNameController.text,
          eventDate: eventDateController.text,
          groupName: groupNameController.text,
          groupID: int.parse(groupIDController.text),
          eventID: int.parse(eventIDController.text),
        ),
        child: const Text('Add Event', style: TextStyle(fontSize: 20)),
      ),
    );

    final _screen = Material(
        color: Colors.transparent,
        child: new Container(
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _eventname,
                _eventDate,
                _groupname,
                _eventID,
                _groupID,
                _createButton
              ]),
        ));

    return Scaffold(
      backgroundColor: Colors.purple,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: Center(
              child: _screen,
            ),
          ),
        ),
      ),
    );
  }
}

//
// class NewEventInput extends StatefulWidget {
//   const NewEventInput({
//     required Key key,
//   }) : super(key: key);
//
//   @override
//   _NewEventState createState() => _NewEventInputState();
// }
//
// class _NewEventInputState extends State<NewEventInput> {
//   TextEditingController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = TextEditingController();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           _buildTextField(context),
//         ],
//       ),
//     );
//   }
//
//   Expanded _buildTextField(BuildContext context) {
//     return Expanded(
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(hintText: 'Event Name'),
//         onSubmitted: (inputName) {
//           final database = Provider.of<AppDatabase>(context);
//           final event = Event(
//             event_name: inputName,
//             event_date:eventDate,
//             group_id: groupID,
//             group_name: groupName,
//             event_id: ,
//           );
//           database.insertEvent(event);
//           resetValuesAfterSubmit();
//         },
//       ),
//     );
//   }
//
//
//   void resetValuesAfterSubmit() {
//     setState(() {
//       controller.clear();
//     });
//   }
// }
//

// final database = Provider.of<AppDatabase>(context);
// final event0 = Event(
//   event_id: 1,
//   group_id: 1,
//   event_name: 'Pizza Party',
//   event_date: 'June, 1, 2020',
//   group_name: 'Rellis Computing Club',
// );
// database.insertEvent(event);
//
// final event1 = Event(
//   event_id: 1,
//   group_id: 1,
//   event_name: 'Registration',
//   event_date: 'April, 1, 2021',
//   group_name: 'Rellis Computing Club',
// );
// database.insertEvent(event);