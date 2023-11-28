import 'package:example_menu/GlobalVariable.dart';
import 'package:example_menu/models/allergen_model.dart';
import 'package:example_menu/models/language_model.dart';

class Food{
  final String id;
  final String nameITA;
  final String nameENG;
  final double price;
  final FoodCategory category;
  final String image;
  final String descriptionITA;
  final String descriptionENG;
  final List<String> allergens;
  final bool active;

  Food({
    required this.id,
    required this.nameITA,
    required this.nameENG,
    required this.price,
    required this.category,
    required this.image,
    required this.descriptionITA,
    required this.descriptionENG,
    required this.allergens,
    required this.active,
  });

}

enum FoodCategory{
  aperitifs,
  appetizers,
  mainDishes,
  secondCourses,
  sideDishes,
  dessert,
  nonAlcoholic,
  beers,
  wines,
}


//traduzione del nome
String translateFoodName({required Food food, required LanguageName language}){
  switch(language){
    case LanguageName.eng:
      return food.nameENG;
    case LanguageName.ita:
      return food.nameITA;
  }
}


//traduzione della descrizione
String translateFoodDescription({required Food food, required LanguageName language}){
  switch(language){
    case LanguageName.eng:
      return food.descriptionENG;
    case LanguageName.ita:
      return food.descriptionITA;
  }
}


//Traduzione delle food categories
String translateFodCategory ({required FoodCategory foodCategory}){
  switch(currentLanguage){

    case LanguageName.eng:
      switch (foodCategory){

        case FoodCategory.aperitifs:
          return "Aperitifs";

        case FoodCategory.appetizers:
          return "Appetizers";

        case FoodCategory.mainDishes:
          return "Main Dishes";

        case FoodCategory.secondCourses:
          return "Second Courses";

        case FoodCategory.sideDishes:
          return "Side Dishes";

        case FoodCategory.dessert:
          return "Dessert";

        case FoodCategory.nonAlcoholic:
          return "Non Alcoholic";

        case FoodCategory.beers:
          return "Beers";

        case FoodCategory.wines:
          return "Wines";
      }

    case LanguageName.ita:
      switch (foodCategory){

        case FoodCategory.aperitifs:
          return "Aperitivi";

        case FoodCategory.appetizers:
          return "Antipasti";

        case FoodCategory.mainDishes:
          return "Primi piatti";

        case FoodCategory.secondCourses:
          return "Secondi piatti";

        case FoodCategory.sideDishes:
          return "Contorni";

        case FoodCategory.dessert:
          return "Dessert";

        case FoodCategory.nonAlcoholic:
          return "Analcolico";

        case FoodCategory.beers:
          return "Birre";

        case FoodCategory.wines:
          return "Vini";

      }
  }
}


List<Food> provaListaMenu = [
  Food(
    id: "1",
      nameITA: 'bistecca',
      nameENG: "Steak",
      price: 10,
      category: FoodCategory.secondCourses,
      image: "assets/food/steak.jpg",
      descriptionITA: "Tomahawk alla griglia con senape",
      descriptionENG: "Grilled tomahawk with mustard",
      allergens: ['Allergens.milk', 'Allergens.mustard'],
      active: true
  ),
];

List<Allergens> stringToAllergens( List<String>? stringList){

  List<Allergens> allergenList=[];

  if(stringList != null){
    for(var item in stringList){
      switch(item){
        case 'Allergens.peanuts':
          allergenList.add(Allergens.peanuts);
        case  'Allergens.nuts' :
          allergenList.add(Allergens.nuts);
        case 'Allergens.gluten'  :
          allergenList.add(Allergens.gluten);
        case 'Allergens.crustacen':
          allergenList.add(Allergens.crustacen);
        case 'Allergens.eggs'  :
          allergenList.add(Allergens.eggs);
        case 'Allergens.fish'  :
          allergenList.add(Allergens.fish);
        case  'Allergens.soya' :
          allergenList.add(Allergens.soya);
        case 'Allergens.milk'  :
          allergenList.add(Allergens.milk);
        case 'Allergens.celery'  :
          allergenList.add(Allergens.celery);
        case 'Allergens.mustard'  :
          allergenList.add(Allergens.mustard);
        case 'Allergens.sesame'  :
          allergenList.add(Allergens.sesame);
        case  ' Allergens.sulphite' :
          allergenList.add( Allergens.sulphite);
        case ' Allergens.lupins':
          allergenList.add( Allergens.lupins);
        case  'Allergens.shellfish' :
          allergenList.add(Allergens.shellfish);
      }
    }
  }
  return allergenList;
}