import 'package:flutter/material.dart';
import 'package:example_menu/GlobalVariable.dart';
import 'package:example_menu/models/allergen_model.dart';
import 'package:example_menu/models/food_model.dart';
import 'package:example_menu/widgets/GeneralWidget/CustomTextField.dart';
import 'package:example_menu/widgets/GeneralWidget/MyBackground.dart';
import 'package:example_menu/widgets/costumersWidgets/alleargenWidgets.dart';
import 'package:example_menu/widgets/staffWidgets/StaffBottomBar.dart';
import 'package:example_menu/widgets/staffWidgets/StaffTitle.dart';

class StaffAddScreen extends StatefulWidget {
  StaffAddScreen({super.key});

  @override
  State<StaffAddScreen> createState() => _StaffAddScreenState();
}

class _StaffAddScreenState extends State<StaffAddScreen> {

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
