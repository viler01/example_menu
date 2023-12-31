import '../../services/imports.dart';
import 'package:flutter/cupertino.dart';
class ComandaItemUser extends StatefulWidget {
  final Comanda? comanda;


  ComandaItemUser({required this.comanda});

  @override
  State<ComandaItemUser> createState() => _ComandaItemUserState();
}

class _ComandaItemUserState extends State<ComandaItemUser> {
  bool switchValue = false;


  @override
  Widget build(BuildContext context) {

    bool requestOn= widget.comanda!.request == " "? false : true;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
            color: widget.comanda!.isActive ? selectedColor : secondaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text('Tavolo: ${widget.comanda!.tableNumber.toString()}',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text('${widget.comanda!.time}'),
                        ),
                         ]

                    ),
                  ),
              CupertinoSwitch(
                    // This bool value toggles the switch.
                    value: widget.comanda!.isActive,
                    activeColor: mainColor,
                    onChanged: (bool? value) {
                      // This is called when the user toggles the switch.
                  DatabaseComanda databaseComanda= DatabaseComanda();
                  Comanda comanda = Comanda(
                    isGathered: widget.comanda!.isGathered,
                    request:  widget.comanda!.request,
                    quantityList: widget.comanda!.quantityList,
                    foodNameList: widget.comanda!.foodNameList,
                    id: widget.comanda!.id,
                    createdAt: widget.comanda!.createdAt,
                    tableNumber: widget.comanda!.tableNumber,
                    list: widget.comanda!.list,
                    isActive: !widget.comanda!.isActive,
                    time: widget.comanda!.time

                  );
                  databaseComanda.createEdit(comanda: comanda, isEdit: true);
                    },
                  ),
                ],
              ),

            ),
            Container(
              child:  Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(), //QUESTO LHO MESSO IO NON CENTRA CON IL NOSTRO PROBLEMA DELLO SCROLL <3<3<3<3
                  //scrollDirection: Axis.vertical,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(widget.comanda!.list[index]!),
                    );
                  },
                  itemCount: widget.comanda!.list.length,
                ),
              ),
            ),
            Center(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: (){

                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        isScrollControlled: true,
                        isDismissible: true,
                        builder: (context) =>
                            Container(
                              height: 350,
                              width: 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),

                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Center(
                                      child: IconButton(
                                        icon: Icon(CupertinoIcons.arrow_down_circle_fill),
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ),
                                  Text('Sei sicuro di voler eliminare la comanda  DEFINITIVAMENTE?',),
                                  CupertinoButton(
                                      child:Text('ELIMINA') , onPressed: (){
                                    DatabaseComanda databaseComanda = DatabaseComanda();
                                    databaseComanda.deleteComanda(comandaID: widget.comanda!.id);
                                    Navigator.pop(context);
                                  })
                                ],
                              ),
                            ),);
                    }, icon: Icon(Icons.delete)),
                  ),
                  Visibility(
                    visible: requestOn ,
                    child:    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: (){
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              isDismissible: true,
                              builder: (context) =>
                                  Container(
                                    height: 350,
                                    width: 400,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),

                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Center(
                                            child: IconButton(
                                              icon: Icon(CupertinoIcons.arrow_down_circle_fill),
                                              onPressed: (){
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ),
                                        Text(widget.comanda!.request,),
                                      ],
                                    ),
                                  ),);
                          }, icon: Icon(CupertinoIcons.eye)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
