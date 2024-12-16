import 'package:aeth_analytica/ToDo/todo.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';


void main() async {

  await Hive.initFlutter();
  await Hive.openBox('tasksBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To_Do ',
      home: ToDoApp(),debugShowCheckedModeBanner: false,
    );
  }
}
