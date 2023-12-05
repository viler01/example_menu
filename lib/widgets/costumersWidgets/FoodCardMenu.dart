import 'package:example_menu/models/allergen_model.dart';
import 'package:flutter/material.dart';
import 'package:example_menu/GlobalVariable.dart';
import 'package:example_menu/models/food_model.dart';
import 'package:example_menu/widgets/costumersWidgets/FoodAlertDialog.dart';
import 'package:example_menu/widgets/costumersWidgets/alleargenWidgets.dart';

class FoodCardMenu extends StatelessWidget {
  FoodCardMenu({
    required this.addFun,
    required this.subFun,
    required this.food,
    required this.quantity
  });
  final int? quantity;
  final Food food;
  final VoidCallback addFun;
  final VoidCallback subFun;

  double cardHeight = 150;
  double imageRadius = 60;
  
  @override
  Widget build(BuildContext context) {

    List<Allergens> allergenList = stringToAllergens(food.allergens);

    return Container(
      margin: const EdgeInsets.all(12),
      height: cardHeight,

      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(3, 3), // changes position of shadow
          ),
        ]
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            //food image
            CircleAvatar(
              radius: imageRadius,
              backgroundImage: NetworkImage(food.image),
            ),

            //food general information
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    translateFoodName(food: food, language: currentLanguage),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text("€${food.price}"),
                  AllergenRow(allergensList: allergenList)
                ],
              ),
            ),

            //action
            Column(
              children: [
                IconButton(
                    icon: const Icon(Icons.remove_red_eye_outlined),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => FoodAlertDialog(food: food,)
                    ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add_circle),
                      onPressed:addFun,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(quantity == null? '0' : quantity.toString()),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outlined),
                      onPressed:(){
                        if(quantity!>0 && quantity != null){

                          subFun();
                        }
                      },
                    ),
                  ],
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}
