import '../services/imports.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {

 // late Stream myStream;
  double tableNumber =1000;
  TextEditingController tableNumberController = TextEditingController();

  @override
  void initState() {
/*
    myStream =FirebaseFirestore.instance
        .collection('comanda').where('tableNumber', isEqualTo:tableNumber )
        .orderBy('createdAt', descending: true).snapshots();
*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child:
              Container(
                height: 600,
                width: 600,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black54, width: 2)),
                child: StreamBuilder(
                    stream:FirebaseFirestore.instance
                        .collection('comanda').where('tableNumber', isEqualTo:tableNumber )
                        .orderBy('createdAt', descending: true).snapshots(),
                    builder:
                        (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const LoadingWidget();
                      }
                      //List<Comanda?> allComanda = snapshot.data!;
                      final allComandaSnapshot = snapshot.data!.docs;

                      List<Comanda?> allComanda = [];

                      for (int i = 0; i < allComandaSnapshot.length; i++) {

                        List<String?> cibi = [];
                        for (int j = 0; j < allComandaSnapshot[i].data()['list'].length; j++) {
                          cibi.add(
                              allComandaSnapshot[i].data()['list'][j]);
                        }
                        List<String?> foodNames = [];
                        for (int j = 0; j < allComandaSnapshot[i].data()['foodNameList'].length; j++) {
                          foodNames.add(
                              allComandaSnapshot[i].data()['foodNameList'][j]);
                        }
                        List<int> foodQuantity = [];
                        for (int j = 0; j < allComandaSnapshot[i].data()['quantityList'].length; j++) {
                          foodQuantity.add(
                              allComandaSnapshot[i].data()['quantityList'][j]);
                        }


                        DateTime dateTime = allComandaSnapshot[i]
                            .data()['createdAt']
                            .toDate();
                        String request = allComandaSnapshot[i].data()['request'];
                        bool isGathered = allComandaSnapshot[i].data()['isGathered'];

                        Comanda comanda = Comanda(
                          isGathered: isGathered,
                          request: request,
                          foodNameList: foodNames,
                          quantityList:  foodQuantity,
                          isActive:
                          allComandaSnapshot[i].data()['isActive'],
                          id: allComandaSnapshot[i].data()['id'],
                          createdAt: dateTime,
                          list: cibi,
                          time: allComandaSnapshot[i].data()['time'],
                          tableNumber:
                          allComandaSnapshot[i].data()['tableNumber'],
                        );
                        allComanda.add(comanda);

                      }
                   /*
                      for(int i=0; i<allComanda.length;i++){
                        snapshotOrderList.add(allComanda[i]);
                      }
                      */

                      return allComanda.isEmpty
                          ? Center(
                          child: Center(
                            child: Text(
                              'insert your table number',
                            ),
                          ))
                          : Container(
                        height: 200,
                        width: 200,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, int index) {
                                return ComandaItemUser(
                                    comanda: allComanda[index]);
                              },
                              itemCount: allComanda.length,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            TextFormField(
              controller: tableNumberController,
              keyboardType: TextInputType.numberWithOptions(
                  decimal: true
              ),

              textAlign: TextAlign.center,
              decoration: AppStyle().kTextFieldDecoration(
                  icon: Icons.location_on,
                  hintText:
                  'insert your table number'),
            ),
            ElevatedButton(
                onPressed:(){
                  setState(() {
                    tableNumber = double.parse(tableNumberController.text);
                  });
                },
                child: Text('send'))
          ],
        )
      ),
    );
  }
}
