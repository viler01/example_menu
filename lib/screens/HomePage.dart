import 'package:example_menu/GlobalVariable.dart';
import 'package:example_menu/models/language_model.dart';
import 'package:example_menu/widgets/GeneralWidget/MyBackground.dart';
import 'package:example_menu/widgets/costumersWidgets/FoodCardMenu.dart';
import '../services/imports.dart';

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


    return Scaffold(


      appBar: AppBar(
        title: Text(restourantName),
        actions: [
          IconButton(
              onPressed: () {
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
                });
              },
              icon: Icon(
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
                              child: AppDirector());
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
                                  ? Center(
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