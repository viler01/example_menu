import '../../services/imports.dart';
import 'package:flutter/material.dart';

class TableItemUser extends StatefulWidget {
final Tavolo? tavolo;
final Function(bool?) isActive;
final VoidCallback? edit;

 TableItemUser({required this.edit,required this.isActive,required this.tavolo});


  @override
  State<TableItemUser> createState() => _TableItemUserState();
}

class _TableItemUserState extends State<TableItemUser> {
  @override
  Widget build(BuildContext context) {
    return  Card(
      child: Container(
        decoration: BoxDecoration(
          color: widget.tavolo!.isTaken? selectedColor :secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        height: 80,
        width: 350,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Switch(
                value: widget.tavolo!.isTaken,
                onChanged: widget.isActive,
                activeColor: mainColor,
              ),
            ),
            Text(
              widget.tavolo!.number.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  decoration: TextDecoration.none),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(onPressed: widget.edit, icon: Icon(Icons.edit)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(onPressed:(){
                    DatabaseTable databaseTable = DatabaseTable();
                    databaseTable.deleteTable(tableID: widget.tavolo!.tableId);
                  }, icon: Icon(Icons.delete)),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}
