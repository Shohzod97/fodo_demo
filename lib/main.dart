import 'package:flutter/material.dart';
import 'package:flutter_myapp_demo/pages/inventory_page.dart';
import 'package:provider/provider.dart';

import 'data.dart';
import 'package:flutter_myapp_demo/pages/home_page.dart';
import 'package:flutter_myapp_demo/pages/hero_page.dart';
import 'package:flutter_myapp_demo/pages/todo_page.dart';
import 'package:flutter_myapp_demo/pages/store_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(                                  //Данные в data.dart
        providers: [
          ChangeNotifierProvider<Data>(                   //Общие данные (деньги, опыт, уровень и др.)
              create: (context) => Data()),
          ChangeNotifierProvider<TasksProvider>(          //Для заданий todo_page
              create: (context) => TasksProvider()),
          ChangeNotifierProvider<RewardsProvider>(        //Для магазина наград на store_page
            create: (context) => RewardsProvider(),
          ),
          ChangeNotifierProvider<InventoryProvider>(      //Для инвентаря на inventory_page
            create: (context) => InventoryProvider(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: Colors.deepOrangeAccent,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => Home(),                     //общая страница
            '/hero': (context) => HeroPage(),             //Герой
            '/todo': (context) => TodoPage(),             //Задания
            '/store': (context) => StorePage(),           //Магазин наград
            '/inventory': (context) => InventoryPage(),   //Инвентарь
          },
        ));
  }
}
