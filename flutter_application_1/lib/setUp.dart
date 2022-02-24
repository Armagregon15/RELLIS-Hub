// ignore: file_names
// ignore_for_file: prefer_const_constructors, avoid_print, file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/answer.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cloudstore_firestore/cloud_firestore.dart'
import './result.dart';
import './quiz.dart';
import './answer.dart';

// ignore: use_key_in_widget_constructors
class SetUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return SetUpState();
  }
}

class SetUpState extends State<SetUp> {
  List<dynamic> savedWordPairs = [];
  static List<int> answers = [];
  final _questions = [
    // this is a map for the quuestion and the answers. Key value pairs
    {
      'questionText': 'Pick Your Univeristy',
      'answers': [
        {'text': 'Praire View A&M University', 'value': 1},
        {'text': 'Stepehen F Austin State University', 'value': 2},
        {'text': 'Tarleton State University', 'value': 3},
        {'text': 'Texas A&M International University', 'value': 4},
        {'text': 'Texas A&M University Central Texas', 'value': 5},
        {'text': 'Texas A&M University Commerce', 'value': 6},
        {'text': 'Texas A&M University Corpus Christi', 'value': 7},
        {'text': 'Texas A&M University Kingsville', 'value': 8},
        {'text': 'Texas A&M University San Antonio', 'value': 9},
        {'text': 'Texas A&M University Texarkana', 'value': 10},
        {'text': 'West Texas A&M University', 'value': 11}
      ],
    },
    {
      'questionText': 'Pick Your Interest',
      'answers': [
        {'text': 'Sports', 'value': 0},
        {'text': 'Gaming', 'value': 0},
        {'text': 'Business', 'value': 0},
        {'text': 'Nursing', 'value': 0},
        {'text': 'Programming', 'value': 0},
        {'text': 'Movies', 'value': 0},
        {'text': 'Reading', 'value': 0},
        {'text': 'Cooking', 'value': 0},
      ],
    },
    {
      'questionText': 'Pick Your Clubs',
      'answers': [
        {'text': 'STACC', 'value': 12},
        {'text': 'RELLIS RANGERS', 'value': 13},
        {'text': 'Student Council', 'value': 14}
      ],
    },
  ];
  var _questionIndex = 0;
  //var saveAnswers = [];

  static void saveAnswer(int value) {
    answers.add(value);
  }

  void _answerQuestion() {
    //var aBool = true;
    //aBool = false;
    setState(() {
      _questionIndex = _questionIndex + 1;
      //answers.add(_questionindex.)
    });
    print(_questionIndex);

    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xFF500000),
          title: const Text('The Hub @ Rellis'),
        ),
        body: _questionIndex <
                _questions.length //checks to see if all questions are answered
            ? Quiz(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
              )
            : MainPage(answers),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
