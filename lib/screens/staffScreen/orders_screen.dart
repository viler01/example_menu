import '../../services/imports.dart';
import 'package:flutter/cupertino.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  static const double paddingHorizontal = 0;
  static const double paddingVertical = 30;
  static const double horizontal_padding = 70;
  static const double vertical_padding = 20;

  static const double height = 700;
  static const double width = 480;
  ScrollController controller1 = ScrollController();
  final ScrollController _superComandaController = ScrollController();
  ScrollController _normalComandaController = ScrollController();

  String source ='https://firebasestorage.googleapis.com/v0/b/piacericarnali-d521e.appspot.com/o/test%2Fsound.mp3?alt=media&token=af6f5ca2-28af-4f7f-b82d-e24bd429f1f8';
 String callSource = 'https://firebasestorage.googleapis.com/v0/b/piacericarnali-d521e.appspot.com/o/test%2FcallSound.wav?alt=media&token=ed5ca263-f9d2-41d3-b797-f79a6f136180';

 late Stream superComandaStream;
  late Stream myStream;
  late Stream callStream;
  List<Comanda?>snapshotOrderList= [];



  TextEditingController tableNumber = TextEditingController();

  @override
  void initState()  {
    ///soluzione al problema dello stream (rebuild continuo)

    myStream =FirebaseFirestore.instance
        .collection('comanda')
        .orderBy('createdAt', descending: true).snapshots();

    callStream =FirebaseFirestore.instance
        .collection('calls')
        .orderBy('createdAt', descending: true).snapshots();

    superComandaStream =  FirebaseFirestore.instance
        .collection('superComanda')
        .orderBy('createdAt', descending: true)
        .snapshots();

   super.initState();
  }
  bool isFirstLaunch=true;



  @override
  void dispose() {

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    List<String?> tempNameList=[];
    List<int> tempValueList=[];
    List<Comanda?>tempList= [];
    List<String> stringList=[];

    void compattaComanda(double? number){


      ///questo for controlla tutte le comande e considera solo quelle provenienti dal tavolo desiderato
      ///in particolare le aggiunge a tempList (che poi usi per ottenere anche i nomi dei cibi richiesti e
      ///a stringList per ottenere tutte le modifiche arrivate da quel tavolo

      for(int i=0; i< snapshotOrderList.length;i++){
        if(snapshotOrderList[i]!.tableNumber==number){
          setState(() {
            tempList.add(snapshotOrderList[i]);
           if(snapshotOrderList[i]!.request != " "){
             stringList.add(snapshotOrderList[i]!.request);
           }
          });

        }
      }

      for(int t =0 ; t< stringList.length; t++){
        print(stringList[t]);
      }

      for(int t=0; t<tempList.length; t++ ){
        for(int u =0; u<tempList[t]!.foodNameList.length;u++){

          if(tempNameList.contains(tempList[t]!.foodNameList[u])){
            int index = tempNameList.indexOf(tempList[t]!.foodNameList[u]);
            print(index);
            tempValueList[index]+=tempList[t]!.quantityList[u];

          }else{
            tempNameList.add(tempList[t]!.foodNameList[u]);
            tempValueList.add(tempList[t]!.quantityList[u]);
          }
        }
      }

      DateTime now = DateTime.now();
      String date = '${now.hour} : ${now.minute}';
      const uuid = Uuid();
      String id = uuid.v1();

      Comanda comanda = Comanda(
        requestList: stringList,
        request:" ",
        time: date ,
        createdAt: now,
        id: id,
        list: [],
        quantityList: tempValueList,
        foodNameList: tempNameList,
        isActive: false,
        tableNumber: number!,
      );

      DatabaseSupercomanda databaseSupercomanda = DatabaseSupercomanda();

      databaseSupercomanda.createEdit(comanda: comanda, isEdit: false);

      DatabaseComanda databaseComanda = DatabaseComanda();

      for(int p=0 ; p< tempList.length;p++){
        databaseComanda.deleteComanda(comandaID: tempList[p]!.id);
      }

      setState(() {
        tempNameList.clear();
        tempValueList.clear();
        tempList.clear();

        for(int g=0; g<snapshotOrderList.length;g++){
          if(snapshotOrderList[g]!.tableNumber == number){
            snapshotOrderList.removeAt(g);
          }
        }
      });


    }

    return SingleChildScrollView(

      primary: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: paddingVertical,
                horizontal: paddingHorizontal),
            child: Text(
              'Le tue Comande',
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child:
                    Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black54, width: 2)),
                      child: StreamBuilder(
                          stream:myStream,
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

                              //TODO occhio qua
                                /*
                              List<bool> boolList= [];
                              for(int y=0;y<allComandaSnapshot.length;y++){
                                boolList.add(allComandaSnapshot[y].data()['isActive']);
                                myList.add(allComandaSnapshot[y].data()['isActive']);
                              }
                              //sing(boolList: boolList);
                              */




                              Comanda comanda = Comanda(
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
                            snapshotOrderList.clear();

                            for(int i=0; i<allComanda.length;i++){
                              snapshotOrderList.add(allComanda[i]);
                            }



                                return allComanda.isEmpty
                                ? Center(
                                    child: Center(
                                    child: Text(
                                      'Nessuna comanda ricevuta ',
                                    ),
                                  ))
                                : Container(
                                    height: height,
                                    width: width,
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ListView.builder(
                                          controller: _normalComandaController,
                                         // physics: const NeverScrollableScrollPhysics(),
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
                    /*
                    IconButton(onPressed: (){
                      print('ok');
                     // _normalComandaController.jumpTo(0.0);
                       //scrollToFirstTile();
                    }, icon: Icon(CupertinoIcons.arrow_up))*/
              ),
          DeleteAllButton(collectionName: 'comanda')
            ],
          ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: vertical_padding,
                      horizontal: horizontal_padding),
                  child:
                  Container(
                    height: 80,
                    width: 400,
                    child:  TextFormField(
                      controller: tableNumber,
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true
                      ),

                      textAlign: TextAlign.center,
                      decoration: AppStyle().kTextFieldDecoration(
                          icon: Icons.location_on,
                          hintText:
                          'inserire il numero del tavolo da compattare'),
                    ),
                  ),),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoButton(
                    child: Text('compatta'),
                    onPressed: () {
                      String tableNumberFormatted = tableNumber.text.replaceAll(',', '.');
                      compattaComanda(double.tryParse(tableNumberFormatted));
                      /*
              AudioPlayer player = AudioPlayer();
              player.play(UrlSource('https://firebasestorage.googleapis.com/v0/b/piacericarnali-d521e.appspot.com/o/test%2Fsound.mp3?alt=media&token=af6f5ca2-28af-4f7f-b82d-e24bd429f1f8'));
              */
                    },
                  ),
                ),


                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        height: height,
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black54, width: 2)),
                        child: StreamBuilder(
                            stream:superComandaStream,
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
                             final allSuperComandaSnapshot = snapshot.data!.docs;

                              List<Comanda?> allSuperComanda = [];


                                for (int i = 0; i < allSuperComandaSnapshot.length; i++) {

                                  List<String?> cibi = [];
                                  for (int j = 0; j < allSuperComandaSnapshot[i].data()['list'].length; j++) {
                                    cibi.add(
                                        allSuperComandaSnapshot[i].data()['list'][j]);
                                  }
                                  List<String?> foodNames = [];
                                  for (int j = 0; j < allSuperComandaSnapshot[i].data()['foodNameList'].length; j++) {
                                    foodNames.add(
                                        allSuperComandaSnapshot[i].data()['foodNameList'][j]);
                                  }
                                  List<int> foodQuantity = [];
                                  for (int j = 0; j < allSuperComandaSnapshot[i].data()['quantityList'].length; j++) {
                                    foodQuantity.add(
                                        allSuperComandaSnapshot[i].data()['quantityList'][j]);
                                  }

                                  List<String> requestList=[];
                                  for (int j = 0; j < allSuperComandaSnapshot[i].data()['requestList'].length; j++) {
                                    requestList.add(
                                        allSuperComandaSnapshot[i].data()['requestList'][j]);
                                  }


                                  DateTime dateTime = allSuperComandaSnapshot[i]
                                      .data()['createdAt']
                                      .toDate();
                                  String request = allSuperComandaSnapshot[i].data()['request'];


                                  Comanda comanda = Comanda(
                                    requestList: requestList,
                                    request: request,
                                    foodNameList: foodNames,
                                    quantityList:  foodQuantity,
                                    isActive:
                                    allSuperComandaSnapshot[i].data()['isActive'],
                                    id: allSuperComandaSnapshot[i].data()['id'],
                                    createdAt: dateTime,
                                    list: cibi,
                                    time: allSuperComandaSnapshot[i].data()['time'],
                                    tableNumber:
                                    allSuperComandaSnapshot[i].data()['tableNumber'],
                                  );
                                  allSuperComanda.add(comanda);

                                }

                              return allSuperComanda.isEmpty
                                  ? Center(
                                  child: Center(
                                    child: Text(
                                      'Nessuna comanda ricevuta ',
                                      style: TextStyle(color: kPrimaryColor),
                                    ),
                                  ))
                                  : Container(
                                height: height,
                                width: width,
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListView.builder(
                                      physics:
                                      const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, int index) {
                                        return SuperComandaItemUser(
                                            comanda: allSuperComanda[index]);
                                      },
                                      itemCount: allSuperComanda.length,
                                    ),
                                  ),
                                ),
                              );


                            }),
                      ),
                    ),

                 DeleteAllButton(collectionName: 'superComanda')

                  ],
                ),

        ],
      ),
    );
  }
}
