import 'package:flutter_myapp_demo/data.dart';
import 'package:flutter_myapp_demo/todo_page/add_task.dart';
import 'package:flutter_myapp_demo/todo_page/task_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskData = context.watch<TasksProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Задания'),
      ),
      body: TaskList(taskData: taskData),                                 //Список заданий
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => addTask(context));     //добавление задания
          },
          backgroundColor: Colors.black,
          child: Icon(Icons.add_box, color: Colors.white)),
    );
  }
}
