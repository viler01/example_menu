import 'package:example_menu/GlobalVariable.dart';
import 'package:example_menu/widgets/GeneralWidget/MyBackground.dart';
import 'package:example_menu/widgets/staffWidgets/StaffActiveFoodCard.dart';
import 'package:example_menu/widgets/staffWidgets/StaffBottomBar.dart';
import 'package:example_menu/widgets/staffWidgets/StaffTitle.dart';
import '../../services/imports.dart';

class StaffHomepage extends StatefulWidget {
  const StaffHomepage({super.key});

  @override
  State<StaffHomepage> createState() => _StaffHomepageState();
}

class _StaffHomepageState extends State<StaffHomepage> {
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
                    child: LayoutBuilder
                      (builder: (context, constraints){
                        return StaffLayoutBuilder(
                            maxWidth: constraints.maxWidth,
                            children: [
                              for(var foodCategory in FoodCategory.values)CustomExpansionTile(
                                  title: translateFodCategory(foodCategory: foodCategory),
                                children: [
                                  for(var food in provaListaMenu)if(food.category == foodCategory)StaffActiveFoodCard(
                                    food: food,
                                    onChanged: (value){},
                                  )
                                ],
                              )

                            ]);
                    }
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const StaffBottomBar(),
    );
  }
}

class StaffLayoutBuilder extends StatelessWidget {
  StaffLayoutBuilder({
    super.key,
    required this.maxWidth,
    required this.children
  });
  final double maxWidth;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    switch(maxWidth){
      case > horizontalLayout:

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: maxWidth/2,
              child: Column(
                children: children.sublist(0,children.length~/2),
              ),
            ),
            Container(
              width: maxWidth/2,
              child: Column(
                children: children.sublist(children.length~/2),
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

