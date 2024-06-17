import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:winwin/providers/match_engine_provider.dart';
import 'package:winwin/screens/candidate/applications.dart';
import 'package:winwin/screens/candidate/chats.dart';
import 'package:winwin/screens/candidate/matcher.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  List<Widget> _widgetOptions(BuildContext context) => [
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
              context.go('/profile');
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions(context).elementAt(_selectedIndex),
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
    final matchEngine = Provider.of<MatchEngineProvider>(context).matchEngine;

    if (_selectedIndex == 1) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'close',
              onPressed: () {
                matchEngine.currentItem?.nope();
              },
              child: Icon(Icons.close),
              backgroundColor: Colors.pink,
            ),
            FloatingActionButton(
              heroTag: 'more',
              onPressed: () {
                // Define your action for this button
              },
              child: Icon(Icons.more_horiz),
              backgroundColor: Colors.grey,
            ),
            FloatingActionButton(
              heroTag: 'check',
              onPressed: () {
                matchEngine.currentItem?.like();
              },
              child: Icon(Icons.check),
              backgroundColor: Colors.green,
            ),
          ],
        ),
      );
    } else {
      return null;
    }
  }
}