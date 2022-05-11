// ignore_for_file: deprecated_member_use
//import 'package:flutter_application_1/setUp.dart';


// This file is the page for registering a user

import 'constants.dart';
import 'package:flutter/material.dart';
import 'loading.dart';
import 'setUp.dart';
import "authmain.dart";

//parent class
class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

//_RegisterState class
class _RegisterState extends State<Register> {
  var focusNode = FocusNode();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String password1 = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: const Color(0xFF500000),
              elevation: 0.0,
              automaticallyImplyLeading: false,
              title: const Text(
                'The Hub @ RELLIS',
                style: TextStyle(fontSize: 30),
              ),
              actions: <Widget>[
                FlatButton.icon(
                  icon: const Icon(Icons.person),
                  label: const Text('Sign In'),
                  textColor: Colors.white,
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20.0),
                    //email text field
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      //validator makes sure that a proper school email is used for account creation
                      validator: (val) => val!.isEmpty || !val.contains('.edu')
                          ? 'Enter an email ending in .edu'
                          : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      onFieldSubmitted: (value) async {
                        _auth.checkIfEmailInUse(email);
                        //checks to see if the email is already registered
                        if (_formKey.currentState!.validate()) {
                          if (_auth.validEmail() == true) {
                            setState(() {
                              error = 'The email is already registered';
                            });
                          }
                          setState(() => loading = true);
                          //after checks, registers email in _auth
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          indexdb = [18];
                          //redirect to formStart for school and group selections
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => formStart()));
                          //error message if validator fails
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'Please supply a valid email';
                            });
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => formStart()));
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 20.0),
                    //password text field
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
                      //validator checks for password length
                      validator: (val) => val!.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      onFieldSubmitted: (value) async {
                        _auth.checkIfEmailInUse(email);
                        if (_formKey.currentState!.validate()) {
                          if (_auth.validEmail() == true) {
                            setState(() {
                              error = 'The email is already registered';
                            });
                          }
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          indexdb = [18]; //default rellis group
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => formStart()));

                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'Please supply a valid email';
                            });
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => formStart()));
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 20.0),
                    //password confirmation text field
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Confirm Password'),
                      obscureText: true,
                      //validator checks if the password is long enough and if they match
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter a password 6+ chars long';
                        }
                        if (val != password) {
                          return 'Password does not match';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) async {
                        _auth.checkIfEmailInUse(email);
                        if (_formKey.currentState!.validate()) {
                          if (_auth.validEmail() == true) {
                            setState(() {
                              //loading = true;
                              error = 'The email is already registered';
                            });
                          }
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          indexdb = [18]; //default rellis group
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => formStart()));

                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'Please supply a valid email';
                            });
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => formStart()));
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            color: const Color(0xFF500000),
                            borderRadius: BorderRadius.circular(20)),
                        child: RaisedButton(
                            color: const Color(0xFF500000),
                            child: const Text(
                              'Register',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () async {
                              _auth.checkIfEmailInUse(email);
                              if (_formKey.currentState!.validate()) {
                                if (_auth.validEmail() == true) {
                                  setState(() {
                                    //loading = true;
                                    error = 'The email is already registered';
                                  });
                                }
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        email, password);
                                indexdb = [18];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => formStart()));

                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error = 'Please supply a valid email';
                                  });
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => formStart()));
                                }
                              }
                            })),
                    const SizedBox(height: 12.0),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
