import 'package:flutter/material.dart';
import 'package:example_menu/GlobalVariable.dart';

class StaffBottomBar extends StatelessWidget {
  const StaffBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: mainColor,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.list),
                onPressed: (){
                  Navigator.pushNamed(context, "/staffHomePage");
                },
              ),
              const Text('Menù')
            ],
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: (){
                  Navigator.pushNamed(context, "/staffAddScreen");
                },
              ),
              const Text('Aggiungi piatto')
            ],
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: (){
                  Navigator.pushNamed(context, "/");
                },
              ),
              const Text('Logout')
            ],
          ),
        ],
      ),
    );
  }
}
