import '../../services/imports.dart';

class PrinterScreen extends StatefulWidget {
  const PrinterScreen({super.key});

  @override
  State<PrinterScreen> createState() => _PrinterScreenState();
}

class _PrinterScreenState extends State<PrinterScreen> {

  late Stream myStream;
  List<Comanda?>snapshotOrderList= [];
  List<String> stringListTimer=[];

  List<double> tableNumberList = [];
  Map<double,Comanda> tableNumberComandeMap= {};

  bool kitchenSelected=true;
  String foodTypeSelected = 'Cucina';

  int rep = 1;


  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  bool _connected = false;
  BluetoothDevice? _device;
  String tips = 'no device connect';

  @override
  void initState() {
    super.initState();

    myStream =FirebaseFirestore.instance
        .collection('comanda')
        .orderBy('createdAt', descending: true).snapshots();

    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 4));

    bool isConnected=await bluetoothPrint.isConnected??false;

    bluetoothPrint.state.listen((state) {
      print('******************* cur device status: $state');

      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = 'connect success';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = 'disconnect success';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if(isConnected) {
      setState(() {
        _connected=true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TEST BluetoothPrint'),
        ),
        body: RefreshIndicator(
          onRefresh: () =>
              bluetoothPrint.startScan(timeout: Duration(seconds: 4)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Text(tips),
                    ),
                  ],
                ),
                Divider(),
                StreamBuilder<List<BluetoothDevice>>(
                  stream: bluetoothPrint.scanResults,
                  initialData: [],
                  builder: (c, snapshot) => Column(
                    children: snapshot.data!.map((d) => ListTile(
                      title: Text(d.name??''),
                      subtitle: Text(d.address??''),
                      onTap: () async {
                        setState(() {
                          _device = d;
                        });
                      },
                      trailing: _device!=null && _device!.address == d.address?Icon(
                        Icons.check,
                        color: Colors.green,
                      ):null,
                    )).toList(),
                  ),
                ),
                Divider(),


                ///StreamBuildr for orders
                Container(
                  height: 100,
                  width: 100,
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
                          bool isGathered = allComandaSnapshot[i].data()['isGathered'];
                          double tableNumber = allComandaSnapshot[i].data()['tableNumber'] +0.0;

                          //double tableNumber = tableNumberInt.toDouble();

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
                            tableNumber:tableNumber,
                          );

                          if(comanda.isGathered == false){
                            allComanda.add(comanda);
                          }

                        }
                        snapshotOrderList.clear();

                        for(int i=0; i<allComanda.length;i++){
                          snapshotOrderList.add(allComanda[i]);
                        }



                        return Container();
                      }),
                ),



                Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          OutlinedButton(
                            child: Text('connect'),
                            onPressed:  _connected?null:() async {
                              if(_device!=null && _device!.address !=null){
                                setState(() {
                                  tips = 'connecting...';
                                });
                                await bluetoothPrint.connect(_device!);
                              }else{
                                setState(() {
                                  tips = 'please select device';
                                });
                                print('please select device');
                              }
                            },
                          ),

                        ],
                      ),
                      Divider(),
                      OutlinedButton(
                        child: Text('print receipt'),
                        onPressed:  _connected?() async {


                          Timer.periodic(Duration(seconds: 40),(Timer t) async{

                            print('rep : $rep');

                            setState(() {
                              rep++;
                            });

                            ///this for loop tracks all the table numbers
                            for(int t=0 ; t< snapshotOrderList.length;t++){
                              if(!tableNumberList.contains(snapshotOrderList[t]!.tableNumber )){
                                tableNumberList.add(snapshotOrderList[t]!.tableNumber );
                              }
                            }
                            for(double element in tableNumberList){
                              print('tavolo : $element ');
                            }

                            ///The purpose of the following for loop is to create a Map in which the key is the table number and the value a list of
                            ///"comande" that were sent from that table

                            for(int i=0 ; i< tableNumberList.length; i++) {
                              /// temporary list that get all the orders of the table considered by the loop
                              List<Comanda>tempListTimer = [];

                              ///temporary lists used to check if there are more dishes with the same name and to get the requests from the current table
                              List<String?> tempNameListTimer = [];
                              List<int> tempQuantityListTimer = [];
                              List<String> requestListTimer = [];


                              ///Map and List usefull for printing

                              Map<String, dynamic> config = Map();
                              List<LineText> list = [];
                              for (int j = 0; j < snapshotOrderList.length; j++) {
                                ///tempListTimer gets all the orders and requests with the current table number
                                if (tableNumberList[i] == snapshotOrderList[j]!.tableNumber && snapshotOrderList[j]!.isGathered == false ) {
                                  tempListTimer.add(snapshotOrderList[j]!);

                                  ///update "isGathered" state of the order
                                  DatabaseComanda databaseComanda = DatabaseComanda();

                                  Comanda comanda = Comanda(
                                      isActive: snapshotOrderList[j]!.isActive,
                                      isGathered: true,
                                      time: snapshotOrderList[j]!.time,
                                      id: snapshotOrderList[j]!.id,
                                      createdAt: snapshotOrderList[j]!.createdAt,
                                      tableNumber: snapshotOrderList[j]!.tableNumber,
                                      foodNameList: snapshotOrderList[j]!.foodNameList,
                                      quantityList: snapshotOrderList[j]!.quantityList,
                                      request: snapshotOrderList[j]!.request,
                                      requestList: snapshotOrderList[j]!.requestList,
                                      list: snapshotOrderList[j]!.list
                                  );

                                  databaseComanda.createEdit(comanda: comanda, isEdit:true);

                                  if (snapshotOrderList[j]!.request != " ") {
                                    requestListTimer.add(snapshotOrderList[j]!.request);
                                  }
                                }
                              }


                              ///check if dishes with the same name are already inserted
                              for (int t = 0; t < tempListTimer.length; t++) {
                                for (int u = 0; u < tempListTimer[t].foodNameList.length; u++) {
                                  if (tempNameListTimer.contains(tempListTimer[t].foodNameList[u])) {
                                    int index = tempNameListTimer.indexOf(
                                        tempListTimer[t].foodNameList[u]);

                                    tempQuantityListTimer[index] += tempListTimer[t].quantityList[u];
                                  } else  {
                                    tempNameListTimer.add(tempListTimer[t].foodNameList[u]);
                                    tempQuantityListTimer.add(tempListTimer[t].quantityList[u]);
                                  }
                                }
                              }

                              for (int h = 0; h < tempNameListTimer.length; h++) {
                                print('${tempQuantityListTimer[h]} x ${tempNameListTimer[h]}');
                              }

                              if(tempNameListTimer.isNotEmpty){
                                const uuid = Uuid();
                                String comandaTimerId = uuid.v1();

                                DateTime now = DateTime.now();
                                String date = '${now.hour} : ${now.minute}';

                                Comanda comandaTimer = Comanda(
                                    isGathered: true,
                                    id: comandaTimerId,
                                    time: date,
                                    list: [],
                                    tableNumber: tableNumberList[i],
                                    createdAt: snapshotOrderList[i]!.createdAt,
                                    isActive: false,
                                    foodNameList: tempNameListTimer,
                                    quantityList: tempQuantityListTimer,
                                    request: ' ',
                                    requestList: requestListTimer
                                );

                                ///the order from table number i is ready and the relative superOrder can be created

                                DatabaseSupercomanda databaseSupercomanda = DatabaseSupercomanda();
                                databaseSupercomanda.createEdit(comanda: comandaTimer, isEdit: false);

                                ///creation of the order

                                list.add(LineText(type: LineText.TYPE_TEXT, content: 'CUCINA', align: LineText.ALIGN_LEFT, linefeed: 1));
                                list.add(LineText(type: LineText.TYPE_TEXT, content: '----------------------------------------------', weight: 1, align: LineText.ALIGN_CENTER,linefeed: 1));
                                list.add(LineText(type: LineText.TYPE_TEXT, content: 'Tav. ${tableNumberList[i]} ', weight: 1, align: LineText.ALIGN_LEFT, fontZoom: 3, linefeed: 1));
                                list.add(LineText(type: LineText.TYPE_TEXT, content: '${comandaTimer.createdAt}', align: LineText.ALIGN_LEFT, fontZoom:1, linefeed: 1));

                                list.add(LineText(type: LineText.TYPE_TEXT, content: '----------------------------------------------', weight: 1, align: LineText.ALIGN_CENTER,linefeed: 1));
                                for(int foodIndex=0; foodIndex< tempNameListTimer.length; foodIndex ++){
                                  list.add(LineText(type: LineText.TYPE_TEXT, content: '${tempQuantityListTimer[foodIndex]} X ${tempNameListTimer[foodIndex]}',fontZoom: 3,  align: LineText.ALIGN_LEFT, linefeed: 1));
                                  list.add(LineText(linefeed: 1));
                                }
                                if(comandaTimer.requestList!.isNotEmpty){
                                  list.add(LineText(type: LineText.TYPE_TEXT, content: 'RICHIESTE SPECIFICHE', align: LineText.ALIGN_LEFT, linefeed: 1));
                                  list.add(LineText(linefeed: 1));
                                  for(String request in comandaTimer.requestList!){
                                    list.add(LineText(type: LineText.TYPE_TEXT, content: request ,fontZoom: 3,  align: LineText.ALIGN_LEFT, linefeed: 1));
                                    list.add(LineText(linefeed: 1));
                                  }
                                }

                                list.add(LineText(linefeed: 1));
                                list.add(LineText(linefeed: 1));
                                list.add(LineText(linefeed: 1));
                                list.add(LineText(linefeed: 1));

                                await bluetoothPrint.printReceipt(config, list);

                              }

                              list.clear();

                              tempQuantityListTimer.clear();
                              tempListTimer.clear();
                              tempNameListTimer.clear();
                              requestListTimer.clear();


                            }

                            tableNumberList.clear();

                          });
                         // await bluetoothPrint.printReceipt(config, list);
                        }:null,
                      ),
                    ],
                  ),
                ),
                Center(
                  child:IconButton(
                    color: kitchenSelected ? Colors.white : Colors.purpleAccent,
                    icon: Icon(Icons.wine_bar_rounded),
                    onPressed: (){
                      setState(() {
                        kitchenSelected = !kitchenSelected;
                        foodTypeSelected = kitchenSelected ? 'Cucina' : 'Bar';
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: StreamBuilder<bool>(
          stream: bluetoothPrint.isScanning,
          initialData: false,
          builder: (c, snapshot) {
            if (snapshot.data == true) {
              return FloatingActionButton(
                child: Icon(Icons.stop),
                onPressed: () => bluetoothPrint.stopScan(),
                backgroundColor: Colors.red,
              );
            } else {
              return FloatingActionButton(
                  child: Icon(Icons.search),
                  onPressed: () => bluetoothPrint.startScan(timeout: Duration(seconds: 4)));
            }
          },
        ),
      ),
    );
  }
}
