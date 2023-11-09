import 'package:flutter/material.dart';
import 'package:example_menu/GlobalVariable.dart';
import 'package:example_menu/models/food_model.dart';
import 'package:example_menu/models/language_model.dart';
import 'package:example_menu/widgets/GeneralWidget/CustomExpansionTile.dart';
import 'package:example_menu/widgets/GeneralWidget/MyBackground.dart';
import 'package:example_menu/widgets/costumersWidgets/FoodCardMenu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        title: Text(restourantName),
      ),


      drawer: Drawer(
        backgroundColor: secondaryColor,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for(var language in Language.languageList())ListTile(
                  leading: Text(language.flag),
                  title: Text(language.visualName),
                  onTap: (){
                    setState(() {
                      currentLanguage = language.name;
                    });
                    Navigator.pop(context);
                  },
                ),

                const Divider(color: Colors.black,),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Staff Login'),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/login");
                  },
                )
              ],
            ),
          ),
        ),
      ),


      body: CustomPaint(
        painter: MyBackground(),
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                for(var foodCategory in FoodCategory.values)CustomExpansionTile(
                    title: translateFodCategory(foodCategory: foodCategory),
                  children: [
                    for(var food in provaListaMenu)if(food.category == foodCategory)FoodCardMenu(food: food,)
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}