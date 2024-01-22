//PizzaHomePage
import 'package:example_menu/widgets/costumersWidgets/foodCardMenuExample.dart';

import 'package:example_menu/services/imports.dart';
import 'package:flutter/cupertino.dart';

class PizzaHomePage extends StatefulWidget {
  const PizzaHomePage({super.key});

  @override
  State<PizzaHomePage> createState() => _PizzaHomePageState();
}

class _PizzaHomePageState extends State<PizzaHomePage> {
  int addValue = 1;
  int subValue = 1;
  double iconPadding = 4;

  int index = 0;
  TextEditingController tableController = TextEditingController();
  TextEditingController requestController = TextEditingController();

  late Stream<List<Food?>> myStream;

  @override
  void initState() {
    myStream = DatabaseFood.allFood3;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(restourantName),
        ),
        body: CustomPaint(
          painter: MyBackground(),
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: StreamBuilder<List<Food?>>(
                  stream: myStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Food?>> snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingWidget();
                    }

                    List<Food?> allFood = snapshot.data!;

                    List<Food?> aperitifsList =
                        getRightFood(allFood, 'FoodCategory.aperitifs', false);
                    List<Food?> appetizersList =
                        getRightFood(allFood, 'FoodCategory.appetizers', false);
                    List<Food?> maindishesList =
                        getRightFood(allFood, 'FoodCategory.mainDishes', false);
                    List<Food?> secondCoursesList = getRightFood(
                        allFood, 'FoodCategory.secondCourses', false);
                    List<Food?> sideDishesList =
                        getRightFood(allFood, 'FoodCategory.sideDishes', false);
                    List<Food?> dessertList =
                        getRightFood(allFood, 'FoodCategory.dessert', false);
                    List<Food?> nonAlcoholicList = getRightFood(
                        allFood, 'FoodCategory.nonAlcoholic', false);
                    List<Food?> beersList =
                        getRightFood(allFood, 'FoodCategory.beers', false);
                    List<Food?> winesList =
                        getRightFood(allFood, 'FoodCategory.wines', false);

                    List<List<Food?>> allFoodInList = [
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

                    return Column(children: [
                      for (int i = 0; i < FoodCategory.values.length; i++) ...[
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            height: 45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  translateFoodCategory(
                                      foodCategory: FoodCategory.values[i]),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Icon(Icons.navigate_next)
                              ],
                            ),
                          ),
                          onTap: () {
                            print(allFoodInList);
                            print("------------");
                            print(allFoodInList[
                                i]); //da trasmettere alla pagina di visualizzazione delle pizze
                            print("------------");
                            print(allFoodInList.runtimeType);
                            print(allFoodInList[i].runtimeType);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return VisualPizzaScreen(foods: allFoodInList[i]);
                            }));
                          },
                        )
                      ]
                    ]);
                  }),
            ),
          ),
        ));
  }
}
