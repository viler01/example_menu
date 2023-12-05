import '../../services/imports.dart';
import 'package:flutter/cupertino.dart';
class DeleteAllButton extends StatefulWidget {

  final String collectionName;

  DeleteAllButton({required this.collectionName});

  @override
  State<DeleteAllButton> createState() => _DeleteAllButtonState();
}

class _DeleteAllButtonState extends State<DeleteAllButton> {
  @override
  Widget build(BuildContext context) {
    return    Padding(
      padding: const EdgeInsets.all( 20.0),
      child: Container(
        height: 80,
        child: IconButton(onPressed: (){
          showDialog(
              context: context,
              builder: (_) => CupertinoAlertDialog(
                title: Text('sei sicuro di eliminare tutte le comande di questa lista?'),
                actions: [
                  CupertinoDialogAction(child: Text('elimina'),onPressed: (){
                    deleteCollection(widget.collectionName);
                    Navigator.pop(context);

                  },)
                ],
              )  );
        }, icon: Icon(CupertinoIcons.arrow_3_trianglepath)),
      ),
    ) ;
  }
}
