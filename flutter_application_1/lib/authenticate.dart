import 'package:flutter/material.dart';
import 'loading.dart';
import 'loginPage.dart';
import 'authmain.dart';
import 'Register.dart';

bool loading = false;

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
      return loading ? Loading() : LoginHub(toggleView: toggleView);
    } else {
      return loading ? Loading() : Register(toggleView: toggleView);
    }
  }
}
