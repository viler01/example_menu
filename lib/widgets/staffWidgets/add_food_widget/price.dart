import '../../../services/imports.dart';

class Price extends StatelessWidget {
  final TextEditingController price;

  Price({required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("PREZZO", style: addTextStile,),
        CustomTextField(
          controller: price,
          labelText: "PREZZO",
          prefixText: "€  ",
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        )
      ],
    );
  }
}