import 'package:flutter/material.dart';
import 'package:flutter_application_1/setUp.dart';
import 'package:provider/provider.dart';
import 'authenticate.dart';
import 'loading.dart';
import 'user.dart';

bool loading = false;

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      final user = Provider.of<MyUser?>(context);
      print(user);
      if (user == null) {
        return loading ? Loading() : const Authenticate();
      } else {
        // DatabaseService _dbs = DatabaseService(uid: '');
        // _dbs.getIndexDB();
        // indexdb = _dbs.getTheList();
        // print('auth index');
        // print(indexdb);
        return LoadPage();
      }
    } catch (e) {
      print(e.toString());

      return loading ? Loading() : MainPage();
    }
    // return either the Home or Authenticate widget
  }
}
