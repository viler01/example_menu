import '../imports.dart';

class DatabaseFood {
  static CollectionReference<Map<String, dynamic>> foodCollection =
      FirebaseFirestore.instance.collection('foods');

  static CollectionReference<Map<String, dynamic>> foodCollection2 =
  FirebaseFirestore.instance.collection('foods');

  static CollectionReference<Map<String, dynamic>> foodCollection3 =
  FirebaseFirestore.instance.collection('foods');

  Future deleteFood({required String foodID}) async{
   await  foodCollection.doc(foodID).delete();
   return;
}

  Future createEdit({required Food food, required bool isEdit}) async {
    return isEdit
        ? await foodCollection.doc(food.id).update({
            'type' : food.type,
            'allergens' :food.allergens,
            'nameITA': food.nameITA,
            'active': food.active,
            'id': food.id,
            'category': food.category.toString(),
            'price': food.price,
            'image': food.image,
            'descriptionITA': food.descriptionITA,
            'descriptionENG': food.descriptionENG,
            'nameENG': food.nameENG
          })
        : await foodCollection.doc(food.id).set({
           'type' : food.type,
           'allergens' :food.allergens,
           'nameITA': food.nameITA,
           'active': food.active,
           'id': food.id,
           'category': food.category.toString(),
           'price': food.price,
           'image': food.image,
           'descriptionITA': food.descriptionITA,
           'descriptionENG': food.descriptionENG,
           'nameENG': food.nameENG
          });
  }

  static Food? foodFromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    switch (snapshot.data()?['category']) {
      case 'FoodCategory.aperitifs':
        return Food(
          type:snapshot.data()?['type'] ?? "",
          allergens: snapshot.data()?['allergens'] != null
              ? (snapshot.data()?['allergens'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          nameITA: snapshot.data()?['nameITA'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          category: FoodCategory.aperitifs,
          image: snapshot.data()?['image'] ?? "",
          nameENG: snapshot.data()?['nameENG'] ?? "",
          descriptionITA: snapshot.data()?['descriptionITA'] ?? "",
          descriptionENG: snapshot.data()?['descriptionENG'] ?? "",
        );
      case 'FoodCategory.appetizers':
        return Food(
          type:snapshot.data()?['type'] ?? "",
          allergens: snapshot.data()?['allergens'] != null
              ? (snapshot.data()?['allergens'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          nameITA: snapshot.data()?['nameITA'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          category: FoodCategory.appetizers,
          image: snapshot.data()?['image'] ?? "",
          nameENG: snapshot.data()?['nameENG'] ?? "",
          descriptionITA: snapshot.data()?['descriptionITA'] ?? "",
          descriptionENG: snapshot.data()?['descriptionENG'] ?? "",
        );
      case 'FoodCategory.mainDishes':
        return Food(
          type:snapshot.data()?['type'] ?? "",
          allergens: snapshot.data()?['allergens'] != null
              ? (snapshot.data()?['allergens'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          nameITA: snapshot.data()?['nameITA'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          category: FoodCategory.mainDishes,
          image: snapshot.data()?['image'] ?? "",
          nameENG: snapshot.data()?['nameENG'] ?? "",
          descriptionITA: snapshot.data()?['descriptionITA'] ?? "",
          descriptionENG: snapshot.data()?['descriptionENG'] ?? "",
        );
      case 'FoodCategory.secondCourses':
        return Food(
          type:snapshot.data()?['type'] ?? "",
          allergens: snapshot.data()?['allergens'] != null
              ? (snapshot.data()?['allergens'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          nameITA: snapshot.data()?['nameITA'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          category: FoodCategory.secondCourses,
          image: snapshot.data()?['image'] ?? "",
          nameENG: snapshot.data()?['nameENG'] ?? "",
          descriptionITA: snapshot.data()?['descriptionITA'] ?? "",
          descriptionENG: snapshot.data()?['descriptionENG'] ?? "",
        );
      case 'FoodCategory.sideDishes':
        return Food(
          type:snapshot.data()?['type'] ?? "",
          allergens: snapshot.data()?['allergens'] != null
              ? (snapshot.data()?['allergens'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          nameITA: snapshot.data()?['nameITA'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          category: FoodCategory.sideDishes,
          image: snapshot.data()?['image'] ?? "",
          nameENG: snapshot.data()?['nameENG'] ?? "",
          descriptionITA: snapshot.data()?['descriptionITA'] ?? "",
          descriptionENG: snapshot.data()?['descriptionENG'] ?? "",
        );
      case 'FoodCategory.dessert':
        return Food(
          type:snapshot.data()?['type'] ?? "",
          allergens: snapshot.data()?['allergens'] != null
              ? (snapshot.data()?['allergens'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          nameITA: snapshot.data()?['nameITA'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          category: FoodCategory.dessert,
          image: snapshot.data()?['image'] ?? "",
          nameENG: snapshot.data()?['nameENG'] ?? "",
          descriptionITA: snapshot.data()?['descriptionITA'] ?? "",
          descriptionENG: snapshot.data()?['descriptionENG'] ?? "",
        );
      case 'FoodCategory.beers':
        return Food(
          type:snapshot.data()?['type'] ?? "",
          allergens: snapshot.data()?['allergens'] != null
              ? (snapshot.data()?['allergens'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          nameITA: snapshot.data()?['nameITA'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          category: FoodCategory.beers,
          image: snapshot.data()?['image'] ?? "",
          nameENG: snapshot.data()?['nameENG'] ?? "",
          descriptionITA: snapshot.data()?['descriptionITA'] ?? "",
          descriptionENG: snapshot.data()?['descriptionENG'] ?? "",
        );
      case 'FoodCategory.nonAlcoholic':
        return Food(
          type:snapshot.data()?['type'] ?? "",
          allergens: snapshot.data()?['allergens'] != null
              ? (snapshot.data()?['allergens'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          nameITA: snapshot.data()?['nameITA'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          category: FoodCategory.nonAlcoholic,
          image: snapshot.data()?['image'] ?? "",
          nameENG: snapshot.data()?['nameENG'] ?? "",
          descriptionITA: snapshot.data()?['descriptionITA'] ?? "",
          descriptionENG: snapshot.data()?['descriptionENG'] ?? "",
        );
      case 'FoodCategory.wines':
        return Food(
          type:snapshot.data()?['type'] ?? "",
          allergens: snapshot.data()?['allergens'] != null
              ? (snapshot.data()?['allergens'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          nameITA: snapshot.data()?['nameITA'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          category: FoodCategory.wines,
          image: snapshot.data()?['image'] ?? "",
          nameENG: snapshot.data()?['nameENG'] ?? "",
          descriptionITA: snapshot.data()?['descriptionITA'] ?? "",
          descriptionENG: snapshot.data()?['descriptionENG'] ?? "",
        );

    }
  }

  static Food? foodFromSnapshot2(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    switch (snapshot.data()?['category']) {
      case 'FoodCategory.aperitifs':
        return Food(
          type:snapshot.data()?['type'] ?? "",
          allergens: snapshot.data()?['allergens'] != null
              ? (snapshot.data()?['allergens'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          nameITA: snapshot.data()?['nameITA'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          category: FoodCategory.aperitifs,
          image: snapshot.data()?['image'] ?? "",
          nameENG: snapshot.data()?['nameENG'] ?? "",
          descriptionITA: snapshot.data()?['descriptionITA'] ?? "",
          descriptionENG: snapshot.data()?['descriptionENG'] ?? "",
        );
      case 'FoodCategory.appetizers':
        return Food(
          type:snapshot.data()?['type'] ?? "",
          allergens: snapshot.data()?['allergens'] != null
              ? (snapshot.data()?['allergens'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          nameITA: snapshot.data()?['nameITA'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          category: FoodCategory.appetizers,
          image: snapshot.data()?['image'] ?? "",
          nameENG: snapshot.data()?['nameENG'] ?? "",
          descriptionITA: snapshot.data()?['descriptionITA'] ?? "",
          descriptionENG: snapshot.data()?['descriptionENG'] ?? "",
        );
      case 'FoodCategory.mainDishes':
        return Food(
          type:snapshot.data()?['type'] ?? "",
          allergens: snapshot.data()?['allergens'] != null
              ? (snapshot.data()?['allergens'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          nameITA: snapshot.data()?['nameITA'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          category: FoodCategory.mainDishes,
          image: snapshot.data()?['image'] ?? "",
          nameENG: snapshot.data()?['nameENG'] ?? "",
          descriptionITA: snapshot.data()?['descriptionITA'] ?? "",
          descriptionENG: snapshot.data()?['descriptionENG'] ?? "",
        );
      case 'FoodCategory.secondCourses':
        return Food(
          type:snapshot.data()?['type'] ?? "",
          allergens: snapshot.data()?['allergens'] != null
              ? (snapshot.data()?['allergens'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          nameITA: snapshot.data()?['nameITA'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          category: FoodCategory.secondCourses,
          image: snapshot.data()?['image'] ?? "",
          nameENG: snapshot.data()?['nameENG'] ?? "",
          descriptionITA: snapshot.data()?['descriptionITA'] ?? "",
          descriptionENG: snapshot.data()?['descriptionENG'] ?? "",
        );
      case 'FoodCategory.sideDishes':
        return Food(
          type:snapshot.data()?['type'] ?? "",
          allergens: snapshot.data()?['allergens'] != null
              ? (snapshot.data()?['allergens'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          nameITA: snapshot.data()?['nameITA'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          category: FoodCategory.sideDishes,
          image: snapshot.data()?['image'] ?? "",
          nameENG: snapshot.data()?['nameENG'] ?? "",
          descriptionITA: snapshot.data()?['descriptionITA'] ?? "",
          descriptionENG: snapshot.data()?['descriptionENG'] ?? "",
        );
      case 'FoodCategory.dessert':
        return Food(
          type:snapshot.data()?['type'] ?? "",
          allergens: snapshot.data()?['allergens'] != null
              ? (snapshot.data()?['allergens'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          nameITA: snapshot.data()?['nameITA'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          category: FoodCategory.dessert,
          image: snapshot.data()?['image'] ?? "",
          nameENG: snapshot.data()?['nameENG'] ?? "",
          descriptionITA: snapshot.data()?['descriptionITA'] ?? "",
          descriptionENG: snapshot.data()?['descriptionENG'] ?? "",
        );
      case 'FoodCategory.beers':
        return Food(
          type:snapshot.data()?['type'] ?? "",
          allergens: snapshot.data()?['allergens'] != null
              ? (snapshot.data()?['allergens'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          nameITA: snapshot.data()?['nameITA'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          category: FoodCategory.beers,
          image: snapshot.data()?['image'] ?? "",
          nameENG: snapshot.data()?['nameENG'] ?? "",
          descriptionITA: snapshot.data()?['descriptionITA'] ?? "",
          descriptionENG: snapshot.data()?['descriptionENG'] ?? "",
        );
      case 'FoodCategory.nonAlcoholic':
        return Food(
          type:snapshot.data()?['type'] ?? "",
          allergens: snapshot.data()?['allergens'] != null
              ? (snapshot.data()?['allergens'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          nameITA: snapshot.data()?['nameITA'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          category: FoodCategory.nonAlcoholic,
          image: snapshot.data()?['image'] ?? "",
          nameENG: snapshot.data()?['nameENG'] ?? "",
          descriptionITA: snapshot.data()?['descriptionITA'] ?? "",
          descriptionENG: snapshot.data()?['descriptionENG'] ?? "",
        );
      case 'FoodCategory.wines':
        return Food(
          type:snapshot.data()?['type'] ?? "",
          allergens: snapshot.data()?['allergens'] != null
              ? (snapshot.data()?['allergens'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          nameITA: snapshot.data()?['nameITA'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          category: FoodCategory.wines,
          image: snapshot.data()?['image'] ?? "",
          nameENG: snapshot.data()?['nameENG'] ?? "",
          descriptionITA: snapshot.data()?['descriptionITA'] ?? "",
          descriptionENG: snapshot.data()?['descriptionENG'] ?? "",
        );

    }
  }

  List<Food?> getAllFood(){

    List<Food?> allFood = [];

    foodCollection.get().then(
          (querySnapshot) {

        for (var snapshot in querySnapshot.docs) {

          switch (snapshot.data()['category']) {
            case 'FoodCategory.aperitifs':
              Food food =  Food(
                type:snapshot.data()['type'] ?? "",
                allergens: snapshot.data()['allergens'] != null
                    ? (snapshot.data()['allergens'] as List)
                    .map((item) => item as String)
                    .toList()
                    : [],
                active: snapshot.data()['active'] ?? false,
                nameITA: snapshot.data()['nameITA'] ?? "",
                price: snapshot.data()['price'] ?? 0,
                id: snapshot.data()['id'] ?? "",
                category: FoodCategory.aperitifs,
                image: snapshot.data()['image'] ?? "",
                nameENG: snapshot.data()['nameENG'] ?? "",
                descriptionITA: snapshot.data()['descriptionITA'] ?? "",
                descriptionENG: snapshot.data()['descriptionENG'] ?? "",
              );
              allFood.add(food);

            case 'FoodCategory.appetizers':
              Food food =  Food(
                type:snapshot.data()['type'] ?? "",
                allergens: snapshot.data()['allergens'] != null
                    ? (snapshot.data()['allergens'] as List)
                    .map((item) => item as String)
                    .toList()
                    : [],
                active: snapshot.data()['active'] ?? false,
                nameITA: snapshot.data()['nameITA'] ?? "",
                price: snapshot.data()['price'] ?? 0,
                id: snapshot.data()['id'] ?? "",
                category: FoodCategory.appetizers,
                image: snapshot.data()['image'] ?? "",
                nameENG: snapshot.data()['nameENG'] ?? "",
                descriptionITA: snapshot.data()['descriptionITA'] ?? "",
                descriptionENG: snapshot.data()['descriptionENG'] ?? "",
              );
              allFood.add(food);
            case 'FoodCategory.mainDishes':
              Food food =Food(
                type:snapshot.data()['type'] ?? "",
                allergens: snapshot.data()['allergens'] != null
                    ? (snapshot.data()['allergens'] as List)
                    .map((item) => item as String)
                    .toList()
                    : [],
                active: snapshot.data()['active'] ?? false,
                nameITA: snapshot.data()['nameITA'] ?? "",
                price: snapshot.data()['price'] ?? 0,
                id: snapshot.data()['id'] ?? "",
                category: FoodCategory.mainDishes,
                image: snapshot.data()['image'] ?? "",
                nameENG: snapshot.data()['nameENG'] ?? "",
                descriptionITA: snapshot.data()['descriptionITA'] ?? "",
                descriptionENG: snapshot.data()['descriptionENG'] ?? "",
              );
              allFood.add(food);
            case 'FoodCategory.secondCourses':
              Food food = Food(
                type:snapshot.data()['type'] ?? "",
                allergens: snapshot.data()['allergens'] != null
                    ? (snapshot.data()['allergens'] as List)
                    .map((item) => item as String)
                    .toList()
                    : [],
                active: snapshot.data()['active'] ?? false,
                nameITA: snapshot.data()['nameITA'] ?? "",
                price: snapshot.data()['price'] ?? 0,
                id: snapshot.data()['id'] ?? "",
                category: FoodCategory.secondCourses,
                image: snapshot.data()['image'] ?? "",
                nameENG: snapshot.data()['nameENG'] ?? "",
                descriptionITA: snapshot.data()['descriptionITA'] ?? "",
                descriptionENG: snapshot.data()['descriptionENG'] ?? "",
              );
              allFood.add(food);
            case 'FoodCategory.sideDishes':
              Food food = Food(
                type:snapshot.data()['type'] ?? "",
                allergens: snapshot.data()['allergens'] != null
                    ? (snapshot.data()['allergens'] as List)
                    .map((item) => item as String)
                    .toList()
                    : [],
                active: snapshot.data()['active'] ?? false,
                nameITA: snapshot.data()['nameITA'] ?? "",
                price: snapshot.data()['price'] ?? 0,
                id: snapshot.data()['id'] ?? "",
                category: FoodCategory.sideDishes,
                image: snapshot.data()['image'] ?? "",
                nameENG: snapshot.data()['nameENG'] ?? "",
                descriptionITA: snapshot.data()['descriptionITA'] ?? "",
                descriptionENG: snapshot.data()['descriptionENG'] ?? "",
              );
              allFood.add(food);
            case 'FoodCategory.dessert':
             Food food = Food(
               type:snapshot.data()['type'] ?? "",
               allergens: snapshot.data()['allergens'] != null
                    ? (snapshot.data()['allergens'] as List)
                    .map((item) => item as String)
                    .toList()
                    : [],
                active: snapshot.data()['active'] ?? false,
                nameITA: snapshot.data()['nameITA'] ?? "",
                price: snapshot.data()['price'] ?? 0,
                id: snapshot.data()['id'] ?? "",
                category: FoodCategory.dessert,
                image: snapshot.data()['image'] ?? "",
                nameENG: snapshot.data()['nameENG'] ?? "",
                descriptionITA: snapshot.data()['descriptionITA'] ?? "",
                descriptionENG: snapshot.data()['descriptionENG'] ?? "",
              );
             allFood.add(food);
            case 'FoodCategory.beers':
              Food food = Food(
                type:snapshot.data()['type'] ?? "",
                allergens: snapshot.data()['allergens'] != null
                    ? (snapshot.data()['allergens'] as List)
                    .map((item) => item as String)
                    .toList()
                    : [],
                active: snapshot.data()['active'] ?? false,
                nameITA: snapshot.data()['nameITA'] ?? "",
                price: snapshot.data()['price'] ?? 0,
                id: snapshot.data()['id'] ?? "",
                category: FoodCategory.beers,
                image: snapshot.data()['image'] ?? "",
                nameENG: snapshot.data()['nameENG'] ?? "",
                descriptionITA: snapshot.data()['descriptionITA'] ?? "",
                descriptionENG: snapshot.data()['descriptionENG'] ?? "",
              );
              allFood.add(food);
            case 'FoodCategory.nonAlcoholic':
              Food food = Food(
                type: snapshot.data()['type'] ?? "",
                allergens: snapshot.data()['allergens'] != null
                    ? (snapshot.data()['allergens'] as List)
                    .map((item) => item as String)
                    .toList()
                    : [],
                active: snapshot.data()['active'] ?? false,
                nameITA: snapshot.data()['nameITA'] ?? "",
                price: snapshot.data()['price'] ?? 0,
                id: snapshot.data()['id'] ?? "",
                category: FoodCategory.nonAlcoholic,
                image: snapshot.data()['image'] ?? "",
                nameENG: snapshot.data()['nameENG'] ?? "",
                descriptionITA: snapshot.data()['descriptionITA'] ?? "",
                descriptionENG: snapshot.data()['descriptionENG'] ?? "",
              );
              allFood.add(food);
            case 'FoodCategory.wines':
            Food food =  Food(
              type: snapshot.data()['type'] ?? "",
                allergens: snapshot.data()['allergens'] != null
                    ? (snapshot.data()['allergens'] as List)
                    .map((item) => item as String)
                    .toList()
                    : [],
                active: snapshot.data()['active'] ?? false,
                nameITA: snapshot.data()['nameITA'] ?? "",
                price: snapshot.data()['price'] ?? 0,
                id: snapshot.data()['id'] ?? "",
                category: FoodCategory.wines,
                image: snapshot.data()['image'] ?? "",
                nameENG: snapshot.data()['nameENG'] ?? "",
                descriptionITA: snapshot.data()['descriptionITA'] ?? "",
                descriptionENG: snapshot.data()['descriptionENG'] ?? "",
              );
            allFood.add(food);

          }

        }
        return allFood;
      },
      onError: (e) => print("Error completing: $e"),
    );
    return [];
  }


  Stream<Food?> singleFood({required String id}) =>
      foodCollection.doc(id).snapshots().map(foodFromSnapshot);

  static List<Food?> foodListFromSnapshot(
          QuerySnapshot<Map<String, dynamic>> snapshot) =>
      snapshot.docs.map((snapshot) => foodFromSnapshot(snapshot)).toList();

  static Stream<List<Food?>> get allFood =>
      foodCollection.snapshots().map(foodListFromSnapshot);

  static List<Food?> foodListFromSnapshot2(
      QuerySnapshot<Map<String, dynamic>> snapshot) =>
      snapshot.docs.map((snapshot) => foodFromSnapshot2(snapshot)).toList();

  static Stream<List<Food?>> get allFood2 =>
      foodCollection2.snapshots().map(foodListFromSnapshot2);


  static List<Food?> foodListFromSnapshot3(
      QuerySnapshot<Map<String, dynamic>> snapshot) =>
      snapshot.docs.map((snapshot) => foodFromSnapshot2(snapshot)).toList();

  static Stream<List<Food?>> get allFood3 =>
      foodCollection3.snapshots().map(foodListFromSnapshot2);

}

List<Food?> getRightFood(List<Food?> list, String category, bool isStaff) {
  List<Food?> foodList = [];

  if(isStaff){
    for (int i = 0; i < list.length; i++) {
      FoodCategory currentCategory = list[i]!.category;
      if (currentCategory.toString() == category ) {
        foodList.add(list[i]);
      }
    }
  }else{
    for (int i = 0; i < list.length; i++) {
      FoodCategory currentCategory = list[i]!.category;
      if (currentCategory.toString() == category && list[i]!.active==true) {
        foodList.add(list[i]);
      }
    }
  }


  return foodList;
}

