import 'package:flutter/material.dart';
import 'package:flutter_application_1/wrapper.dart';
import 'authmain.dart';
import 'user.dart';
//import 'package:flutter_application_1/authentication_service.dart';
//import 'package:flutter_application_1/setUp.dart';
import 'package:provider/provider.dart';
//import './loginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        title: 'The Hub @ RELLIS',
        theme: ThemeData(
          primaryColor: const Color(0xFF500000),
        ),
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
/*
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          //create: (_) => AuthenticationService(FirebaseAuth.instance),
          create: (_) => AuthenticationService(FirebaseAuth.instance),
          // builder: (context) ={
          //   return Text(context.watch<AuthenticationService(_firebaseAuth))
          // } MyApp(),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: const [],
        )
      ],
      child: MaterialApp(
        title: 'The Hub @ RELLIS',
        theme: ThemeData(
          primaryColor: const Color(0xFF500000),
        ),
        home: const AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      print(firebaseUser);
      return formStart();
    }
    print(firebaseUser);
    return LoginHub();
  }
}
*/
// val db = Firebase.firestore