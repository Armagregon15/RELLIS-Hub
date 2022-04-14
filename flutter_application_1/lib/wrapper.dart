import 'package:flutter/material.dart';
import 'package:flutter_application_1/setUp.dart';
import 'package:provider/provider.dart';
import 'authenticate.dart';
import 'user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      final user = Provider.of<MyUser?>(context);
      print(user);
      if (user == null) {
        return const Authenticate();
      } else {
        return MainPage();
      }
    } catch (e) {
      print(e.toString());
      
      return MainPage();
    }
    // return either the Home or Authenticate widget
  }
}
