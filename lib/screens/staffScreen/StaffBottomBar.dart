import 'package:example_menu/screens/staffScreen/StaffAddScreen.dart';
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
   OrdersScreen(),
    TableNumbers()
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
            icon: Icon(Icons.list_alt),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_bar),
            label: 'Page 4',
          ),
        ],
      ),
    );
  }
}

