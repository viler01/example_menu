import 'package:flutter/material.dart';
import 'package:example_menu/models/food_model.dart';
import 'package:example_menu/models/language_model.dart';

class StaffActiveFoodCard extends StatefulWidget {
  const StaffActiveFoodCard({
    super.key,
    required this.food,
    required this.onChanged,
  });
  final Food food;
  final Function(bool) onChanged;

  @override
  State<StaffActiveFoodCard> createState() => _StaffActiveFoodCardState();
}

class _StaffActiveFoodCardState extends State<StaffActiveFoodCard> {
  bool active = false;

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
            value: active,
            onChanged: (value){
              setState(() {
                active = value;
              });
              widget.onChanged(value);
            }),
        trailing: IconButton(
            onPressed: (){},
            icon: const Icon(Icons.mode)
        ),

    );
  }
}
