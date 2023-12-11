import 'package:flutter/material.dart';
import 'package:example_menu/models/language_model.dart';
import 'services/imports.dart';

var currentLanguage = LanguageName.ita;

const String restourantName = "Al calderone di zia lucia";
const String restourantLogo = "assets/restaurant/restourantLogo.png";

//COLORI
//Colori principali
Color mainColor = Colors.teal;
Color secondaryColor = Colors.teal.shade100;
Color selectedColor = Colors.teal.shade300;
//Colori background
Color backgroundColor = Colors.white;
Color bigCircleBG = Colors.teal.shade50;
Color smallCircleBG = Colors.black12;

//LAYOUT
const double horizontalLayout = 850;

//TEXT STYLE
TextStyle addTextStile = TextStyle(fontWeight: FontWeight.bold, color: mainColor, fontSize: 20);

///funzione che elimina tutti i documenti di una collecttion

Future<void> deleteCollection(String collectionPath) async {
  final collectionReference = FirebaseFirestore.instance.collection(collectionPath);
  final querySnapshot = await collectionReference.get();

  for (final documentSnapshot in querySnapshot.docs) {
    await documentSnapshot.reference.delete();
  }
}

//TODO: da eliminare

//TextStyles
TextStyle kAccountTextStyle =
TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: kPrimaryColor);
TextStyle kNiceTextStyle =
TextStyle(fontSize: 18, color: kHighlightedTextColor);
TextStyle kFoodTitleTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 30,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none);

TextStyle kFoodTitleClientTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none);

TextStyle kFoodTitleUserTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none);

//colors

Color kbackgroundRequest = const Color.fromRGBO(255,255,255,0.9);
Color kBackgroundColor = Color(0xFF24293E);
Color kAccentColor = Color(0xFF8EBBFF);
Color kBoxColor = Color(0xFF2F3651);
Color kTextColor = Colors.white;
Color kHighlightedTextColor = Colors.tealAccent;
Color kPrimaryColor = Color.fromRGBO(219, 1, 1, 1);
Color kLightPrimaryColor = Color.fromRGBO(219, 1, 1, 0.2);
