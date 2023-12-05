import 'package:example_menu/models/allergen_model.dart';
import 'package:flutter/material.dart';
import 'package:example_menu/GlobalVariable.dart';
import 'package:example_menu/models/food_model.dart';
import 'package:example_menu/widgets/costumersWidgets/alleargenWidgets.dart';

class FoodAlertDialog extends StatelessWidget {
  const FoodAlertDialog({
    super.key,
    required this.food,
  });

  final Food food;

  @override
  Widget build(BuildContext context) {

    List<Allergens> allergenList = stringToAllergens(food.allergens);

    return AlertDialog(
      title: Text(translateFoodName(food: food, language: currentLanguage)),
      content: SingleChildScrollView(
        child: Column(
          children: [
            CircleAvatar(
              radius: 90,
              backgroundImage: NetworkImage(food.image),
            ),
            const SizedBox(height: 30,),
            Text(translateFoodDescription(food: food, language: currentLanguage)),
            const SizedBox(height: 30,),
            AllergenColumn(allergensList: allergenList),
          ]
        ),
      ),
      actions: [
        TextButton(
            onPressed: (){Navigator.pop(context);},
            child: const Text('chiudi')
        )
      ],
    );
  }
}
