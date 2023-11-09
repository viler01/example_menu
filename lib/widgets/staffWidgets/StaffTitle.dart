import 'package:flutter/material.dart';
import 'package:example_menu/GlobalVariable.dart';

class StaffTitle extends StatelessWidget {
  const StaffTitle({
    super.key,
    this.title = "Title"
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(height: 60, color: mainColor,),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 45,
                color: mainColor
            ),
          ),
        ),

        Divider(height: 60, color: mainColor,),
      ],
    );
  }
}


