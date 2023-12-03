import 'package:example_menu/screens/staffScreen/StaffAddScreen.dart';
import 'package:example_menu/screens/staffScreen/StaffHomepage.dart';
import 'package:flutter/material.dart';
import '../../services/imports.dart';

class StaffBottomBar extends StatefulWidget {
  @override
  State<StaffBottomBar> createState() => _StaffBottomBarState();
}

class _StaffBottomBarState extends State<StaffBottomBar> {
  int _selectedIndex = 0;

  // List of pages for the body of the scaffold
  final List<Widget> pages = [
   StaffHomepage(),
    StaffAddScreen(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.greenAccent,
        selectedItemColor: Colors.green,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home Page',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Food',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pageview),
            label: 'Page 3',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pageview),
            label: 'Page 4',
          ),
        ],
      ),
    );
  }
}

