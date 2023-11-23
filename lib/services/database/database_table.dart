 import '../../services/imports.dart';

class DatabaseTable {
  static CollectionReference<Map<String, dynamic>> tableCollection =
  FirebaseFirestore.instance.collection('tables');

  Future createEdit({required Tavolo table, required bool isEdit}) async {
    return isEdit
        ? await tableCollection.doc(table.tableId).update({
      'number': table.number,
      'fakeNumber' : table.fakeNumber,
      'isTaken': table.isTaken,
      'tableId': table.tableId
    })
        : await tableCollection.doc(table.tableId).set({
      'number': table.number,
      'fakeNumber' : table.fakeNumber,
      'isTaken': table.isTaken,
      'tableId': table.tableId
    });
  }
  Future deleteTable({required String tableID}) async{
    await  tableCollection.doc(tableID).delete();
    return;
  }


  static Tavolo? tableFromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {

        return Tavolo(
          number : snapshot.data()?['number'] ?? 0,
          fakeNumber: snapshot.data()?['fakeNumber'] ?? 0,
          tableId: snapshot.data()?['tableId'] ?? "",
          isTaken: snapshot.data()?['isTaken'] ?? false,
        );


  }

  Stream<Tavolo?> singleFood({required String id}) =>
      tableCollection.doc(id).snapshots().map(tableFromSnapshot);

  static List<Tavolo?> tableListFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) =>
      snapshot.docs.map((snapshot) => tableFromSnapshot(snapshot)).toList();

  static Stream<List<Tavolo?>> get allTable =>
      tableCollection.snapshots().map(tableListFromSnapshot);



  Future<Tavolo> getSingleTable({required String id}) async {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('tables').doc(id);

    await documentReference.get().then((DocumentSnapshot? documentSnapshot) {
      String tableId = documentSnapshot!['tableId'];
      double number = documentSnapshot['number'];
      double fakeNumber = documentSnapshot['fakeNumber'];
      bool isTaken = documentSnapshot['isTaken'];
      return Tavolo(number: number, fakeNumber: fakeNumber, isTaken: isTaken, tableId: tableId);
    });
    return Tavolo(number: 10000, fakeNumber: 100000, isTaken: false, tableId: '');
  }

}
