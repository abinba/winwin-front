import 'package:flutter/material.dart';
import 'package:winwin/screens/applications.dart';
import 'package:winwin/screens/chats.dart';
import 'package:winwin/screens/matcher.dart';
import 'package:winwin/screens/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;

  static final List<Widget> _widgetOptions = <Widget>[
    ChatsScreen(),
    MatcherScreen(),
    ApplicationsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WinWin'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Matcher',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in),
            label: 'Applications',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigo,
        onTap: _onItemTapped,
      ),
      floatingActionButton: _buildFloatingActionButtons(),
    );
  }

  Widget? _buildFloatingActionButtons() {
    // Only return the FAB row when the selected index is 1 (Matcher page)
    if (_selectedIndex == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
            },
            child: Icon(Icons.close),
            backgroundColor: Colors.pink,
          ),
          FloatingActionButton(
            onPressed: () {
            },
            child: Icon(Icons.more_horiz),
            backgroundColor: Colors.grey,
          ),
          FloatingActionButton(
            onPressed: () {
            },
            child: Icon(Icons.check),
            backgroundColor: Colors.green,
          ),
        ],
      );
    } else {
      return null;
    }
  }
}

