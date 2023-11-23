import '../imports.dart';

class DatabaseUser {
  DatabaseUser();

  static CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection('users');

  ///SERIALIZATION
  static UserData? userDataFromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserData(
      uid: snapshot.id,
      email: snapshot.data()?['email'] ?? "",
      name: snapshot.data()?['name'] ?? "",
    );
  }

  Stream<UserData?> userData({required String uid}) {
    return userCollection.doc(uid).snapshots().map(userDataFromSnapshot);
  }

  Future addFood({required UserData? userdata, required Food food}) async {
    CollectionReference<Map<String, dynamic>> foodList =
        userCollection.doc(userdata!.uid).collection('food');

    foodList.add({
      'active': food.active,
      'name': food.name,
      'id': food.id,
      'course': food.course.toString(),
      'price': food.price,
      'imageURL': food.imageURL,
      'descriptionIT': food.descriptionIT,
      'descriptionING': food.descriptionING,
      'descriptionDE': food.descriptionDE,
      'descriptionFR': food.descriptionFR,
    }).then((value) {
      foodList.doc(value.id).update({'id': value.id});
    });
  }
}
