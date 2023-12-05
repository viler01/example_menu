import '../../services/imports.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/cupertino.dart';

class TableNumbers extends StatefulWidget {
  const TableNumbers({Key? key}) : super(key: key);

  @override
  State<TableNumbers> createState() => _TableNumbersState();
}

class _TableNumbersState extends State<TableNumbers> {
  static const double padding_horizontal = 15;
  static const double padding_vertical = 20;

  late Stream myStream;
  bool isFirstLaunch=true;

   late Stream callStream;


  @override
  void initState() {
    myStream =FirebaseFirestore.instance
        .collection('comanda')
        .orderBy('createdAt', descending: true).snapshots();

    callStream =FirebaseFirestore.instance
        .collection('calls')
        .orderBy('createdAt', descending: true).snapshots();


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //antipasti

              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: padding_vertical, horizontal: padding_horizontal),
                child: Text(
                  'I tuoi Tavoli',
                  style: kFoodTitleTextStyle,
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      height: 400,
                      width: 400,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54, width: 2)),
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('tables')
                              .orderBy('number', descending: false)
                              .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) {
                              print(snapshot.error);
                              return const Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const LoadingWidget();
                            }
                            //List<Comanda?> allComanda = snapshot.data!;
                            final allTableSnapshot = snapshot.data!.docs;
                            List<Tavolo?> allTables = [];

                            for (int i = 0; i < allTableSnapshot.length; i++) {
                              Tavolo tavolo = Tavolo(
                                  fakeNumber:
                                      allTableSnapshot[i].data()['fakeNumber'],
                                  isTaken:
                                      allTableSnapshot[i].data()['isTaken'],
                                  number: allTableSnapshot[i].data()['number'],
                                  tableId:
                                      allTableSnapshot[i].data()['tableId']);

                              allTables.add(tavolo);
                            }
                            return allTables.isEmpty
                                ? Center(
                                    child: Center(
                                    child: Text(
                                      'Non hai inserito tavoli ',
                                      style: TextStyle(color: kPrimaryColor),
                                    ),
                                  ))
                                : Container(
                                    height: 400,
                                    width: 400,
                                    child: SingleChildScrollView(
                                      child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, int index) {
                                          return TableItemUser(
                                            tavolo: allTables[index],
                                            isActive: (value) {
                                              DatabaseTable databaseTable =
                                                  DatabaseTable();
                                              Tavolo tavolo = Tavolo(
                                                number:
                                                    allTables[index]!.number,
                                                fakeNumber: allTables[index]!
                                                    .fakeNumber,
                                                isTaken:
                                                    !allTables[index]!.isTaken,
                                                tableId:
                                                    allTables[index]!.tableId,
                                              );
                                              databaseTable.createEdit(
                                                  table: tavolo, isEdit: true);
                                              setState(() {
                                                value =
                                                    allTables[index]!.isTaken;
                                              });
                                            },
                                            edit: () => showModalBottomSheet(
                                                backgroundColor:
                                                    kBackgroundColor,
                                                context: context,
                                                shape:
                                                    AppStyle.kModalBottomStyle,
                                                isScrollControlled: true,
                                                isDismissible: true,
                                                builder: (context) =>
                                                    AddTableScreen(
                                                      edit: true,
                                                      tavolo: allTables[index],
                                                    )),
                                          );
                                        },
                                        itemCount: allTables.length,
                                      ),
                                    ),
                                  );
                          }))),

              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: padding_vertical,
                      horizontal: padding_horizontal),
                  child: CupertinoButton(
                    color: kPrimaryColor,
                    child: Text('aggiungi nuovo'),
                    onPressed: () => showModalBottomSheet(
                        backgroundColor: kBackgroundColor,
                        context: context,
                        shape: AppStyle.kModalBottomStyle,
                        isScrollControlled: true,
                        isDismissible: true,
                        builder: (context) => AddTableScreen(
                            tavolo: Tavolo(
                                number: 0,
                                fakeNumber: 0,
                                isTaken: false,
                                tableId: ''),
                            edit: false)),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
