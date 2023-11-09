import 'package:flutter/material.dart';
import 'package:example_menu/GlobalVariable.dart';

class CustomExpansionTile extends StatelessWidget {
  const CustomExpansionTile({
    super.key,
    required this.title,
    this.children = const [],
  });
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent, colorScheme: ColorScheme.fromSeed(seedColor: mainColor),),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
          ),
        ),
        children: children,
      ),
    );
  }
}