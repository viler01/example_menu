import 'package:flutter/material.dart';
import 'package:example_menu/GlobalVariable.dart';
import 'package:example_menu/RouteGenerator.dart';
import 'package:example_menu/models/language_model.dart';
import 'package:example_menu/screens/HomePage.dart';
import 'package:example_menu/screens/staffScreen/LoginScreen.dart';
import 'package:example_menu/screens/staffScreen/StaffAddScreen.dart';
import 'package:example_menu/screens/staffScreen/StaffHomepage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: mainColor
      ),
      home: HomePage(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}