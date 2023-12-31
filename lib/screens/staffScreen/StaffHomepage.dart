import 'package:example_menu/screens/staffScreen/StaffEditScreen.dart';
import 'package:example_menu/widgets/GeneralWidget/MyBackground.dart';
import 'package:example_menu/widgets/staffWidgets/StaffActiveFoodCard.dart';
import 'package:example_menu/widgets/staffWidgets/StaffTitle.dart';
import '../../services/imports.dart';

class StaffHomepage extends StatefulWidget {
  const StaffHomepage({super.key});

  @override
  State<StaffHomepage> createState() => _StaffHomepageState();
}

class _StaffHomepageState extends State<StaffHomepage> {

  late Stream  myStream;

  @override
  void initState( ) {

    myStream = FirebaseFirestore.instance
        .collection('foods').snapshots();

    super.initState();
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: CustomPaint(
        painter: MyBackground(),
        child: Container(
          height: double.infinity,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StaffTitle(title: 'Gestione del menù'),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Container(
                        width: constraints.maxWidth > horizontalLayout
                                ? horizontalLayout - 60 //60 è il padding dei due lati
                                : null,
                        child: StreamBuilder(
                            stream: myStream,
                            builder: (BuildContext context,
                                AsyncSnapshot  snapshot) {
                              if (snapshot.hasError) {
                                print(snapshot.error);
                                return const Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const LoadingWidget();
                              }

                              final  allFoodSnapshot = snapshot.data!.docs;

                              List <Food?> allFood = [];

                              for (int i = 0; i < allFoodSnapshot.length; i++){
                                Food food  =  DatabaseFood.foodFromSnapshot(allFoodSnapshot[i])!;

                                allFood.add(food);
                              }

                              List<Food?> aperitifsList = getRightFood(
                                  allFood, 'FoodCategory.aperitifs',true);
                              List<Food?> appetizersList = getRightFood(
                                  allFood, 'FoodCategory.appetizers',true);
                              List<Food?> maindishesList = getRightFood(
                                  allFood, 'FoodCategory.mainDishes',true);
                              List<Food?> secondCoursesList = getRightFood(
                                  allFood, 'FoodCategory.secondCourses',true);
                              List<Food?> sideDishesList = getRightFood(
                                  allFood, 'FoodCategory.sideDishes',true);
                              List<Food?> dessertList = getRightFood(
                                  allFood, 'FoodCategory.dessert',true);
                              List<Food?> nonAlcoholicList = getRightFood(
                                  allFood, 'FoodCategory.nonAlcoholic',true);
                              List<Food?> beersList = getRightFood(
                                  allFood, 'FoodCategory.beers',true);
                              List<Food?> winesList = getRightFood(
                                  allFood, 'FoodCategory.wines',true);

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
                                          return StaffActiveFoodCard(
                                            food: allFoodInList[i][index]!,
                                            active: (value) {
                                              DatabaseFood databaseFood =
                                              DatabaseFood();
                                              Food food = Food(
                                                  allergens: allFoodInList[i][index]!.allergens,
                                                  nameENG: allFoodInList[i][index]!.nameENG,
                                                  nameITA: allFoodInList[i][index]!.nameITA,
                                                  category: allFoodInList[i][index]!.category,
                                                  price: allFoodInList[i][index]!.price,
                                                  id: allFoodInList[i][index]!.id,
                                                  descriptionENG:allFoodInList[i][index]!.descriptionENG,
                                                  descriptionITA: allFoodInList[i][index]!.descriptionITA,
                                                  image: allFoodInList[i][index]!.image,
                                                  active: !allFoodInList[i][index]!.active);

                                              databaseFood.createEdit(
                                                  food: food, isEdit: true);
                                              setState(() {
                                                value = allFoodInList[i][index]!.active;
                                              });
                                            },
                                            edit: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                                return StaffEditScreen( food: allFoodInList[i][index]);
                                              }));

                                            },
                                          );
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
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      //bottomNavigationBar: const StaffBottomBar(),
    );
  }
}

class StaffLayoutBuilder extends StatelessWidget {
  StaffLayoutBuilder(
      {super.key, required this.maxWidth, required this.children});

  final double maxWidth;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    switch (maxWidth) {
      case > horizontalLayout:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: maxWidth / 2,
              child: Column(
                children: children.sublist(0, children.length ~/ 2),
              ),
            ),
            Container(
              width: maxWidth / 2,
              child: Column(
                children: children.sublist(children.length ~/ 2),
              ),
            )

          ],
        );
      default:
        return Column(
          children: children,
        );
    }
  }
}
