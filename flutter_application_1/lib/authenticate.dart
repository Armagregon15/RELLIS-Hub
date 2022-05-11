import 'package:flutter/material.dart';
import 'loading.dart';
import 'loginPage.dart';
import 'Register.dart';

// This file will authenticate if user is signed in or out.
// This is very important to keeping users signed in.

bool loading = false;

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return loading ? Loading() : LoginHub(toggleView: toggleView);
    } else {
      return loading ? Loading() : Register(toggleView: toggleView);
    }
  }
}
