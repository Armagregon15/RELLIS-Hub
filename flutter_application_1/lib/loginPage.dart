// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/authentication_service.dart';
import 'package:flutter_application_1/setUp.dart';
//import 'HomePage.dart';
import 'setUp.dart';
import 'calendar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginHub(),
    );
  }
}
*/

class LoginHub extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: const Color(0xFF500000),
            title: const Text('The Hub @ Rellis'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Center(
                    child: SizedBox(
                      width: 200,
                      height: 150,
                      /*decoration: BoxDecoration(
                        color: Color(0xFF500000),
                        borderRadius: BorderRadius.circular(50.0)),*/
                      //child: Image.asset('Put image of logo HERE')
                    ),
                  ),
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter valid email id as abc@gmail.com'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // ignore: todo
                    //TODO FORGOT PASSWORD SCREEN GOES HERE
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                        color: Color(0xFF500000), fontSize: 15), //0xFF500000
                  ),
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Color(0xFF500000),
                      borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    onPressed: () async {
                      dynamic result = await context
                          .read<AuthenticationService>()
                          .signIn(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim());
                      if (result == null) {
                        print('error signing in');
                      } else {
                        print('signed in');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => formStart()));
                      }
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF500000),
                      textStyle: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Color(0xFF500000),
                        borderRadius: BorderRadius.circular(20)),
                    child: ElevatedButton(
                      onPressed: () async {
                        dynamic result = await context
                            .read<AuthenticationService>()
                            .signUp(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim());
                        if (result == null) {
                          print('error signing up');
                        } else {
                          print('signed up');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => formStart()));
                        }
                      },
                      child: Text('Create User'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF500000),
                        textStyle: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ));
  }
}
