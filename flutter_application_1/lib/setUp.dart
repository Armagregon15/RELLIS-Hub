// ignore: file_names
// ignore_for_file: prefer_const_constructors, avoid_print, file_names
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import './result.dart';
import 'firebase_options.dart';

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
    // this is a map for the question and the answers. Key value pairs
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
  int _selectedIndex = 0;
  //var saveAnswers = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
          : MainPage(/*answers*/),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 15,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedIconTheme: IconThemeData(
          color: Colors.white,
          size: 35,
        ),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color(0xFF500000),
        elevation: 90,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            label: 'Return',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
            label: 'Next',
          ),
        ],
      ),
    ));
  }
}

class Question extends StatelessWidget {
  final String questionText;

  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        questionText,
        // ignore: prefer_const_constructors
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final VoidCallback answerQuestion;

  Quiz({
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Question(
          questions[questionIndex]['questionText']?.toString() ?? '',
        ),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(answerQuestion, answer['text'].toString(),
              answer['value'].toString());
        }).toList()
      ],
    );
  }
}

class Answer extends StatefulWidget {
  final VoidCallback selectHandler;
  final String answerText;
  final String value;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  Answer(this.selectHandler, this.answerText, this.value);

  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  bool click = true;

  get() => widget.value;

  bool boolCheck = false;
  bool newValue = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CheckboxListTile(
        title: Text(widget.answerText, style: TextStyle(fontSize: 18.0)),
        value: boolCheck,
        onChanged: (bool? newValue) {
          setState(() {
            boolCheck = !boolCheck;
          });
          SetUpState.saveAnswer(int.parse(get()));
          print(int.parse(get()));
        },
        secondary: const Icon(Icons.dangerous),
      ),
    );
  }
}

class Page1 extends StatefulWidget {
  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // List of Widgets index //
  static const List<Widget> _widgetOptions = <Widget>[
    TestPage1(),
    TestPage2(),
    TestPage3(),
  ];

  bool click = true;
  bool boolCheck = false;
  bool newValue = false;

  // Unused //

  /*Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return Card(
      child: CheckboxListTile(
        title: Text(document['GroupName'], style: TextStyle(fontSize: 18.0)),
        value: boolCheck,
        onChanged: (bool? newValue) {
          setState(() {
            boolCheck = !boolCheck;
          });
          // SetUpState.saveAnswer(int.parse(get()));
          // print(int.parse(get()));
        },
        secondary: const Icon(Icons.dangerous),
      ),
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF500000),
        title: const Text('The Hub @ Rellis'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 15,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedIconTheme: IconThemeData(
          color: Colors.white,
          size: 35,
        ),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        backgroundColor: const Color(0xFF500000),
        elevation: 90,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.school,
              color: Colors.white,
            ),
            label: 'Schools',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: 'Clubs',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            label: 'Interests',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Schools //
class TestPage1 extends StatefulWidget {
  const TestPage1({Key? key}) : super(key: key);

  @override
  State<TestPage1> createState() => _TestPage1State();
}

class _TestPage1State extends State<TestPage1> {
  int _selectedIndex = 0;

  bool click = true;
  bool boolCheck = false;
  bool newValue = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Groups')
            .doc('za9ndxLTLGVx449SKnRT')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading");
          } else {
            Map<String, dynamic> documentFields =
                snapshot.data?.data() as Map<String, dynamic>;
            return Card(
              child: CheckboxListTile(
                title: Text(documentFields['GroupName'],
                    style: TextStyle(fontSize: 18.0)),
                value: boolCheck,
                onChanged: (bool? newValue) {
                  setState(() {
                    boolCheck = !boolCheck;
                  });
                },
                secondary: const Icon(Icons.dangerous),
              ),
            );
          }
        });
  }
}

// Clubs //
class TestPage2 extends StatelessWidget {
  const TestPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 221, 165, 139),
      child: Center(
        child: Text(
          "Clubs",
          style: TextStyle(
            color: Color.fromARGB(255, 253, 253, 253),
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// Interests //
class TestPage3 extends StatelessWidget {
  const TestPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 162, 132, 230),
      child: Column(
        children: [
          Center(
            child: Text(
              "Interests",
              style: TextStyle(
                color: Color.fromARGB(255, 253, 253, 253),
                fontSize: 45,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.circle,
              color: Colors.black,
            ),
            tooltip: 'Submit',
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            },
          ),
        ],
      ),
    );
  }
}
