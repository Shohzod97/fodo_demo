import 'package:flutter_myapp_demo/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myapp_demo/inventory_page/invent_list.dart';
import 'package:flutter_myapp_demo/inventory_page/show_go_store.dart';
import 'package:provider/provider.dart';

class InventoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inventoryData = context.watch<InventoryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Инвентарь'),
      ),
      body: inventoryData.inventoryItems.isEmpty
          ? showGoStore(context)                            //кнопка перехода в Магазин
          : InventoryList(inventoryData: inventoryData),    //список приобретенных вознаграждений
    );
  }
}
