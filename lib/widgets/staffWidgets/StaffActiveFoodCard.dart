import 'package:flutter/material.dart';
import 'package:example_menu/models/food_model.dart';
import 'package:example_menu/models/language_model.dart';

class StaffActiveFoodCard extends StatefulWidget {
  const StaffActiveFoodCard({
    super.key,
    required this.food,
    required this.active,
    required this.edit
  });
  final Food food;
  final Function(bool) active;
  final VoidCallback edit;

  @override
  State<StaffActiveFoodCard> createState() => _StaffActiveFoodCardState();
}

class _StaffActiveFoodCardState extends State<StaffActiveFoodCard> {


  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          translateFoodName(food: widget.food, language: LanguageName.ita),
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text(
            "€${widget.food.price.toString()}"
        ),
        leading: Switch(
            value: widget.food.active,
            onChanged: widget.active
        ),
        trailing: IconButton(
            onPressed: widget.edit,
            icon: const Icon(Icons.mode)
        ),

    );
  }
}
