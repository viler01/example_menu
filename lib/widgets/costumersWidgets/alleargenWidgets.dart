import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:example_menu/GlobalVariable.dart';
import 'package:example_menu/models/allergen_model.dart';

class AllergenIcon extends StatelessWidget {
  const AllergenIcon({
    super.key,
    required this.assetName,
    this.iconSize = 30
  });
  final String assetName;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: iconSize,
      height: iconSize,
      child: SvgPicture.asset(assetName),
    );
  }
}

class AllergenRow extends StatelessWidget {
  const AllergenRow({
    super.key,
    required this.allergensList
  });
  final List<Allergens> allergensList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for(var allergen in Allergen.returnAllergen(allergensList))AllergenIcon(assetName: allergen.svgDirectory)
      ],
    );
  }
}

class AllergenColumn extends StatelessWidget {
  const AllergenColumn({super.key,required this.allergensList});
  final List<Allergens> allergensList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(thickness: 1,height: 30,color: mainColor,),
        const Text('Allergeni:'),
        for(var allergen in Allergen.returnAllergen(allergensList))ListTile(
          leading: AllergenIcon(assetName: allergen.svgDirectory,),
          title: Text(translateAllergen(allergen)),
        )
      ],
    );
  }
}


