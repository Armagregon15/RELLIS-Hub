import 'package:flutter/material.dart';
import './setUp.dart';
import 'calendar.dart';

class MainPage extends StatefulWidget {
  @override
  HomePage createState() => HomePage();
  MainPage(List<int> answers, {Key? key}) : super(key: key) {
    List<int> choices = answers;
  }
}

class HomePage extends State<MainPage> {
  int _selectedIndex = 0;

  List<List> school1 = [
    [
      'RELLIS',
      'Graduation',
      'December 15th, 2021',
    ],
    [
      'Prairie View A&M',
      ' Registration',
      'April 12th, 2022',
    ],
    [
      'Stephen F Austin',
      ' Registration',
      'April 13th, 2022',
    ],
    [
      'Tarleton State University',
      ' Registration',
      'April 14th, 2022',
    ],
    [
      'Texas A&M International University',
      ' Registration',
      'April 15th, 2022',
    ],
    [
      'Texas A&M Central Texas',
      ' Registration',
      'April 16th, 2022',
    ],
    [
      'Texas A&M Commerce',
      ' Registration',
      'April 17th, 2022',
    ],
    [
      'Texas A&M Corpus Christi',
      ' Registration',
      'April 18th, 2022',
    ],
    [
      'Texas A&M Kingsville',
      ' Registration',
      'April 19th, 2022',
    ],
    [
      'Texas A&M San Antonio',
      ' Registration',
      'April 20th, 2022',
    ],
    [
      'Texas A&M Texarkana',
      ' Registration',
      'April 21th, 2022',
    ],
    [
      'West Texas A&M',
      ' Registration',
      'April 22th, 2022',
    ],
    ['STACC', 'Pizza Party', 'December 16th'],
    ['RELLIS Rangers', 'Dance', 'January 1st'],
    ['Student Council', 'Election', 'February 15th'],
  ];
  // List<String> school2 = ['RELLIS System', ' Dance Party', 'December 15th'];
  // List<String> school3 = ['RELLIS Student Advisory Council', ' Christmas Ball', 'December 28th'];
  // List<String> list = [];

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Welcome to Flutter',
        home: Scaffold(
          //appBar: AppBar(
          //centerTitle: true,
          //backgroundColor: const Color(0xFF500000),
          //title: const Text('The Hub @ Rellis'),
          //  ),
          body: Column(
            children: [
              Container(
                color: Colors.white10,
                height: MediaQuery.of(context).size.height / 4.5,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Card(
                        child: Column(
                          children: [
                            Container(
                              height: 165,
                              child: Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.menu_book,
                                      color: Colors.black,
                                    ),
                                    alignment: Alignment.topCenter,
                                    padding: new EdgeInsets.all(10.0),
                                    onPressed: () {},
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Center(
                                          child: Text(
                                              school1[SetUpState.answers[0]]
                                                  [0]))),
                                  Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Center(
                                          child: Text(
                                              school1[SetUpState.answers[0]]
                                                  [1]))),
                                  Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Center(
                                          child: Text(
                                              school1[SetUpState.answers[0]]
                                                  [2]))),
                                ],
                              ),
                            ),
                          ],
                        ),
                        elevation: 6,
                      ),
                    );
                  },
                ),
              ),
              Container(
                color: Colors.white10,
                height: MediaQuery.of(context).size.height / 4.5,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Card(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 165,
                              child: Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.school,
                                      color: Colors.black,
                                    ),
                                    alignment: Alignment.topCenter,
                                    padding: new EdgeInsets.all(10.0),
                                    onPressed: () {},
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Center(
                                          child: Text(
                                              school1[SetUpState.answers[1]]
                                                  [0]))),
                                  Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Center(
                                          child: Text(
                                              school1[SetUpState.answers[1]]
                                                  [1]))),
                                  Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Center(
                                          child: Text(
                                              school1[SetUpState.answers[1]]
                                                  [2]))),
                                ],
                              ),
                            ),
                          ],
                        ),
                        elevation: 5,
                      ),
                    );
                  },
                ),
              ),
              Container(
                color: Colors.white10,
                height: MediaQuery.of(context).size.height / 4.5,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Card(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 165,
                              child: Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.computer,
                                      color: Colors.black,
                                    ),
                                    alignment: Alignment.topCenter,
                                    padding: new EdgeInsets.all(10.0),
                                    onPressed: () {},
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Center(
                                          child: Text(
                                              school1[SetUpState.answers[2]]
                                                  [0]))),
                                  Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Center(
                                          child: Text(
                                              school1[SetUpState.answers[2]]
                                                  [1]))),
                                  Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Center(
                                          child: Text(
                                              school1[SetUpState.answers[2]]
                                                  [2]))),
                                ],
                              ),
                            ),
                          ],
                        ),
                        elevation: 6,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedFontSize: 15,
            // ignore: prefer_const_constructors
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            // ignore: prefer_const_constructors
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
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                label: 'Refresh',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.event,
                  color: Colors.white,
                ),
                label: 'Calendar',
              ),
            ],
          ),
        ));
  }
}
