import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:todo_bentley/model/todo_item.dart';
import 'package:todo_bentley/pages/home_page.dart';

void main() {
  Get.put(MyController());
  runApp(const MyApp());
}

class MyController extends GetxController {
  var todoList = <TodoItem>[].obs;

  void addItem(TodoItem todoItem){
    todoList.add(todoItem);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ToDoPage(),
    );
  }
}
