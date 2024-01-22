//VisualPizzaScreen
import 'package:example_menu/widgets/costumersWidgets/foodCardMenuExample.dart';

import 'package:example_menu/services/imports.dart';
import 'package:flutter/cupertino.dart';

class VisualPizzaScreen extends StatefulWidget {
  const VisualPizzaScreen({super.key, required this.foods});

  final List<Food?> foods;

  @override
  State<VisualPizzaScreen> createState() =>
      _VisualPizzaScreenState(foodsList: foods);
}

class _VisualPizzaScreenState extends State<VisualPizzaScreen> {
  final List<Food?> foodsList;
  PageController _pageController = PageController(viewportFraction: 0.7);
  int _currentPage = 0;

  _VisualPizzaScreenState({required this.foodsList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(restourantName),
        ),
        body: CustomPaint(
          painter: MyBackground(),
          child: Column(
            children: [
              Expanded(
                  child: PageView.builder(
                      controller: _pageController,
                      itemCount: foodsList.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return LayoutBuilder(builder: (context, cons) {
                          return Center(
                            child: AnimatedAlign(
                              duration: Duration(milliseconds: 200),
                              alignment: _currentPage == index
                                  ? Alignment.center
                                  : index < _currentPage
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                              child: AnimatedContainer(
                                  height: _currentPage == index
                                      ? cons.maxHeight
                                      : cons.maxHeight * 0.5,
                                  width: _currentPage == index
                                      ? cons.maxHeight
                                      : cons.maxHeight * 0.5,
                                  duration: Duration(milliseconds: 200),
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  child: CircleAvatar(
                                    backgroundColor: _currentPage == index
                                        ? Colors.green
                                        : Colors.red,
                                    backgroundImage: NetworkImage(foodsList[index]!.image),

                                  )),
                            ),
                          );
                        });
                      })),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.navigate_before)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.navigate_next)),
                ],
              ),
              Expanded(
                  child: PageView.builder(itemBuilder: (context, index) {}))
            ],
          ),
        ));
  }
}
