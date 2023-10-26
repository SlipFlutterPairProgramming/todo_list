import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_bentley/ui/home.dart';
import 'package:todo_bentley/ui/todo.dart';

void main() {
  Get.put(TodoList());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
