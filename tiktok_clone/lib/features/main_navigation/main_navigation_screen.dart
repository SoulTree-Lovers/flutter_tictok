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
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _currentIndex,
        onDestinationSelected: _onTap,
        destinations: [
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.house,
              color: Colors.blue,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.amber,
            ),
            label: 'Search',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.house,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.house,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.house,
            ),
            label: 'Home',
          ),
        ],
      ),
    );
  }
}
