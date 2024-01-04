import '../../services/imports.dart';

class DatabaseSupercomanda{

  static CollectionReference<Map<String, dynamic>> superComandaCollection =
  FirebaseFirestore.instance.collection('superComanda');

  Future createEdit({required Comanda comanda, required bool isEdit }) async {

    return  !isEdit ?
    await superComandaCollection.doc(comanda.id).set({
      'isGathered' : comanda.isGathered,
      'request': comanda.request,
      'list': comanda.list,
      'time' : comanda.time,
      'id': comanda.id,
      'tableNumber': comanda.tableNumber,
      'createdAt': comanda.createdAt,
      'isActive': comanda.isActive,
      'foodNameList': comanda.foodNameList,
      'quantityList': comanda.quantityList,
      'requestList':comanda.requestList
    })
        :
    await superComandaCollection.doc(comanda.id).update({
      'isGathered' : comanda.isGathered,
      'request': comanda.request,
      'list': comanda.list,
      'time' : comanda.time,
      'id': comanda.id,
      'tableNumber': comanda.tableNumber,
      'createdAt': comanda.createdAt,
      'isActive': comanda.isActive,
      'foodNameList': comanda.foodNameList,
      'quantityList': comanda.quantityList,
      'requestList':comanda.requestList
    });



  }


  static Comanda? superComandaFromSnapshot(
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
    await  superComandaCollection.doc(comandaID).delete();
    return;
  }


  Stream<Comanda?> singleSuperComanda({required String id}) =>
      superComandaCollection.doc(id).snapshots().map(superComandaFromSnapshot);

  static List<Comanda?> superComandaListFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) =>
      snapshot.docs.map((snapshot) => superComandaFromSnapshot(snapshot)).toList();

  static Stream<List<Comanda?>> get allSuperComanda =>
      superComandaCollection.snapshots().map(superComandaListFromSnapshot);




}