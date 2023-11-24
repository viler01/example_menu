import 'package:flutter/material.dart';
import 'package:example_menu/GlobalVariable.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.labelText,
    this.onChanged,
    this.onTap,
    this.controller,
    this.prefixText,
    this.keyboardType,
    this.validator,
    this.obscureText
  });
  final String? labelText;
  final Function()? onTap;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? prefixText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool? obscureText;


  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: TextFormField(
          obscureText: obscureText != null ? obscureText! : false,
          validator: validator,
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

        )
    );
  }
}