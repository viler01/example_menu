import '../../services/imports.dart';
import 'package:example_menu/models/allergen_model.dart';
import 'package:example_menu/widgets/GeneralWidget/MyBackground.dart';
import 'package:example_menu/widgets/costumersWidgets/alleargenWidgets.dart';
import 'package:example_menu/widgets/staffWidgets/StaffTitle.dart';

class StaffAddScreen extends StatefulWidget {
  const StaffAddScreen({super.key});

  @override
  State<StaffAddScreen> createState() => _StaffAddScreenState();
}

class _StaffAddScreenState extends State<StaffAddScreen> {
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
  List<String> foodAllegyList = [];
  List<Allergens> allAllergensList = [ Allergens.fish,
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

  List<bool> boolList = [false, false, false,
    false, false, false,
    false, false, false,
    false, false, false,
    false, false];

  var dropDownValue = FoodCategory.values.first;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: const StaffBottomBar(),
      body: CustomPaint(
        painter: MyBackground(),
        child: Container(
          height: double.infinity,
          child: SafeArea(
              child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > horizontalLayout) {
                      return  CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: StaffTitle(title: 'Aggiungi piatto',),
                          ),
                          SliverCrossAxisGroup(
                              slivers: [
                                SliverMainAxisGroup(
                                    slivers: [
                                      SliverToBoxAdapter(
                                        child: Name(
                                          nameENG: nameENG,
                                          nameITA: nameIT,
                                        ),
                                      ),
                                      SliverToBoxAdapter(
                                        child: Price(price: price,),
                                      ),
                                    ]
                                ),
                                SliverMainAxisGroup(
                                    slivers: [
                                      SliverToBoxAdapter(
                                        child: Description(descriptionITA: descriptionITA,descriptionENG: descriptionENG,),
                                      ),
                                      SliverToBoxAdapter(
                                        child:  Container(
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
                                                      child: Text(translateFoodCategory(foodCategory: value)),
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
                                        ),
                                      ),
                                      SliverToBoxAdapter(
                                        child: Padding(
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
                                                      onPressed:pickImage,
                                                      child: Text('Inserisci immagine'),
                                                    ),
                                                  ),
                                                ),
                                              ]
                                          ),
                                        ),
                                      ),
                                      SliverToBoxAdapter(
                                        child:     Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: _fileBytes == null
                                                ? Text('no image selected')
                                                : Image.memory(
                                              _fileBytes!,
                                              fit: BoxFit.cover,
                                              width: 100,
                                              height: 100,
                                            ),
                                        ) ,
                                      )
                                    ]
                                ),
                              ]
                          ),
                          AllergensCheckGrid(
                            allAllergenList: allAllergensList,
                            allergenList: foodAllegyList,
                          ),
                          SliverToBoxAdapter(
                              child:TextButton(
                                style:
                                ButtonStyle(minimumSize: MaterialStateProperty.all(Size(100, 100))),
                                onPressed: () async {
                                  DatabaseFood databaseFood = DatabaseFood();
                                  try{
                                    if (_fileBytes == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('inserire un immagine valida'),
                                        ),
                                      );
                                    } else {


                                      const uuid = Uuid();
                                      String id = uuid.v1();

                                      Storage storage = Storage();

                                        String? url = await storage.uploadImage(_fileBytes!, id);

                                        if(double.tryParse(price.text) != null && nameENG.text != ''){

                                          Food food = Food(
                                              id: id,
                                              nameITA: nameIT.text,
                                              nameENG: nameENG.text,
                                              price: double.parse(price.text),
                                              descriptionENG: descriptionENG.text,
                                              descriptionITA: descriptionITA.text,
                                              image: url!,
                                              category: dropDownValue,
                                              active: true,
                                              allergens: foodAllegyList
                                          );

                                          await databaseFood.createEdit(food: food, isEdit: false).then((value) {
                                            setState(() {
                                              nameIT.clear();
                                              nameENG.clear();
                                              descriptionITA.clear();
                                              descriptionENG.clear();
                                              price.clear();
                                             foodAllegyList.clear();
                                              for(String item in foodAllegyList){
                                                print(item);
                                              }
                                              for(int i=0;i<boolList.length;i++){
                                                boolList[i]=false;
                                              }

                                              _fileBytes= null;
                                            });

                                            //TODO make code to change the body of homepage in order to go back to staffhomepage without fucking up the stream builder
                                          });
                                        }else{
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('inserire un prezzo e un nome  valido'),
                                            ),
                                          );
                                        }

                                    }
                                  }catch(e){
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
                            child: StaffTitle(title: 'Aggiungi Portata',),
                          ),
                          SliverToBoxAdapter(
                            child: Name(
                              nameENG: nameENG,
                              nameITA: nameIT,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Description(descriptionITA: descriptionITA,descriptionENG: descriptionENG,),
                          ),
                          SliverToBoxAdapter(
                            child: Price(price: price,),
                          ),
                          SliverToBoxAdapter(
                            child:  Container(
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
                                          child: Text(translateFoodCategory(foodCategory: value)),
                                        );
                                      }).toList(),
                                      onChanged: (value){
                                        setState(() {
                                          dropDownValue = value!;
                                          print(dropDownValue);
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
                                          onPressed:pickImage,
                                          child: Text('Inserisci immagine'),
                                        ),
                                      ),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child:     Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _fileBytes == null
                                  ? Text('no image selected')
                                  : Image.memory(
                                _fileBytes!,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            ) ,
                          ),
                          AllergensCheckGrid(
                            allAllergenList: allAllergensList,
                            allergenList: foodAllegyList,
                          ),
                          SliverToBoxAdapter(
                            child: TextButton(
                              style:
                              ButtonStyle(minimumSize: MaterialStateProperty.all(Size(100, 100))),
                              onPressed: () async{
                                DatabaseFood databaseFood = DatabaseFood();
                                try{
                                  if (_fileBytes == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('inserire un immagine valida'),
                                      ),
                                    );
                                  } else {
                                    const uuid = Uuid();
                                    String id = uuid.v1();

                                    Storage storage = Storage();

                                    String? url = await storage.uploadImage(_fileBytes!, id);


                                    if( double.tryParse(price.text)!= null  && nameENG.text != ''){

                                      Food food = Food(
                                          id: id,
                                          nameITA: nameIT.text,
                                          nameENG: nameENG.text,
                                          price: double.parse(price.text),
                                          descriptionENG: descriptionENG.text,
                                          descriptionITA: descriptionITA.text,
                                          image: url!,
                                          category: dropDownValue,
                                          active: true,
                                          allergens: foodAllegyList
                                      );

                                      await databaseFood.createEdit(food: food, isEdit: false).then((value) {

                                        setState(() {
                                          nameIT.clear();
                                          nameENG.clear();
                                          descriptionITA.clear();
                                          descriptionENG.clear();
                                          price.clear();
                                          foodAllegyList.clear();
                                          for(int i=0;i<boolList.length;i++){
                                            boolList[i]=false;
                                          }
                                          _fileBytes= null;
                                        });
                                       //TODO make code to change the body of homepage in order to go back to staffhomepage without fucking up the stream builder
                                      });
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('inserire un prezzo e un nome  valido'),
                                        ),
                                      );
                                    }
                                  }
                                }catch(e){
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
                  }
              )
          ),
        ),
      ),
    );
  }
}



class AllergensCheckGrid extends StatefulWidget {
 final List<String> allergenList ;
 final List<Allergens> allAllergenList ;

 AllergensCheckGrid({required this.allergenList, required this.allAllergenList});

  @override
  State<AllergensCheckGrid> createState() => _AllergensCheckGridState();
}

class _AllergensCheckGridState extends State<AllergensCheckGrid> {
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
                  for(int i=0; i< Allergen.returnAllergen(Allergens.values).length; i++)
                    AllergensCheckListTile(
                    allergen: Allergen.returnAllergen(Allergens.values)[i],
                    onChange: (value){
                         if(value){
                           setState(() {
                             widget.allergenList.add(widget.allAllergenList[i].toString());
                             for(var all in widget.allergenList)
                               print(all);
                           });
                         }
                         else{
                           setState(() {
                             widget.allergenList.remove(widget.allAllergenList[i]);

                           });
                         }
                             },
                        )

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
        color: addingAllergen
                ?secondaryColor
                :null,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
              width: 1,
              color: Colors.black
          )
      ),
      child: ListTile(
        title: Text(translateAllergen(widget.allergen)),
        trailing: AllergenIcon(assetName: widget.allergen.svgDirectory,),
        onTap: (){
          setState(() {
            addingAllergen = !addingAllergen;
          });
          widget.onChange(addingAllergen);
        },
      ),
    );
  }
}



