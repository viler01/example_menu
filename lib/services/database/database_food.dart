import '../imports.dart';

class DatabaseFood {
  static CollectionReference<Map<String, dynamic>> foodCollection =
      FirebaseFirestore.instance.collection('foods');

  static CollectionReference<Map<String, dynamic>> foodCollection2 =
  FirebaseFirestore.instance.collection('foods');

  Future deleteFood({required String foodID}) async{
   await  foodCollection.doc(foodID).delete();
   return;
}

  Future createEdit({required Food food, required bool isEdit}) async {
    return isEdit
        ? await foodCollection.doc(food.id).update({
            'allergy' :food.allergy,
            'name': food.name,
            'active': food.active,
            'id': food.id,
            'course': food.course.toString(),
            'price': food.price,
            'imageURL': food.imageURL,
            'descriptionIT': food.descriptionIT,
            'descriptionING': food.descriptionING,
            'descriptionDE': food.descriptionDE,
            'descriptionFR': food.descriptionFR,
          })
        : await foodCollection.doc(food.id).set({
      'allergy' :food.allergy,
            'name': food.name,
            'active': food.active,
            'id': food.id,
            'course': food.course.toString(),
            'price': food.price,
            'imageURL': food.imageURL,
            'descriptionIT': food.descriptionIT,
            'descriptionING': food.descriptionING,
            'descriptionDE': food.descriptionDE,
            'descriptionFR': food.descriptionFR,
          });
  }

  static Food? foodFromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    switch (snapshot.data()?['course']) {
      case 'Course.appetizers':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.appetizers,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.firstCourse':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.firstCourse,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.secondCourse':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.secondCourse,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.side':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.side,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.dessert':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.dessert,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.drink':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.drink,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.beer':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.beer,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.wine':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.wine,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.ape':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.ape,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.softDrink':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.softDrink,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.coffee':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.coffee,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.amaro':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.amaro,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.baby':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.baby,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );

    }
  }

  Stream<Food?> singleFood({required String id}) =>
      foodCollection.doc(id).snapshots().map(foodFromSnapshot);

  static List<Food?> foodListFromSnapshot(
          QuerySnapshot<Map<String, dynamic>> snapshot) =>
      snapshot.docs.map((snapshot) => foodFromSnapshot(snapshot)).toList();

  static Stream<List<Food?>> get allFood =>
      foodCollection.snapshots().map(foodListFromSnapshot);


  ///************************************************************
  static Food? foodFromSnapshot2(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    switch (snapshot.data()?['course']) {
      case 'Course.appetizers':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.appetizers,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.firstCourse':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.firstCourse,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.secondCourse':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.secondCourse,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.side':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.side,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.dessert':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.dessert,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.drink':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.drink,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.beer':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.beer,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.wine':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.wine,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.ape':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.ape,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.softDrink':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.softDrink,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.coffee':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.coffee,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.amaro':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.amaro,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );
      case 'Course.baby':
        return Food(
          allergy: snapshot.data()?['allergy'] != null
              ? (snapshot.data()?['allergy'] as List)
              .map((item) => item as String)
              .toList()
              : [],
          active: snapshot.data()?['active'] ?? false,
          name: snapshot.data()?['name'] ?? "",
          price: snapshot.data()?['price'] ?? 0,
          id: snapshot.data()?['id'] ?? "",
          course: Course.baby,
          imageURL: snapshot.data()?['imageURL'] ?? "",
          descriptionING: snapshot.data()?['descriptionING'] ?? "",
          descriptionIT: snapshot.data()?['descriptionIT'] ?? "",
          descriptionDE: snapshot.data()?['descriptionDE'] ?? "",
          descriptionFR: snapshot.data()?['descriptionFR'] ?? "",
        );

    }
  }


  static List<Food?> foodListFromSnapshot2(
      QuerySnapshot<Map<String, dynamic>> snapshot) =>
      snapshot.docs.map((snapshot) => foodFromSnapshot2(snapshot)).toList();

  static Stream<List<Food?>> get allFood2 =>
      foodCollection2.snapshots().map(foodListFromSnapshot2);

/*
  Future<Food> getSingleFood({required String id}) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('foods').doc(id);

    await documentReference.get().then((DocumentSnapshot? documentSnapshot) {
      String id = documentSnapshot!['id'];
      bool active = documentSnapshot['active'];
      String name = documentSnapshot['name'];
      double price = documentSnapshot['price'];
      String descriptionIT = documentSnapshot['descriptionIT'];
      String descriptionING = documentSnapshot['descriptionIT'];
      String descriptionFR = documentSnapshot['descriptionIT'];
      String descriptionDE = documentSnapshot['descriptionIT'];
      String imageURL = documentSnapshot['imageURL'];
      Course course = documentSnapshot['course'];
      return Food(
          name: name,
          active: active,
          course: course,
          price: price,
          id: id,
          descriptionDE: descriptionDE,
          descriptionFR: descriptionFR,
          descriptionING: descriptionING,
          descriptionIT: descriptionIT,
          imageURL: imageURL);
    });
    return Food(
        name: '',
        course: Course.appetizers,
        active: false,
        price: 0,
        id: 'id',
        descriptionDE: 'descriptionDE',
        descriptionFR: 'descriptionFR',
        descriptionING: '',
        descriptionIT: 'descriptionIT',
        imageURL: 'imageURL');
  }*/


}
