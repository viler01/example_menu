import 'package:example_menu/GlobalVariable.dart';
import 'package:example_menu/models/language_model.dart';


import 'food_model.dart';

enum Allergens{
  fish,
  lupins,
  shellfish,
  eggs,
  milk,
  sulphite,
  gluten,
  soya,
  nuts,
  sesame,
  crustacen,
  mustard,
  peanuts,
  celery
}

class Allergen{
  final Allergens allergensType;
  final String svgDirectory;

  Allergen({required this.allergensType, required this.svgDirectory});

  static List<Allergen> returnAllergen(List<Allergens> idAllergens){
    List<Allergen> allergens = [];
      for(var idAllergen in idAllergens){
        switch (idAllergen){
          case Allergens.peanuts:
            allergens.add(Allergen(
                allergensType: Allergens.peanuts,
                svgDirectory: 'assets/allergens/arachidi.svg'));
            break;
          case Allergens.nuts:
            allergens.add(Allergen(
                allergensType: Allergens.nuts,
                svgDirectory: 'assets/allergens/frutta_a_guscio.svg'));
            break;
          case Allergens.gluten:
            allergens.add(Allergen(
                allergensType: Allergens.gluten,
                svgDirectory: 'assets/allergens/glutine.svg'));
            break;
          case Allergens.crustacen:
            allergens.add(Allergen(
                allergensType: Allergens.crustacen,
                svgDirectory: 'assets/allergens/crostacei.svg'));
            break;
          case Allergens.eggs:
            allergens.add(Allergen(
                allergensType: Allergens.eggs,
                svgDirectory: 'assets/allergens/uova.svg'));
            break;
          case Allergens.fish:
            allergens.add(Allergen(
                allergensType: Allergens.fish,
                svgDirectory: 'assets/allergens/pesce.svg'));
            break;
          case Allergens.soya:
            allergens.add(Allergen(
                allergensType: Allergens.soya,
                svgDirectory: 'assets/allergens/soia.svg'));
            break;
          case Allergens.milk:
            allergens.add(Allergen(
                allergensType: Allergens.milk,
                svgDirectory: 'assets/allergens/latte.svg'));
            break;
          case Allergens.celery:
            allergens.add(Allergen(
                allergensType: Allergens.celery,
                svgDirectory: 'assets/allergens/sedano.svg'));
            break;
          case Allergens.mustard:
            allergens.add(Allergen(
                allergensType: Allergens.mustard,
                svgDirectory: 'assets/allergens/senape.svg'));
            break;
          case Allergens.sesame:
            allergens.add(Allergen(
                allergensType: Allergens.sesame,
                svgDirectory: 'assets/allergens/sesamo.svg'));
            break;
          case Allergens.sulphite:
            allergens.add(Allergen(
                allergensType: Allergens.sulphite,
                svgDirectory: 'assets/allergens/solfiti.svg'));
            break;
          case Allergens.lupins:
            allergens.add(Allergen(
                allergensType: Allergens.lupins,
                svgDirectory: 'assets/allergens/lupini.svg'));
            break;
          case Allergens.shellfish:
            allergens.add(Allergen(
                allergensType: Allergens.shellfish,
                svgDirectory: 'assets/allergens/molluschi.svg'));
            break;
        }
      }

     return allergens;
  }
}

String translateAllergen(Allergen allergen){
  switch(currentLanguage){
    case LanguageName.eng:
      switch(allergen.allergensType){
        case Allergens.shellfish:
          return "Shellfish";
        case Allergens.peanuts:
          return "Peanuts";
        case Allergens.fish:
          return "Fish";
        case Allergens.mustard:
          return "Mustard";
        case Allergens.milk:
          return "Milk";
        case Allergens.sulphite:
          return "Sulphite";
        case Allergens.crustacen:
          return "Crustacen";
        case Allergens.lupins:
          return "Lupins";
        case Allergens.sesame:
          return "Sesame";
        case Allergens.soya:
          return "Soya";
        case Allergens.eggs:
          return "Eggs";
        case Allergens.nuts:
          return "Nuts";
        case Allergens.gluten:
          return "Gluten";
        case Allergens.celery:
          return "Celery";
      }
    case LanguageName.ita:
      switch(allergen.allergensType){
        case Allergens.shellfish:
          return "Molluschi";
        case Allergens.peanuts:
          return "Arachidi";
        case Allergens.fish:
          return "Pesce";
        case Allergens.mustard:
          return "Senape";
        case Allergens.milk:
          return "Latte";
        case Allergens.sulphite:
          return "Solfiti";
        case Allergens.crustacen:
          return "Crostacei";
        case Allergens.lupins:
          return "Lupini";
        case Allergens.sesame:
          return "Sesamo";
        case Allergens.soya:
          return "Soia";
        case Allergens.eggs:
          return "Uova";
        case Allergens.nuts:
          return "Frutta a guscio";
        case Allergens.gluten:
          return "Glutine";
        case Allergens.celery:
          return "Sedano";
      }
  }
}