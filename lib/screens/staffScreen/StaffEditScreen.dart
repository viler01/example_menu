import 'package:example_menu/models/allergen_model.dart';
import 'package:example_menu/widgets/GeneralWidget/MyBackground.dart';
import 'package:example_menu/widgets/costumersWidgets/alleargenWidgets.dart';
import 'package:example_menu/widgets/staffWidgets/StaffBottomBar.dart';
import 'package:example_menu/widgets/staffWidgets/StaffTitle.dart';
import '../../services/imports.dart';

class StaffEditScreen extends StatefulWidget {
  final UserData? userData;

  final Food? food;

  StaffEditScreen(
      {required this.userData,  required this.food});


  @override
  State<StaffEditScreen> createState() => _StaffEditScreenState();
}

class _StaffEditScreenState extends State<StaffEditScreen> {

  DatabaseUser databaseUser = DatabaseUser();
  final _formKey = GlobalKey<FormState>();

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
/*
  TextEditingController name1 = TextEditingController();
  TextEditingController descriptionIT1 = TextEditingController();
  TextEditingController descriptionING1 = TextEditingController();
  TextEditingController price1 = TextEditingController();
  TextEditingController descriptionDE1 = TextEditingController();
  TextEditingController descriptionFR1 = TextEditingController();
*/

  TextEditingController nameIT = TextEditingController();
  TextEditingController nameENG = TextEditingController();
  TextEditingController descriptionITA = TextEditingController();
  TextEditingController descriptionENG = TextEditingController();
  TextEditingController price = TextEditingController();

  FoodCategory foodCategory = FoodCategory.mainDishes;
  List<Allergens> foodAllegyList =[];
  List<Allergens> allergyList=[  Allergens.fish,
    Allergens.lupins,
    Allergens.shellfish,
    Allergens.eggs,
    Allergens.milk,
    Allergens.sulphite,
    Allergens.gluten,
    Allergens.soya,
    Allergens.nuts,
    Allergens.sesame,
    Allergens.crustacen,
    Allergens.mustard,
    Allergens.mustard,
    Allergens.celery];
  List<bool> boolList= [false,false,false,
    false,false,false,
    false,false,false,
    false,false,false,
    false,false];


  @override
  void initState() {
    super.initState();

   nameIT = TextEditingController(text: widget.food!.nameITA);
   nameENG = TextEditingController(text: widget.food!.nameENG);
   descriptionITA = TextEditingController(text: widget.food!.descriptionITA);
   descriptionENG = TextEditingController(text: widget.food!.descriptionENG);
   price = TextEditingController(text: widget.food!.price.toString());

   for(int i =0;i< allergyList.length;i++){
     for(int j=0;j< widget.food!.allergens.length; j++){
       if(allergyList[i]== widget.food!.allergens[j]){
         setState(() {
           boolList[i] = true;
           foodAllegyList.add(allergyList[i]);
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
       foodCategory= FoodCategory.nonAlcoholic;
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
      bottomNavigationBar: const StaffBottomBar(),
      body: CustomPaint(
        painter: MyBackground(),
        child: Container(
          height: double.infinity,
          child: SafeArea(
            child: LayoutBuilder(
                builder: (context, constraints){
                  if(constraints.maxWidth > horizontalLayout){
                    return const CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: StaffTitle(title: 'Aggiungi Portata',),
                        ),
                        SliverCrossAxisGroup(
                            slivers: [
                              SliverMainAxisGroup(
                                  slivers: [
                                    SliverToBoxAdapter(
                                      child: Name(),
                                    ),
                                    SliverToBoxAdapter(
                                      child: Price(),
                                    ),
                                  ]
                              ),
                              SliverMainAxisGroup(
                                  slivers: [
                                    SliverToBoxAdapter(
                                      child: Description(),
                                    ),
                                    SliverToBoxAdapter(
                                      child: Category(),
                                    ),
                                    SliverToBoxAdapter(
                                      child: FoodImage(),
                                    )
                                  ]
                              ),
                            ]
                        ),
                        AllergensCheckGrid(),
                        SliverToBoxAdapter(
                            child: SubmitButton()
                        )
                      ],
                    );
                  }else{
                    return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: StaffTitle(title: 'Aggiungi Portata',),
                        ),
                        SliverToBoxAdapter(
                          child: Name(),
                        ),
                        SliverToBoxAdapter(
                          child: Description(),
                        ),
                        SliverToBoxAdapter(
                          child: Price(),
                        ),
                        SliverToBoxAdapter(
                          child: Category(),
                        ),
                        SliverToBoxAdapter(
                          child: FoodImage(),
                        ),
                        AllergensCheckGrid(),
                        SliverToBoxAdapter(
                          child: SubmitButton(),
                        )
                      ],
                    );
                  }
                }
            )
          ),
        ),
      ),
    );
  }
}

class FoodImage extends StatelessWidget {
  const FoodImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("IMMAGINE:", style: addTextStile,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  border: Border.all(
                    color: mainColor,
                  )
                ),
                child: TextButton(
                  onPressed: (){},
                  child: Text('Inserisci immagine'),
                ),
              ),
            ),
          ]
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(100,100))
      ),
        onPressed: (){},
        child: Text(
            'Aggiungi',
          style: addTextStile,
      ),
    );
  }
}

class AllergensCheckGrid extends StatelessWidget {
  const AllergensCheckGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            width: double.infinity,
              alignment: Alignment.center,
              child: Text("ALLERGENI:", style: addTextStile,)),
        ),
        SliverLayoutBuilder(
            builder: (builder, constraints){
              int division = constraints.crossAxisExtent ~/ 250;
              return SliverGrid.count(
                crossAxisCount: division,
                childAspectRatio: 5/1,
                children: [
                  for(var allergen in Allergen.returnAllergen(Allergens.values))AllergensCheckListTile(
                    allergen: allergen,
                    onChange: (value){},
                  ),
                ],
              );
            }
        ),
      ],
    );
  }
}

class AllergensCheckListTile extends StatefulWidget {
  AllergensCheckListTile({
    super.key,
    required this.allergen,
    required this.onChange
  });

  final Allergen allergen;
  final Function(bool) onChange;

  @override
  State<AllergensCheckListTile> createState() => _AllergensCheckListTileState();
}

class _AllergensCheckListTileState extends State<AllergensCheckListTile> {
  bool addingAllergen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(
            width: 1,
            color: Colors.black
        )
      ),
      child: ListTile(
        title: Text(translateAllergen(widget.allergen)),
        trailing: AllergenIcon(assetName: widget.allergen.svgDirectory,),
        leading: Checkbox(
            value: addingAllergen,
            onChanged: (value){
              setState(() {
                addingAllergen = value!;
              });
              widget.onChange(value!);
            }
        ),
        onTap: (){
          setState(() {
            addingAllergen = !addingAllergen;
          });
          widget.onChange(addingAllergen!);
        },
      ),
    );
  }
}

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  var dropDownValue = FoodCategory.values.first;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("CATEGORIA:", style: addTextStile,),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: DropdownButton(
              items: FoodCategory.values.map<DropdownMenuItem<FoodCategory>>((FoodCategory value) {
                return DropdownMenuItem<FoodCategory>(
                  value: value,
                  child: Text(translateFodCategory(foodCategory: value)),
                );
              }).toList(),
              onChanged: (value){
                setState(() {
                  dropDownValue = value!;
                });
              },
              value: dropDownValue,
            ),
          ),
        ],
      ),
    );
  }
}


class Price extends StatelessWidget {
  const Price({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("PREZZO", style: addTextStile,),
        CustomTextField(
          labelText: "PREZZO",
          prefixText: "€  ",
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        )
      ],
    );
  }
}

class Description extends StatelessWidget {
  const Description({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("DESCIZIONE", style: addTextStile,),
        //DESCIZIONE ITALIANO
        CustomTextField(labelText: "ITALIANO",),

        //DESCIZIONE INGLESE
        CustomTextField(labelText: "INGLESE",),
      ],
    );
  }
}

class Name extends StatelessWidget {
  const Name({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("NOME",style: addTextStile,),
        //NOME ITALIANO
        CustomTextField(labelText: "ITALIANO",),

        //NOME INGLESE
        CustomTextField(labelText: "INGLESE",)
      ],
    );
  }
}
