import 'package:flutter/material.dart';
import 'package:example_menu/GlobalVariable.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.labelText,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.controller,
    this.prefixText,
    this.keyboardType
  });
  final String? labelText;
  final Function(String)? onSubmitted;
  final Function()? onTap;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? prefixText;
  final TextInputType? keyboardType;


  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: TextField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixText: prefixText,
            labelText: labelText,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: secondaryColor,
                  width: 2,),
                borderRadius: const BorderRadius.all(Radius.circular(25))
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: mainColor,
                  width: 2,),
                borderRadius: const BorderRadius.all(Radius.circular(25))
            ),
          ),
          controller: controller,
          onTap: onTap,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
        )
    );
  }
}