import 'package:example_menu/models/allergen_model.dart';
import 'package:example_menu/widgets/GeneralWidget/MyBackground.dart';
import 'package:example_menu/widgets/costumersWidgets/alleargenWidgets.dart';
import 'package:example_menu/widgets/staffWidgets/StaffTitle.dart';
import '../../services/imports.dart';

class StaffEditScreen extends StatefulWidget {
  final Food? food;

  StaffEditScreen({required this.food});

  @override
  State<StaffEditScreen> createState() => _StaffEditScreenState();
}

class _StaffEditScreenState extends State<StaffEditScreen> {
  DatabaseUser databaseUser = DatabaseUser();

  bool showLoading = false;

  Uint8List? _fileBytes;
  String error = '';
  String imageName = '';

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    if (mounted) {
      setState(() {
        setState(() {
          _fileBytes = result.files.first.bytes;
          imageName = result.files.first.name;
        });
      });
    }
  }

  TextEditingController nameIT = TextEditingController();
  TextEditingController nameENG = TextEditingController();
  TextEditingController descriptionITA = TextEditingController();
  TextEditingController descriptionENG = TextEditingController();
  TextEditingController price = TextEditingController();

  FoodCategory foodCategory = FoodCategory.mainDishes;
  List<String> foodAllergyList = [];
  List<String> allAllergensList = [
    'Allergens.fish',
    'Allergens.lupins',
    'Allergens.shellfish',
    'Allergens.eggs',
    'Allergens.milk',
    'Allergens.sulphite',
    'Allergens.gluten',
    'Allergens.soya',
    'Allergens.nuts',
    'Allergens.sesame',
    'Allergens.crustacen',
    'Allergens.mustard',
    'Allergens.mustard',
    'Allergens.celery'
  ];
  List<bool> boolList = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  late FoodCategory dropDownValue ;

  @override
  void initState() {
    super.initState();

    nameIT = TextEditingController(text: widget.food!.nameITA);
    nameENG = TextEditingController(text: widget.food!.nameENG);
    descriptionITA = TextEditingController(text: widget.food!.descriptionITA);
    descriptionENG = TextEditingController(text: widget.food!.descriptionENG);
    price = TextEditingController(text: widget.food!.price.toString());

    dropDownValue= widget.food!.category;

    for (int i = 0; i < allAllergensList.length; i++) {
      for (int j = 0; j < widget.food!.allergens.length; j++) {
        if (allAllergensList[i] == widget.food!.allergens[j]) {
          setState(() {
            boolList[i] = true;
            foodAllergyList.add(allAllergensList[i]);
          });
        }
      }
    }

    switch (widget.food!.category) {
      case FoodCategory.appetizers:
        foodCategory = FoodCategory.appetizers;
        return;
      case FoodCategory.mainDishes:
        foodCategory = FoodCategory.mainDishes;
        return;
      case FoodCategory.secondCourses:
        foodCategory = FoodCategory.secondCourses;
        return;
      case FoodCategory.sideDishes:
        foodCategory = FoodCategory.sideDishes;
        return;
      case FoodCategory.dessert:
        foodCategory = FoodCategory.dessert;
        return;
      case FoodCategory.nonAlcoholic:
        foodCategory = FoodCategory.nonAlcoholic;
        return;
      case FoodCategory.beers:
        foodCategory = FoodCategory.beers;
        return;
      case FoodCategory.aperitifs:
        foodCategory = FoodCategory.aperitifs;
        return;
      case FoodCategory.wines:
        foodCategory = FoodCategory.wines;
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: const StaffBottomBar(),
      body: CustomPaint(
        painter: MyBackground(),
        child: Container(
          height: double.infinity,
          child: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > horizontalLayout) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: StaffTitle(
                      title: 'Edit Dish',
                    ),
                  ),
                  SliverCrossAxisGroup(slivers: [
                    SliverMainAxisGroup(slivers: [
                      SliverToBoxAdapter(
                        child: Name(
                          nameENG: nameENG,
                          nameITA: nameIT,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Price(
                          price: price,
                        ),
                      ),
                    ]),
                    SliverMainAxisGroup(slivers: [
                      SliverToBoxAdapter(
                        child: Description(
                          descriptionITA: descriptionITA,
                          descriptionENG: descriptionENG,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "CATEGORIA:",
                                style: addTextStile,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: DropdownButton(
                                  items: FoodCategory.values
                                      .map<DropdownMenuItem<FoodCategory>>(
                                          (FoodCategory value) {
                                    return DropdownMenuItem<FoodCategory>(
                                      value: value,
                                      child: Text(translateFoodCategory(
                                          foodCategory: value)),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      dropDownValue = value!;
                                    });
                                  },
                                  value: dropDownValue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "IMMAGINE:",
                                  style: addTextStile,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                        border: Border.all(
                                          color: mainColor,
                                        )),
                                    child: TextButton(
                                      onPressed: pickImage,
                                      child: Text('Inserisci immagine'),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: _fileBytes == null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 300,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                    widget.food!.image,
                                  ))),
                                ))
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.memory(
                                  _fileBytes!,
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 200,
                                ),
                              ),
                      )
                    ]),
                  ]),
                  SliverMainAxisGroup(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                              "ALLERGENI:",
                              style: addTextStile,
                            )),
                      ),
                      SliverLayoutBuilder(builder: (builder, constraints) {
                        int division = constraints.crossAxisExtent ~/ 250;
                        return SliverGrid.count(
                          crossAxisCount: division,
                          childAspectRatio: 5 / 1,
                          children: [
                            for (int i = 0; i < Allergen.returnAllergen(Allergens.values).length; i++)
                              AllergensCheckListTile(
                                callback: (){
                                  setState(() {
                                    boolList[i]=!boolList[i];
                                    if(boolList[i]){
                                      foodAllergyList.add(allAllergensList[i]);
                                    }else{
                                      foodAllergyList.remove(allAllergensList[i]);
                                    }
                                  });

                                },
                                isSelected: boolList[i],
                                allergen: Allergen.returnAllergen(
                                    Allergens.values)[i],

                              )
                          ],
                        );
                      }),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: TextButton(
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(Size(100, 100))),
                      onPressed: () async {
                        DatabaseFood databaseFood = DatabaseFood();
                        try {
                          if (_fileBytes == null) {
                            Food food = Food(
                                id: widget.food!.id,
                                nameITA: nameIT.text,
                                nameENG: nameENG.text,
                                price: double.parse(price.text),
                                descriptionENG: descriptionENG.text,
                                descriptionITA: descriptionITA.text,
                                image: widget.food!.image,
                                category: dropDownValue,
                                active: true,
                                allergens: foodAllergyList);
                            await databaseFood
                                .createEdit(food: food, isEdit: true)
                                .then((value) {
                              Navigator.pop(context);
                            });
                          } else {
                            Storage storage = Storage();

                            String? url = await storage.uploadImage(
                                _fileBytes!, widget.food!.id);

                            Food food = Food(
                                id: widget.food!.id,
                                nameITA: nameIT.text,
                                nameENG: nameENG.text,
                                price: double.parse(price.text),
                                descriptionENG: descriptionENG.text,
                                descriptionITA: descriptionITA.text,
                                image: url!,
                                category: dropDownValue,
                                active: true,
                                allergens: foodAllergyList);

                            await databaseFood
                                .createEdit(food: food, isEdit: true)
                                .then((value) {
                              Navigator.pop(context);
                            });
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text(
                        'Aggiungi',
                        style: addTextStile,
                      ),
                    ),
                  )
                ],
              );
            } else {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: StaffTitle(
                      title: 'Aggiungi Portata',
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Name(
                      nameENG: nameENG,
                      nameITA: nameIT,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Description(
                      descriptionITA: descriptionITA,
                      descriptionENG: descriptionENG,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Price(
                      price: price,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "CATEGORIA:",
                            style: addTextStile,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: DropdownButton(
                              items: FoodCategory.values
                                  .map<DropdownMenuItem<FoodCategory>>(
                                      (FoodCategory value) {
                                return DropdownMenuItem<FoodCategory>(

                                  value: value,
                                  child: Text(translateFoodCategory(
                                      foodCategory: value)),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  dropDownValue = value!;

                                });
                              },
                              value: dropDownValue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "IMMAGINE:",
                              style: addTextStile,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    border: Border.all(
                                      color: mainColor,
                                    )),
                                child: TextButton(
                                  onPressed: pickImage,
                                  child: Text('Inserisci immagine'),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _fileBytes == null
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 300,
                              width: 300,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                widget.food!.image,
                              ))),
                            ))
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.memory(
                              _fileBytes!,
                              fit: BoxFit.cover,
                              width: 200,
                              height: 200,
                            ),
                          ),
                  ),
                  SliverMainAxisGroup(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                              "ALLERGENI:",
                              style: addTextStile,
                            )),
                      ),
                      SliverLayoutBuilder(builder: (builder, constraints) {
                        int division = constraints.crossAxisExtent ~/ 250;
                        return SliverGrid.count(
                          crossAxisCount: division,
                          childAspectRatio: 5 / 1,
                          children: [
                            for (int i = 0; i < Allergen.returnAllergen(Allergens.values).length; i++)
                              AllergensCheckListTile(
                                callback: (){
                                  setState(() {
                                    boolList[i]=!boolList[i];
                                    if(boolList[i]){
                                      foodAllergyList.add(allAllergensList[i]);
                                    }else{
                                      foodAllergyList.remove(allAllergensList[i]);
                                    }

                                  });
                                },
                                isSelected: boolList[i],
                                allergen: Allergen.returnAllergen(
                                    Allergens.values)[i],

                              )
                          ],
                        );
                      }),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: TextButton(
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(Size(100, 100))),
                      onPressed: () async {
                        DatabaseFood databaseFood = DatabaseFood();
                        try {
                          if (_fileBytes == null) {
                            Food food = Food(
                                id: widget.food!.id,
                                nameITA: nameIT.text,
                                nameENG: nameENG.text,
                                price: double.parse(price.text),
                                descriptionENG: descriptionENG.text,
                                descriptionITA: descriptionITA.text,
                                image: widget.food!.image,
                                category: dropDownValue,
                                active: true,
                                allergens: foodAllergyList);
                            await databaseFood
                                .createEdit(food: food, isEdit: true)
                                .then((value) {
                              Navigator.pop(context);
                            });
                          } else {
                            Storage storage = Storage();

                            String? url = await storage.uploadImage(
                                _fileBytes!, widget.food!.id);

                            Food food = Food(
                                id: widget.food!.id,
                                nameITA: nameIT.text,
                                nameENG: nameENG.text,
                                price: double.parse(price.text),
                                descriptionENG: descriptionENG.text,
                                descriptionITA: descriptionITA.text,
                                image: url!,
                                category: dropDownValue,
                                active: true,
                                allergens: foodAllergyList);

                            await databaseFood
                                .createEdit(food: food, isEdit: true)
                                .then((value) {
                              Navigator.pop(context);
                            });
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text(
                        'Aggiungi',
                        style: addTextStile,
                      ),
                    ),
                  )
                ],
              );
            }
          })),
        ),
      ),
    );
  }
}

class AllergensCheckListTile extends StatefulWidget {
  AllergensCheckListTile({
    required this.allergen,
 required this.callback,
   required this.isSelected,
  });

  final Allergen allergen;
  final VoidCallback callback;
  final bool isSelected;

  @override
  State<AllergensCheckListTile> createState() => _AllergensCheckListTileState();
}

class _AllergensCheckListTileState extends State<AllergensCheckListTile> {


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: widget.isSelected
              ?secondaryColor
              :null,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1, color: Colors.black)),
      child: ListTile(
        title: Text(translateAllergen(widget.allergen)),
        trailing: AllergenIcon(
          assetName: widget.allergen.svgDirectory,
        ),
        onTap: widget.callback,
      ),
    );
  }
}
