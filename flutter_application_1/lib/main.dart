import 'package:flutter/material.dart';
import 'package:flutter_application_1/setUp.dart';
import 'package:provider/provider.dart';
import './loginPage.dart';
import './welcome.dart';
import './SetUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Hub @ RELLIS',
      theme: ThemeData(
        primaryColor: const Color(0xFF500000),
      ),
      home: LoginHub(),
      //routes: <String, WidgetBuilder>{
      //'/screen1': (BuildContext context) => _Page2State(),
      //'/screen2' : (BuildContext context) => new Screen2(),
      //'/screen3' : (BuildContext context) => new Screen3(),
      //'/screen4' : (BuildContext context) => new Screen4()
      // },
    );
  }
}

// val db = Firebase.firestore