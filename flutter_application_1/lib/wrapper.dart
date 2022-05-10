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
      if (user == null) {
        return loading ? Loading() : const Authenticate();
      } else {
        return LoadPage();
      }
    } catch (e) {
      return loading ? Loading() : MainPage();
    }
    // return either the Home or Authenticate widget
  }
}
