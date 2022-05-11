// ignore_for_file: unnecessary_null_comparison
import 'package:flutter_application_1/setUp.dart';
import 'database_service.dart';
import 'user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String admin = 'i7FYbLbMlzNfaYEFVWQOimDRYdu2';
  // create user obj based on firebase user
  MyUser? _userFromFirebaseUser(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<MyUser?>? get user {
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
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return user;
    } catch (error) {
      return null;
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
