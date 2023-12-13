import '../../services/imports.dart';
import 'package:flutter/cupertino.dart';
class SuperComandaItemUser extends StatefulWidget {
  final Comanda? comanda;
  //final bool check;

  SuperComandaItemUser({required this.comanda, });

  @override
  State<SuperComandaItemUser> createState() => _SuperComandaItemUserState();
}

class _SuperComandaItemUserState extends State<SuperComandaItemUser> {
  bool switchValue = false;


  @override
  Widget build(BuildContext context) {

    bool requestOn= (widget.comanda!.requestList == null || widget.comanda!.requestList!.isEmpty)? false : true;

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
                    DatabaseSupercomanda databaseSuperComanda= DatabaseSupercomanda();
                      Comanda comanda = Comanda(
                          request:  widget.comanda!.request,
                          quantityList: widget.comanda!.quantityList,
                          foodNameList: widget.comanda!.foodNameList,
                          id: widget.comanda!.id,
                          createdAt: widget.comanda!.createdAt,
                          tableNumber: widget.comanda!.tableNumber,
                          list: widget.comanda!.list,
                          isActive: !widget.comanda!.isActive,
                          time: widget.comanda!.time,
                        requestList: widget.comanda!.requestList
                      );
                      databaseSuperComanda.createEdit(comanda: comanda, isEdit: true);
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
                      child: Text('${widget.comanda!.quantityList[index]} x ${widget.comanda!.foodNameList[index]}',style: kFoodTitleUserTextStyle,),
                    );
                  },
                  itemCount: widget.comanda!.quantityList.length,
                ),
              ),
            ),
            Center(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(onPressed: (){

                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        shape: AppStyle.kModalBottomStyle,
                        isScrollControlled: true,
                        isDismissible: true,
                        builder: (context) =>
                            Container(
                              height: 350,
                              width: 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:kLightPrimaryColor,
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
                                  Text('Sei sicuro di voler eliminare la comanda  DEFINITIVAMENTE?',style: kFoodTitleUserTextStyle,),
                                  CupertinoButton(
                                      color: kPrimaryColor,
                                      child:Text('ELIMINA') , onPressed: (){
                                    DatabaseSupercomanda databaseSuperComanda = DatabaseSupercomanda();
                                    databaseSuperComanda.deleteComanda(comandaID: widget.comanda!.id);
                                    Navigator.pop(context);
                                  })
                                ],
                              ),
                            ),);
                    }, icon: Icon(Icons.delete)),
                  ),
                  Visibility(
                    visible: requestOn,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: (){

                            showModalBottomSheet(
                              backgroundColor: kbackgroundRequest ,
                              context: context,
                              shape: AppStyle.kModalBottomStyle,
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
                                      Container(
                                        height: 200,
                                        width: 170,
                                        child: /* widget.comanda!.requestList == null ?
                                        Text('non ci sono richieste particolari')
                                        :*/
                                        ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, int index) {
                                            return Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child:Text(widget.comanda!.requestList![index],style: kFoodTitleUserTextStyle,)
                                            );
                                          },
                                          itemCount: widget.comanda!.requestList!.length,
                                        ),
                                      )
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
