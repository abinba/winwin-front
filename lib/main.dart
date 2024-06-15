import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winwin/data/datasource/job_position_remote_data_source.dart';
import 'package:winwin/data/repository/job_position_repository.dart';
import 'package:winwin/screens/applications.dart';
import 'package:winwin/screens/chats.dart';
import 'package:winwin/screens/matcher.dart';
import 'package:go_router/go_router.dart';
import 'package:winwin/routes.dart';
import 'package:winwin/services/network_info.dart';
import 'package:winwin/services/restclient.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => NetworkInfoImpl(),
        ),
        Provider(
          create: (context) => JobPositionRemoteDataSourceImpl(
            client: RestClient(env: "development"), // Provide your RestClient instance here
          ),
        ),
        Provider(
          create: (context) => JobPositionRepository(
            jobPositionRemoteDataSource: Provider.of(context, listen: false),
            networkInfo: Provider.of(context, listen: false),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'WinWin',
        routerConfig: router_configuration,
      ),
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
              context.go('/profile');
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
      return Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'close',
              onPressed: () {},
              child: Icon(Icons.close),
              backgroundColor: Colors.pink,
            ),
            FloatingActionButton(
              heroTag: 'more',
              onPressed: () {},
              child: Icon(Icons.more_horiz),
              backgroundColor: Colors.grey,
            ),
            FloatingActionButton(
              heroTag: 'check',
              onPressed: () {},
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
