import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:flutter/foundation.dart';

class Data with ChangeNotifier {
  //image
  File _xImage = File("");

  File get getImage => _xImage;

  void saveImage(File newImage) {
    _xImage = newImage;
    notifyListeners();
  }

  //exp, money, level
  num _money = 0;
  num _countEx = 0;
  int _level = 0;

  num get getEx => _countEx;
  num get getMoney => _money;
  int level() => _level = _countEx ~/ 1000;

  void getExpMoney(num newExp, num newMoney) {
    _countEx += newExp;
    _money += newMoney;
    notifyListeners();
  }

  num buy(num cost) => _money -= cost;
}


// Задания
class Task {
  final String title;
  final num money;
  final num exp;

  Task({
    required this.title,
    required this.money,
    required this.exp,
  });
}

class TasksProvider with ChangeNotifier {
  Map<String, Task> _taskItems = {
    "1": Task(
      title: 'Прочитать 1 главу',
      money: 50,
      exp: 800,
    ),
    "2": Task(
      title: 'Сдать экзамен',
      money: 150,
      exp: 900,
    ),
  };

  UnmodifiableMapView<String, Task> get taskItems =>
      UnmodifiableMapView(_taskItems);

  int get taskItemsCount => _taskItems.length;

  void addTask({title, money, exp}) {
    _taskItems.putIfAbsent(
        title,
        () => Task(
              title: title,
              money: money,
              exp: exp,
            ));
    notifyListeners();
  }

  void editTask({task, title, money, exp}) {
    _taskItems.update(
        task,
        (ex) => Task(
              title: title.isEmpty ? ex.title : title,
              money: money == 0 ? ex.money : money,
              exp: exp == 0 ? ex.exp : exp,
            ));
    notifyListeners();
  }

  void winTask({task, title, money, exp}) {
    _taskItems.update(
        task,
        (ex) => Task(
              title: title.isEmpty ? ex.title : title,
              money: money == 0 ? ex.money : money,
              exp: exp == 0 ? ex.exp : exp,
            ));
    notifyListeners();
  }

  void deleteTask(String title) {
    _taskItems.remove(title);
    notifyListeners();
  }
}


// Награды
class Reward with ChangeNotifier {
  final String id;
  final String title;
  final num price;
  final String img;

  Reward({
    required this.id,
    required this.title,
    required this.price,
    required this.img,
  });
}

class RewardsProvider with ChangeNotifier {
  List<Reward> _items = [
    Reward(
      id: '1',
      title: 'Кока-кола 0.33 л.',
      price: 50,
      img: "assets/images/cola.png",
    ),
    Reward(
      id: '2',
      title: 'Чипсы 40 г.',
      price: 70,
      img: "assets/images/lays.png",
    ),
    Reward(
      id: '3',
      title: 'Видеоигра 1 час',
      price: 100,
      img: "assets/images/game.png",
    ),
    Reward(
      id: '5',
      title: 'Фильм 2 часа',
      price: 200,
      img: "assets/images/movie.png",
    ),
    Reward(
      id: '4',
      title: 'Что угодно 4 часа',
      price: 400,
      img: "assets/images/any.png",
    ),
  ];

  UnmodifiableListView<Reward> get items => UnmodifiableListView(_items);

  Reward getElementById(String id) =>
      _items.singleWhere((value) => value.id == id);
}


// Инентарь
class Inventory {
  final String id;
  final String title;
  final int number;
  final num price;
  final String img;

  Inventory(
      {required this.id,
        required this.title,
        required this.number,
        required this.price,
        required this.img});
}

class InventoryProvider with ChangeNotifier {
  Map<String, Inventory> _inventoryItems = {};

  UnmodifiableMapView<String, Inventory> get inventoryItems =>
      UnmodifiableMapView(_inventoryItems);

  int get inventoryItemsCount => _inventoryItems.length;

  double get totalAmount {
    var total = 0.0;
    _inventoryItems.forEach((key, item) {
      total += item.price * item.number;
    });

    return total;
  }

  void addItem({rewardId, price, title, img}) {
    if (_inventoryItems.containsKey(rewardId)) {
      _inventoryItems.update(
          rewardId,
              (ex) => Inventory(
            id: ex.id,
            title: ex.title,
            price: ex.price,
            img: ex.img,
            number: ex.number + 1,
          ));
    } else {
      _inventoryItems.putIfAbsent(
          rewardId,
              () => Inventory(
            id: '${DateTime.now()}',
            title: title,
            price: price,
            img: img,
            number: 1,
          ));
    }
    notifyListeners();
  }

  void deleteItem(String rewardId) {
    _inventoryItems.remove(rewardId);
    notifyListeners();
  }

  void updateItemsAddOne(String rewardId) {
    _inventoryItems.update(
      rewardId,
          (ex) => Inventory(
        id: ex.id,
        title: ex.title,
        price: ex.price,
        img: ex.img,
        number: ex.number + 1,
      ),
    );
    notifyListeners();
  }

  // Обновить корзину на -1 единицу товара по id
  void updateItemsSubOne(String rewardId) {
    if (_inventoryItems[rewardId]!.number < 2) {
      deleteItem(rewardId);
    } else {
      _inventoryItems.update(
        rewardId,
            (ex) => Inventory(
          id: ex.id,
          title: ex.title,
          price: ex.price,
          img: ex.img,
          number: ex.number - 1,
        ),
      );
    }
    notifyListeners();
  }

  void clear() {
    _inventoryItems = {};
    notifyListeners();
  }
}