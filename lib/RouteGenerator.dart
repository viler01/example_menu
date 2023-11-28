import 'package:example_menu/screens/staffScreen/StaffAddScreen.dart';
import 'package:flutter/material.dart';
import 'package:example_menu/screens/HomePage.dart';
import 'package:example_menu/screens/staffScreen/LoginScreen.dart';
import 'package:example_menu/screens/staffScreen/StaffEditScreen.dart';
import 'package:example_menu/screens/staffScreen/StaffHomepage.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name){
      case "/":
        return MaterialPageRoute(builder: (context) => HomePage());
      case "/login":
        return MaterialPageRoute(builder: (context) => LoginScreen());
     /* case "/staffAddScreen":
        return MaterialPageRoute(builder: (context) => StaffEditScreen());*/
      case "/staffHomePage":
        return MaterialPageRoute(builder: (context) => StaffHomepage());
      case "/staffAddScreen":
        return MaterialPageRoute(builder: (context) => StaffAddScreen());
      default:
        return MaterialPageRoute(builder: (context) => HomePage());

    }
  }
}