import 'package:example_menu/widgets/costumersWidgets/foodCardMenuExample.dart';

import '../services/imports.dart';
import 'package:flutter/cupertino.dart';

class ExampleScreen1 extends StatefulWidget {
  const ExampleScreen1({super.key});

  @override
  State<ExampleScreen1> createState() => _ExampleScreen1State();
}

class _ExampleScreen1State extends State<ExampleScreen1> {
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
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    index = 1;
                  });
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.green,
                ))
          ],
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
                      Center(child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back))),
                      for (int i = 0; i < FoodCategory.values.length; i++) ...[
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, int index) {
                                        return FoodCardMenuExample(
                                            food: allFoodInList[i][index]!);
                                      },
                                      itemCount: allFoodInList[i].length,
                                    ),
                                  )
                          ],
                        )
                      ]
                    ]);
                  }),
            ),
          ),
        ));
  }
}
