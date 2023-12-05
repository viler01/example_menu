import '../services/imports.dart';
import 'package:flutter/cupertino.dart';

class ClientPopupScreen extends StatefulWidget {
  final Map<String, int> map;

  ClientPopupScreen({required this.map});

  @override
  State<ClientPopupScreen> createState() => _ClientPopupScreenState();
}

class _ClientPopupScreenState extends State<ClientPopupScreen> {
  late List<String?> keys;
  late List<int?> values;
  double tableNumber = 0;

  TextEditingController tableController = TextEditingController();
  TextEditingController requestController = TextEditingController();

  @override
  void initState() {
    keys = widget.map.keys.toList();
    values = widget.map.values.toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    //SystemChannels.textInput.invokeMethod('TextInput.setLocale', 'en_US');

    return  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: IconButton(
                  icon: Icon(CupertinoIcons.arrow_down_circle_fill),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 220,
                width: 350,
                child: ListView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, int index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (values[index]! != 0) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              keys[index]!,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              values[index].toString(),
                            ),
                          )
                        ],
                      ],
                    );
                  },
                  itemCount: widget.map.length,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
              child: TextFormField(
                  controller: requestController,
                  textAlign: TextAlign.center,

                  decoration:
                  InputDecoration(hintText: 'ci sono richieste particolari?')),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: TextFormField(
                  controller: tableController,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true
                  ),
                  textAlign: TextAlign.center,

                  decoration:
                      InputDecoration(hintText: 'inserire il numero del tavolo')),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CupertinoButton(
                child: Text('invia ordine'),
                onPressed: () async {
                try{
                  String tableNumberFormatted = tableController.text.replaceAll(',', '.');
                  double myNumber = double.parse(tableNumberFormatted);
                  if (tableController.text.isEmpty) {
                    await  notTableNumber(isTable : true);

                  }

                  if (keys.isEmpty) {

                    await notTableNumber(isTable: false);
                  }
                  else {

                   createOrder();
                  }
                 // Navigator.pop(context);
                }catch(e){
                  showModalBottomSheet(
                    backgroundColor: Colors.white,
                    context: context,
                    isScrollControlled: true,
                    isDismissible: true,
                    builder: (context) => Container(
                      height: 200,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'inserire un numero di tavolo valido',
                                style: TextStyle(fontSize: 15, color: Colors.red),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CupertinoButton(
                              child: Text('chiudi'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );

                }
                },
              ),
            )
          ],
        ),
      );

  }

  void createOrder() async {
    CollectionReference<Map<String, dynamic>> tableCollection =
        FirebaseFirestore.instance.collection('tables');

    int check = 0;

    String tableNumberFormatted = tableController.text.replaceAll(',', '.');
    double myNumber = double.parse(tableNumberFormatted);

    await tableCollection.get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          if (docSnapshot.data()['fakeNumber'] == myNumber) {
            check++;
            List<String?> list = [];
            List<String?> foodNameList=[];
            List<int> quantityList=[];
            widget.map.forEach((key, value) {
              if (value != 0) {
                String temp = '$value x $key ';
                list.add(temp);

                String foodName= key;
                int quantity = value;

                foodNameList.add(foodName);
                quantityList.add(quantity);

              }
            });
            const uuid = Uuid();
            String id = uuid.v1();
            DateTime now = DateTime.now();
            String date = '${now.hour} : ${now.minute}';
            DatabaseComanda databaseComanda = DatabaseComanda();
            Comanda comanda = Comanda(
              request: requestController.text.isEmpty ? " " : requestController.text,
              quantityList: quantityList,
                foodNameList: foodNameList,
                isActive: false,
                createdAt: DateTime.now(),
                id: id,
                tableNumber: myNumber,
                list: list,
                time: date);
            databaseComanda.createEdit(comanda: comanda, isEdit: false);

          showDialog(
            barrierDismissible: false,
              context: context,
              builder: (_) => CupertinoAlertDialog(
            title: Text('ordine inviato con successo'),
            actions: [
              CupertinoDialogAction(child: Text('torna al menu'),onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
              },)
            ],
          )  );
          }
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    if (check == 0) {

      showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        builder: (context) => Container(
          height: 200,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'inserire un numero di tavolo valido',
                    style: TextStyle(fontSize: 15, color: Colors.red),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoButton(
                  child: Text('chiudi'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  Future  notTableNumber({required bool isTable}) async {
   await  showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) =>
          Container(
            height: 200,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                   isTable ? 'inserire un numero di tavolo valido' : 'inserire dei cibi prima di ordinare',
                    style: TextStyle(fontSize: 15, color: Colors.red),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoButton(
                    child: Text('chiudi'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
    );
  }
}
/*
class DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.contains(',')) {
      // Replace ',' with '.'
      final newText = newValue.text.replaceAll(',', '.');
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
    return newValue;
  }
}*/