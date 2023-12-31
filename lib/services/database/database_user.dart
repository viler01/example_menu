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


}
