import 'package:flutter/material.dart';
import 'package:flutter_application_1/setUp.dart';
import 'package:provider/provider.dart';
import './loginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

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
    );
  }
}

// val db = Firebase.firestore