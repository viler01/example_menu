import '../../services/imports.dart';

class DatabaseComanda {
  static CollectionReference<Map<String, dynamic>> comandaCollection =
  FirebaseFirestore.instance.collection('comanda');

  Future createEdit({required Comanda comanda, required bool isEdit }) async {

    return  !isEdit ?
    await comandaCollection.doc(comanda.id).set({
      'isGathered': comanda.isGathered,
      'list': comanda.list,
      'time' : comanda.time,
      'id': comanda.id,
      'tableNumber': comanda.tableNumber,
      'createdAt': comanda.createdAt,
      'isActive': comanda.isActive,
      'foodNameList': comanda.foodNameList,
      'quantityList': comanda.quantityList,
      'request' : comanda.request,
      'requestList': comanda.requestList
    })
        :
    await comandaCollection.doc(comanda.id).update({
      'isGathered': comanda.isGathered,
      'list': comanda.list,
      'time' : comanda.time,
      'id': comanda.id,
      'tableNumber': comanda.tableNumber,
      'createdAt': comanda.createdAt,
      'isActive': comanda.isActive,
      'foodNameList': comanda.foodNameList,
      'quantityList': comanda.quantityList,
      'request' : comanda.request,
      'requestList': comanda.requestList
    });



  }


  static Comanda? comandaFromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {

    return Comanda(
      isGathered : snapshot.data()?['isGathered']?? false,
      request:snapshot.data()?['request'] ?? "",
      isActive: snapshot.data()?['isActive']?? false,
      id : snapshot.data()?['id'] ?? "",
      time: snapshot.data()?['time'] ?? "",
      tableNumber: snapshot.data()?['tableNumber'] ?? 0,
      createdAt:  snapshot.data()?['createdAt'] != null
          ? snapshot.data()!['createdAt'].toDate()
          : DateTime.now(),
      list: snapshot.data()?['list'] != null
          ? (snapshot.data()?['list'] as List)
          .map((item) => item as String)
          .toList()
          : [],
      foodNameList: snapshot.data()?['foodNameList'] != null
          ? (snapshot.data()?['foodNameList'] as List)
          .map((item) => item as String)
          .toList()
          : [],
      quantityList: snapshot.data()?['quantityList'] != null
          ? (snapshot.data()?['quantityList'] as List)
          .map((item) => item as int)
          .toList()
          : [],
      requestList: snapshot.data()?['requestList'] != null
          ? (snapshot.data()?['requestList'] as List)
          .map((item) => item as String)
          .toList()
          : [],
    );


  }

  Future deleteComanda({required String comandaID}) async{
    await  comandaCollection.doc(comandaID).delete();
    return;
  }


  Stream<Comanda?> singleComanda({required String id}) =>
      comandaCollection.doc(id).snapshots().map(comandaFromSnapshot);

  static List<Comanda?> ComandaListFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) =>
      snapshot.docs.map((snapshot) => comandaFromSnapshot(snapshot)).toList();

  static Stream<List<Comanda?>> get allComanda =>
      comandaCollection.snapshots().map(ComandaListFromSnapshot);

  Future<void> deleteCollection(String collectionPath) async {
    final collectionReference = FirebaseFirestore.instance.collection(collectionPath);
    final querySnapshot = await collectionReference.get();

    for (final documentSnapshot in querySnapshot.docs) {
      await documentSnapshot.reference.delete();
    }
  }


}
