// ignore_for_file: deprecated_member_use
//import 'package:flutter_application_1/setUp.dart';

import 'constants.dart';
import 'package:flutter/material.dart';
import 'loading.dart';
import 'setUp.dart';
import "authmain.dart";
//import 'form_start.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

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
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) => val!.isEmpty || !val.contains('.edu')
                          ? 'Enter an email ending in .edu'
                          : null,
                      onChanged: (val) {
                        setState(() => email = val);
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
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
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
                              //loading = true;
                              error = 'The email is already registered';
                            });
                          }
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
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
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Confirm Password'),
                      obscureText: true,
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
