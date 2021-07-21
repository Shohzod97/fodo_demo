import 'package:flutter/material.dart';

Widget buttonWaste(inventoryProvider, itemKey, index) => ElevatedButton(    //кнопка "Потратить"
    onPressed: () {
      inventoryProvider.updateItemsSubOne(itemKey[index]);                  //удалит из списка
    },
    child: Text("Потратить"),
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      backgroundColor: MaterialStateProperty.all<Color>(Color(0xC8131313)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: BorderSide(color: Colors.black))),
    ));
