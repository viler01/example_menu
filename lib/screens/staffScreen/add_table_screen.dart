import '../../services/imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AddTableScreen extends StatefulWidget {
  final bool edit;
  final Tavolo? tavolo;

  const AddTableScreen({super.key, required this.tavolo, required this.edit});

  @override
  State<AddTableScreen> createState() => _AddTableScreenState();
}

class _AddTableScreenState extends State<AddTableScreen> {
  static const double horizontal_padding = 70;
  static const double vertical_padding = 20;
  final _formKey = GlobalKey<FormState>();
  bool showLoading = false;

  TextEditingController numberCreate = TextEditingController();
  TextEditingController fakeNumberCreate = TextEditingController();

  TextEditingController numberEdit = TextEditingController();
  TextEditingController fakeNumberEdit = TextEditingController();

  @override
  void initState() {
    numberEdit = TextEditingController(text: widget.tavolo!.number.toString());
    fakeNumberEdit =
        TextEditingController(text: widget.tavolo!.fakeNumber.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return showLoading
        ? LoadingScreen()
        : Container(
            height: 400,
            color: Colors.white,
            child: SingleChildScrollView(
                child: widget.edit == false
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: vertical_padding,
                                      horizontal: horizontal_padding),
                                  child: TextFormField(
                                    style: kAccountTextStyle,
                                    controller: numberCreate,
                                    textAlign: TextAlign.center,
                                    decoration: AppStyle().kTextFieldDecoration(
                                        icon: Icons.star,
                                        hintText:
                                            'inserire il numero del tavolo'),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: vertical_padding,
                                      horizontal: horizontal_padding),
                                  child: TextFormField(
                                    controller: fakeNumberCreate,
                                    style: kAccountTextStyle,
                                    textAlign: TextAlign.center,
                                    decoration: AppStyle().kTextFieldDecoration(
                                        icon: Icons.location_on,
                                        hintText:
                                            'inserire il numero fittizio del tavolo'),
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                          CupertinoButton(
                            color: mainColor,
                            onPressed: () async {
                              try {
                                EasyLoading.show();
                                const uuid = Uuid();
                                String id = uuid.v1();

                                Tavolo tavolo = Tavolo(
                                    number: double.parse(numberCreate.text),
                                    fakeNumber:
                                        double.parse(fakeNumberCreate.text),
                                    isTaken: false,
                                    tableId: id);

                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }

                                setState(() => showLoading = true);
                                EasyLoading.dismiss();

                                DatabaseTable databaseTable = DatabaseTable();
                                await databaseTable
                                    .createEdit(table: tavolo, isEdit: false)
                                    .then((message) {
                                  setState(() => showLoading = false);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('tavolo creato con successo'),
                                    ),
                                  );
                                  Navigator.pop(context);
                                });
                              } catch (e) {
                                EasyLoading.showError(
                                    'inserire un numero valido');
                              }
                            },
                            child: Text(
                              'Crea Tavolo',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: vertical_padding,
                                      horizontal: horizontal_padding),
                                  child: TextFormField(
                                    style: kAccountTextStyle,
                                    controller: numberEdit,
                                    textAlign: TextAlign.center,
                                    decoration: AppStyle().kTextFieldDecoration(
                                        icon: Icons.star,
                                        hintText:
                                            'inserire il numero del tavolo'),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: vertical_padding,
                                      horizontal: horizontal_padding),
                                  child: TextFormField(
                                    controller: fakeNumberEdit,
                                    style: kAccountTextStyle,
                                    textAlign: TextAlign.center,
                                    decoration: AppStyle().kTextFieldDecoration(
                                        icon: Icons.location_on,
                                        hintText:
                                            'inserire il numero fittizio del tavolo'),
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                          CupertinoButton(
                            color: mainColor,
                            onPressed: () async {
                              try {
                                EasyLoading.show();

                                Tavolo tavolo = Tavolo(
                                    number: double.parse(numberEdit.text),
                                    fakeNumber:
                                        double.parse(fakeNumberEdit.text),
                                    isTaken: widget.tavolo!.isTaken,
                                    tableId: widget.tavolo!.tableId);

                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }

                                setState(() => showLoading = true);
                                EasyLoading.dismiss();

                                DatabaseTable databaseTable = DatabaseTable();
                                await databaseTable
                                    .createEdit(table: tavolo, isEdit: false)
                                    .then((message) {
                                  setState(() => showLoading = false);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('tavolo creato con successo'),
                                    ),
                                  );
                                  Navigator.pop(context);
                                });
                              } catch (e) {
                                EasyLoading.showError(
                                    'inserire un numero valido ');
                              }
                            },
                            child: Text(
                              'Modifica  Tavolo',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )),
          );
  }
}
