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

  late Stream<List<Food?>> myStream;

  @override
  void initState( ) {

    myStream = DatabaseFood.allFood;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(
        title: Text(restourantName),
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
                      allFood, 'FoodCategory.aperitifs');
                  List<Food?> appetizersList = getRightFood(
                      allFood, 'FoodCategory.appetizers');
                  List<Food?> maindishesList = getRightFood(
                      allFood, 'FoodCategory.mainDishes');
                  List<Food?> secondCoursesList = getRightFood(
                      allFood, 'FoodCategory.secondCourses');
                  List<Food?> sideDishesList = getRightFood(
                      allFood, 'FoodCategory.sideDishes');
                  List<Food?> dessertList = getRightFood(
                      allFood, 'FoodCategory.dessert');
                  List<Food?> nonAlcoholicList = getRightFood(
                      allFood, 'FoodCategory.nonAlcoholic');
                  List<Food?> beersList = getRightFood(
                      allFood, 'FoodCategory.beers');
                  List<Food?> winesList = getRightFood(
                      allFood, 'FoodCategory.wines');

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
                                    return FoodCardMenu(food: allFoodInList[i][index]!);
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
/*
*  Column(
              children: [
                for(var foodCategory in FoodCategory.values)CustomExpansionTile(
                    title: translateFodCategory(foodCategory: foodCategory),
                  children: [
                    for(var food in provaListaMenu)if(food.category == foodCategory)FoodCardMenu(food: food,)
                  ],
                ),
              ],
            ),
* */