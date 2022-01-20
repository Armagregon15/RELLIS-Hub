// always us to use material design
import 'package:flutter/material.dart';
// this will import the added library to include the post.
//import 'package:stream_feed/stream_feed.dart';
//generates words used in guidance on youtube might not need at all for project
import 'package:english_words/english_words.dart';

//List view taken from flutter docs @ https://api.flutter.dev/flutter/widgets/ListView-class.html
class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  FeedState createState() => FeedState();
}

//List view taken from flutter docs @ https://api.flutter.dev/flutter/widgets/ListView-class.html
class FeedState extends State<Feed> {
  //final _uniquePosts = <Posts>[];
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item) {
        if (item.isOdd) return Divider();

        final index = item ~/ 2;

        if (index >= _randomWordPairs.length) {
          _randomWordPairs.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_randomWordPairs[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWordPairs.contains(pair);
    return ListTile(
        title: Text(pair.asPascalCase, style: TextStyle(fontSize: 18.0)),
        trailing: Icon(
            alreadySaved
                ? Icons.favorite
                : Icons
                    .favorite_border, //this is a if else statement if unsaved then have red and if saved then color red
            color: alreadySaved ? Colors.red : null),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _savedWordPairs.remove(pair);
            } else {
              _savedWordPairs.add(pair);
            }
          });
        });
  }

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext) {
      final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
        return ListTile(
            title: Text(pair.asPascalCase, style: TextStyle(fontSize: 16.0)));
      });
      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
          appBar: AppBar(title: Text("Saved WordPairs")),
          body: ListView(children: divided));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('RELLIS HUB'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
          ],
        ),
        body: _buildList());
  }
}

/*
// always us to use material design
import 'package:flutter/material.dart';
// this will import the added library to include the post.
//import 'package:stream_feed/stream_feed.dart';
//this will make the file that holds the random word functions
import './random_words.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.red), home: const Feed());
  }
}
*/
/*import 'package:flutter/material.dart';
import 'HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginHub(),
    );
  }
}

class LoginHub extends StatefulWidget {
  @override
  _LoginHubState createState() => _LoginHubState();
}

class _LoginHubState extends State<LoginHub> {
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
                        child: Image.asset('Put image of logo HERE')),
                  ),
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
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
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => HomePage()));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(
                  height: 130,
                ),
                Text('New User? Create Account')
              ],
            ),
          ),
        ));
  }
} */

/*import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Container(
          height: 80,
          width: 150,
          decoration: BoxDecoration(
              color: Color(0xFF500000),
              borderRadius: BorderRadius.circular(10)),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Welcome',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }
} */

//this is josephs code

/*
import 'package:flutter/material.dart';

void main() => runApp(MainPage());

class MainPage extends StatefulWidget {
  HomePage createState() => HomePage();
}

class HomePage extends State<MainPage> {
  int _selectedIndex = 0;

  List<String> school1 = [
    'Commerce',
    ' Pizza Party',
    'November 8th',
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
        title: 'Welcome to Flutter',
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: const Color(0xFF500000),
            title: const Text('The Hub @ Rellis'),
          ),
          body: Container(
            color: Colors.white10,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                // var j = 0;
                // for (var i = 0; i < school1.length; ++i) {
                //  j = j + 1;
                // }

                return Center(
                  child: Card(
                    child: Column(
                      children: [
                        Container(
                          height: 165,
                          child: Column(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.star,
                                  color: Colors.black,
                                ),
                                alignment: Alignment.topCenter,
                                padding: new EdgeInsets.all(10.0),
                                onPressed: () {},
                              ),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Center(child: Text(school1[0]))),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Center(child: Text(school1[1]))),
                              Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Center(child: Text(school1[2]))),
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
*/
