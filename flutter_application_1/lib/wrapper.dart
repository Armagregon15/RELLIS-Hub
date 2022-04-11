import 'package:flutter/material.dart';
import 'package:flutter_application_1/setUp.dart';
import 'package:provider/provider.dart';
import 'authenticate.dart';
import 'user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null) {
      return const Authenticate();
    } else {
      return MainPage();
    }
  }
}
