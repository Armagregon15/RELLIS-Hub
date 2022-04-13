import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'authmain.dart';
import 'Register.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LoginHub(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
