// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names, deprecated_member_use
import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/setUp.dart';
import 'authmain.dart';
import 'loading.dart';

//parent class LoginHub
class LoginHub extends StatefulWidget {
  final Function toggleView;
  const LoginHub({required this.toggleView});

  @override
  _LoginHub createState() => _LoginHub();
}

//actual _LoginHub page
class _LoginHub extends State<LoginHub> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: const Color(0xFF500000),
              elevation: 0.0,
              title: Text('The Hub @ RELLIS'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                  textColor: Colors.white,
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    //email text field
                    TextFormField(
                      onFieldSubmitted: (value) async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          //check for successful log in
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error =
                                  'Could not sign in with those credentials';
                            });
                          } else {
                            //if sign in successful redirect to LoadPage
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoadPage()));
                          }
                        }
                      },
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      //checks to see if email was entered
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    //password text field
                    TextFormField(
                      onFieldSubmitted: (value) async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error =
                                  'Could not sign in with those credentials';
                            });
                          } else {
                            //if log in successful, 
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoadPage()));
                          }
                        }
                      },
                      obscureText: true,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                          //validator checks password length
                      validator: (val) => val!.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      //onFieldSubmitted: 
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: const Color(0xFF500000),
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          //if everything validates, sign in with auth
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error =
                                    'Could not sign in with those credentials';
                              });
                            } else { //if log in successful redirect to LoadPage
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoadPage()));
                            }
                          }
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
