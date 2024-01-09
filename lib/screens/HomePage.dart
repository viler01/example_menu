import 'package:example_menu/models/language_model.dart';
import 'package:example_menu/widgets/GeneralWidget/MyBackground.dart';
import 'package:example_menu/widgets/costumersWidgets/FoodCardMenu.dart';
import '../services/imports.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int addValue = 1;
  int subValue = 1;
  double iconPadding = 4;
  Map<String, int> myDictionary = {};

  int index=0;
  TextEditingController tableController = TextEditingController();
  TextEditingController requestController = TextEditingController();


  late Stream<List<Food?>> myStream;

  void addFunction({required String? key, required int? value}) {
    bool containsFood = myDictionary.containsKey(key);
    if (containsFood) {
      addValue = value!;

      setState(() {
        addValue++;
        myDictionary[key!] = addValue;
      });
      myDictionary.forEach((key, value) {});
    } else {
      setState(() {
        myDictionary[key!] = 1;
      });
    }
  }

  void subFunction({required String? key, required int? value}) {
    bool containsFood = myDictionary.containsKey(key!);
    if (containsFood) {
      subValue = value!;
      setState(() {
        subValue--;
        myDictionary[key] = subValue;
      });
      myDictionary.forEach((key, value) {
        print('key : $key, value : $value');
      });
    }
  }

  @override
  void initState( ) {

    myStream = DatabaseFood.allFood2;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return index ==0 ? Scaffold(


      appBar: AppBar(
        title: const Text(restourantName),
        actions: [
          IconButton(
              onPressed: () {
                /*
                ///in questo modo ottengo il refresh della pagina e si azzerano i numeri delle portate
                showModalBottomSheet(
                  backgroundColor: Colors.white,
                  context: context,
                  isScrollControlled: true,
                  isDismissible: true,
                  builder: (context) => ClientPopupScreen(
                    map: myDictionary,
                  ),
                ).then((value) {
                  myDictionary.clear();
                  setState(() {});
                });*/

                setState(() {
                  index=1;
                });

              },
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.green,
              ))
        ],
      ),


      drawer: Drawer(
        backgroundColor: secondaryColor,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for(var language in Language.languageList())ListTile(
                  leading: Text(language.flag),
                  title: Text(language.visualName),
                  onTap: (){
                    setState(() {
                      currentLanguage = language.name;
                    });
                    Navigator.pop(context);
                  },
                ),

                const Divider(color: Colors.black,),
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('Cronologia ordini'),
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return const OrderHistoryScreen();
                        }));
                  },
                ),
                const Divider(color: Colors.black,),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Staff Login'),
                  onTap: ()
                  {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return StreamProvider<CurrentUser?>.value(
                              value: AuthService().user,
                              initialData: CurrentUser(),
                              catchError: (_, __) => null,
                              child: const AppDirector());
                        }));
                  }

                )
              ],
            ),
          ),
        ),
      ),

      body: CustomPaint(
        painter: MyBackground(),
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child:  StreamBuilder<List<Food?>>(
                stream: myStream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Food?>> snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const LoadingWidget();
                  }

                  List<Food?> allFood = snapshot.data!;

                  List<Food?> aperitifsList = getRightFood(
                      allFood, 'FoodCategory.aperitifs',false);
                  List<Food?> appetizersList = getRightFood(
                      allFood, 'FoodCategory.appetizers',false);
                  List<Food?> maindishesList = getRightFood(
                      allFood, 'FoodCategory.mainDishes',false);
                  List<Food?> secondCoursesList = getRightFood(
                      allFood, 'FoodCategory.secondCourses',false);
                  List<Food?> sideDishesList = getRightFood(
                      allFood, 'FoodCategory.sideDishes',false);
                  List<Food?> dessertList = getRightFood(
                      allFood, 'FoodCategory.dessert',false);
                  List<Food?> nonAlcoholicList = getRightFood(
                      allFood, 'FoodCategory.nonAlcoholic',false);
                  List<Food?> beersList = getRightFood(
                      allFood, 'FoodCategory.beers',false);
                  List<Food?> winesList = getRightFood(
                      allFood, 'FoodCategory.wines',false);

                  List<List<Food?>> allFoodInList=[
                    aperitifsList,
                    appetizersList,
                    maindishesList,
                    secondCoursesList,
                    sideDishesList,
                    dessertList,
                    nonAlcoholicList,
                    beersList,
                    winesList,
                  ];

                  return Column(
                      children: [
                        for (int i =0; i<FoodCategory.values.length;i++)...
                        [
                          CustomExpansionTile(
                            title: translateFoodCategory(
                                foodCategory: FoodCategory.values[i]),
                            children: [
                              allFoodInList[i].isEmpty
                                  ? const Center(
                                  child: Center(
                                    child: Text(
                                      'not already inserted ',
                                    ),
                                  ))
                                  : Padding(
                                padding:
                                const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  physics:
                                  const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection:
                                  Axis.vertical,
                                  itemBuilder:
                                      (context, int index) {
                                    return FoodCardMenu(
                                        quantity: myDictionary[
                                        allFoodInList[i][index]!.nameENG],
                                     subFun: ()=> subFunction(
                                         key:  allFoodInList[i][index]!.nameENG,
                                         value: myDictionary[
                                         allFoodInList[i][index]!.nameENG]),
                                        addFun:(){
                                          addFunction(
                                              key: allFoodInList[i][index]!.nameENG,
                                              value: myDictionary[
                                              allFoodInList[i][index]!.nameENG]);
                                        } ,
                                        food: allFoodInList[i][index]!);
                                  },
                                  itemCount: allFoodInList[i].length,
                                ),
                              )
                            ],
                          )

                        ]
                      ]
                  );
                }),
          ),
        ),
      )
    ) :
    ///client pop up screen now is here
    Scaffold(
      body: Column(
        children: [
          Center(child: IconButton(
            icon: const Icon(CupertinoIcons.arrow_down_circle_fill),
            onPressed: (){
              setState(() {
                index = 0;
              });
            },
          ),),
          Expanded( child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, int index) {

                List<int?>  values = myDictionary.values.toList();
                List<String?> keys = myDictionary.keys.toList();

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (values[index]! != 0) ...[
                      Expanded(child:Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          keys[index]!,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis
                          ),
                        ),
                      ),),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "   X ${values[index].toString()}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ],
                );
              },
              itemCount: myDictionary.length,
            ),
          )),
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                controller: requestController,
                labelText: "Ci sono richieste paricolari?",
              ),
              CustomTextField(
                controller: tableController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                labelText: "Inserire il numero del tavolo",
              ),
              ElevatedButton(
                child: const Text("Invia ordine"),
                onPressed: () async {
                  try{
                    List<int?>  values = myDictionary.values.toList();
                    List<String?> keys = myDictionary.keys.toList();

                    String tableNumberFormatted = tableController.text.replaceAll(',', '.');
                    double myNumber = double.parse(tableNumberFormatted);
                    if (tableController.text.isEmpty) {
                      await  notTableNumber(isTable : true);

                    }

                    if (keys.isEmpty) {

                      await notTableNumber(isTable: false);
                    }
                    else {

                      createOrder();
                    }
                    // Navigator.pop(context);
                  }catch(e){
                    showModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      isScrollControlled: true,
                      isDismissible: true,
                      builder: (context) => Container(
                        height: 200,
                        child: Column(
                          children: [
                            const Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'inserire un numero di tavolo valido',
                                  style: TextStyle(fontSize: 15, color: Colors.red),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CupertinoButton(
                                child: const Text('chiudi'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );

                  }
                },
              )
            ],
          ))
        ],
      ),
    )
    /*
    Scaffold(
      body:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: IconButton(
                  icon: Icon(CupertinoIcons.arrow_down_circle_fill),
                  onPressed: () {
                   setState(() {
                     index=0;
                   });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 220,
                width: 350,
                child: ListView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, int index) {

                    List<int?>  values = myDictionary.values.toList();
                    List<String?> keys = myDictionary.keys.toList();

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (values[index]! != 0) ...[
                          Expanded(child:Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              keys[index]!,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis
                              ),
                            ),
                          ),),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "   X ${values[index].toString()}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ],
                    );
                  },
                  itemCount: myDictionary.length,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
              child: TextFormField(
                  controller: requestController,
                  textAlign: TextAlign.center,

                  decoration:
                  InputDecoration(hintText: 'ci sono richieste particolari?')),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: TextFormField(
                  controller: tableController,
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true
                  ),
                  textAlign: TextAlign.center,

                  decoration:
                  InputDecoration(hintText: 'inserire il numero del tavolo')),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CupertinoButton(
                child: Text('invia ordine'),
                onPressed: () async {
                  try{
                    List<int?>  values = myDictionary.values.toList();
                    List<String?> keys = myDictionary.keys.toList();

                    String tableNumberFormatted = tableController.text.replaceAll(',', '.');
                    double myNumber = double.parse(tableNumberFormatted);
                    if (tableController.text.isEmpty) {
                      await  notTableNumber(isTable : true);

                    }

                    if (keys.isEmpty) {

                      await notTableNumber(isTable: false);
                    }
                    else {

                      createOrder();
                    }
                    // Navigator.pop(context);
                  }catch(e){
                    showModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      isScrollControlled: true,
                      isDismissible: true,
                      builder: (context) => Container(
                        height: 200,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'inserire un numero di tavolo valido',
                                  style: TextStyle(fontSize: 15, color: Colors.red),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CupertinoButton(
                                child: Text('chiudi'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );

                  }
                },
              ),
            )
          ],
        ),
      ),
    )

     */

    ;
  }


  void createOrder() async {
    CollectionReference<Map<String, dynamic>> tableCollection =
    FirebaseFirestore.instance.collection('tables');

    int check = 0;

    String tableNumberFormatted = tableController.text.replaceAll(',', '.');
    double myNumber = double.parse(tableNumberFormatted);

    await tableCollection.get().then(
          (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          if (docSnapshot.data()['fakeNumber'] == myNumber) {
            check++;
            List<String?> list = [];
            List<String?> foodNameList=[];
            List<int> quantityList=[];
            myDictionary.forEach((key, value) {
              if (value != 0) {
                String temp = '$value x $key ';
                list.add(temp);

                String foodName= key;
                int quantity = value;

                foodNameList.add(foodName);
                quantityList.add(quantity);

              }
            });
            const uuid = Uuid();
            String id = uuid.v1();
            DateTime now = DateTime.now();
            String date = '${now.hour} : ${now.minute}';
            DatabaseComanda databaseComanda = DatabaseComanda();
            Comanda comanda = Comanda(
                isGathered: false,
                request: requestController.text.isEmpty ? " " : requestController.text,
                quantityList: quantityList,
                foodNameList: foodNameList,
                isActive: false,
                createdAt: DateTime.now(),
                id: id,
                tableNumber: myNumber,
                list: list,
                time: date);
            databaseComanda.createEdit(comanda: comanda, isEdit: false);

            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => CupertinoAlertDialog(
                  title: const Text('ordine inviato con successo'),
                  actions: [
                    CupertinoDialogAction(child: const Text('torna al menu'),onPressed: (){
                     setState(() {
                       myDictionary.clear();
                       requestController.clear();
                       tableController.clear();
                       index=0;
                     });
                     Navigator.pop(context);
                    },)
                  ],
                )  );
          }
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    if (check == 0) {

      showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        builder: (context) => Container(
          height: 200,
          child: Column(
            children: [
              const Padding(
                padding:EdgeInsets.all(8.0),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'inserire un numero di tavolo valido',
                    style: TextStyle(fontSize: 15, color: Colors.red),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoButton(
                  child: Text('chiudi'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  Future  notTableNumber({required bool isTable}) async {
    await  showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) =>
          Container(
            height: 200,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    isTable ? 'inserire un numero di tavolo valido' : 'inserire dei cibi prima di ordinare',
                    style: const TextStyle(fontSize: 15, color: Colors.red),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoButton(
                    child: const Text('chiudi'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
    );
  }
}




List<Food?> getActiveFood(List<Food?> list, String course) {
  List<Food?> foodList = [];

  for (int i = 0; i < list.length; i++) {
    FoodCategory currentCourse = list[i]!.category;
    if (currentCourse.toString() == course && list[i]!.active) {
      foodList.add(list[i]);
    }
  }
  return foodList;
}




