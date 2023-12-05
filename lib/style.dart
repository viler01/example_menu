import 'services/imports.dart';
import 'package:flutter/material.dart';

class AppStyle {
  static int primaryColorValue = 0xFFFFC700;
  static const double roundBorder = 10;

  static const double padding_horizontal = 30;
  static const double padding_vertical = 5;
  static Color primaryColor = Color(primaryColorValue);

  static MaterialColor primaryMaterialColor = MaterialColor(
    primaryColorValue,
    <int, Color>{
      50: primaryColor,
      100: primaryColor,
      200: primaryColor,
      300: primaryColor,
      400: primaryColor,
      500: primaryColor,
      600: primaryColor,
      700: primaryColor,
      800: primaryColor,
      900: primaryColor,
    },
  );

  ///TextStyle
  static TextStyle kHomeTitle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 50);
  static TextStyle kSentence = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black);

  ///InputDecoration
  InputDecoration kTextFieldDecoration(
          {required IconData icon, required String hintText}) =>
      InputDecoration(

        hintText: hintText,
        hintStyle: TextStyle(
        ),
        contentPadding: const EdgeInsets.symmetric(
            vertical: padding_vertical, horizontal: padding_horizontal),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(roundBorder)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color:Colors.black, width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(roundBorder)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(roundBorder)),
        ),
      );
  InputDecoration kTextFieldDecorationNoIcon({required String hintText}) =>
      InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black,
        ),
        contentPadding: const EdgeInsets.symmetric(
            vertical: padding_vertical, horizontal: padding_horizontal),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(roundBorder)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(roundBorder)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color:Colors.black, width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(roundBorder)),
        ),
      );

  ///ModalBottom
  static RoundedRectangleBorder kModalBottomStyle =
      const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)));
}
