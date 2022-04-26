import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'loading.dart';
import 'constants.dart';
import 'database_service.dart';
import 'user.dart';
import 'loading.dart';
import 'setUp.dart';

DatabaseService _dbs = DatabaseService(uid: '');
bool loading = false;

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<int> groupIDs = [];
  //final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];

  // form values
  late int _currentUser;
  //String _currentSugars;
  //int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final MyUser user = Provider.of<MyUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: '').userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const Text(
                    'Update Feed Settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData!.uid,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) =>
                        setState(() => _currentUser = val as int),
                  ),
                  const SizedBox(width: 10.0),
                  DropdownButtonFormField(
                    value: _currentUser,
                    decoration: textInputDecoration,
                    items: groupIDs.map((events) {
                      return DropdownMenuItem(
                        value: events,
                        child: Text('$events events'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _currentUser = val as int),
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _dbs.updateUserData(indexdb);
                          _dbs.setTheList(indexdb);
                          loading
                              ? Loading()
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => formStart()));
                        }
                      }),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
