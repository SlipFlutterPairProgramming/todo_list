import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:todo_bentley/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyController extends GetxController {
  final todoList = [].obs;
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
