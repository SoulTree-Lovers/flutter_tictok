import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final screens = [
    Center(
      child: Text('Home Screen'),
    ),
    Center(
      child: Text('Search Screen'),
    ),
    Center(
      child: Text('Search Screen'),
    ),
    Center(
      child: Text('Search Screen'),
    ),
    Center(
      child: Text('Search Screen'),
    ),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    print('Current Index: $_currentIndex');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: 'Home',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) => screens[index],
    );
  }
}
