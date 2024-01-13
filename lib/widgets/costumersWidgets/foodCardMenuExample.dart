import '../../services/imports.dart';

class FoodCardMenuExample extends StatefulWidget {
  final Food food;

  FoodCardMenuExample({required this.food});
  @override
  State<FoodCardMenuExample> createState() => _FoodCardMenuExampleState();
}

class _FoodCardMenuExampleState extends State<FoodCardMenuExample> {

  double cardHeight = 150;
  double imageRadius = 60;

  @override
  Widget build(BuildContext context) {
    List<Allergens> allergenList = stringToAllergens(widget.food.allergens);

    return Container(
      margin: const EdgeInsets.all(12),
      height: cardHeight,

      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(3, 3), // changes position of shadow
            ),
          ]
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            //food image
            CircleAvatar(
              radius: imageRadius,
              backgroundImage: NetworkImage(widget.food.image),
            ),

            //food general information
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    translateFoodName(
                        food: widget.food, language: currentLanguage),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text("€${widget.food.price}"),
                  AllergenRow(allergensList: allergenList)
                ],
              ),
            ),

            //action
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_red_eye_outlined),
                  onPressed: () =>
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              FoodAlertDialog(food: widget.food,)
                      ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
