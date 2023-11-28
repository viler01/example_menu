import '../../../services/imports.dart';

class Name extends StatelessWidget {

  final TextEditingController nameITA;
  final TextEditingController nameENG;

  Name({required this.nameITA, required this.nameENG});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("NOME",style: addTextStile,),
        //NOME ITALIANO
        CustomTextField(
          labelText: "ITALIANO",
          controller: nameITA ,),

        //NOME INGLESE
        CustomTextField(
          labelText: "INGLESE",
          controller: nameENG,
        )
      ],
    );
  }
}
