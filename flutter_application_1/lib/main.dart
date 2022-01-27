import 'package:flutter/material.dart';
import 'package:flutter_application_1/setUp.dart';
import 'package:provider/provider.dart';
import './loginPage.dart';
import './welcome.dart';
import 'data/moor_database.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => AppDatabase(),
        child: MaterialApp(
          title: 'The Hub @ RELLIS',
          theme: ThemeData(
            primaryColor: const Color(0xFF500000),
          ),
          home: LoginHub(),
        ));
  }
}
