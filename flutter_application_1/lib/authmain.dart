// ignore_for_file: unnecessary_null_comparison

import 'dart:math';

import 'package:flutter_application_1/authenticate.dart';
import 'package:flutter_application_1/setUp.dart';

import 'database_service.dart';
import 'user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  bool valid = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String admin = 'i7FYbLbMlzNfaYEFVWQOimDRYdu2';
  // create user obj based on firebase user
  MyUser? _userFromFirebaseUser(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<MyUser?>? get user {
    print('here');
    try {
      return _auth
          .authStateChanges()
          .map((User? user) => _userFromFirebaseUser(user!));
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      print('here fool');
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return user;
    } catch (error) {
      print('here');
      // print(error.toString());
      return null;
    }
  }

  bool validEmail() {
    return valid;
  }

  Future<void> checkIfEmailInUse(String emailAddress) async {
    try {
      // Fetch sign-in methods for the email address
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);

      // In case list is not empty
      if (list.isNotEmpty) {
        // Return true because there is an existing
        // user using the email address
        valid = true;
      } else {
        // Return false because email adress is not in use
        valid = false;
      }
    } catch (error) {
      // Handle error
      // ...
      valid = true;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      indexdb = [18];
      await DatabaseService(uid: user.uid).updateUserData(indexdb);
      return _userFromFirebaseUser(user);
    } catch (error) {
      //print(error.toString());
      return null;
    }
  }

  Future getUID() async {
    User? result = await _auth.currentUser;
    return result?.uid;
  }

  Future getUserDate() async {}

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
