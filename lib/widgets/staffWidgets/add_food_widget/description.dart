import '../../../services/imports.dart';

class Description extends StatelessWidget {
  final TextEditingController descriptionITA;
  final TextEditingController descriptionENG;

  Description({required this.descriptionENG, required this.descriptionITA});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("DESCIZIONE", style: addTextStile,),
        //DESCIZIONE ITALIANO
        CustomTextField(
          labelText: "ITALIANO",
          controller: descriptionITA,
        ),

        //DESCIZIONE INGLESE
        CustomTextField(
          labelText: "INGLESE",
          controller: descriptionENG,
        ),
      ],
    );
  }
}