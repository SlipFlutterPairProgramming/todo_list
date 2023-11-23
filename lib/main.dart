import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_bentley/pages/home_page.dart';

import 'package:http/http.dart' as http;

void main() {
  Get.put(TodoController());
  runApp(const MyApp());
}

enum Category { toDo, toSchedule, toDelegate, toDelete, unknown }

extension CategoryExtension on Category {
  TodoCategoryData get value {
    switch (this) {
      case Category.toDo:
        return TodoCategoryData(
            title: "To Do",
            description: "Urgent, Important Things.",
            bgColor: const Color(0xffFF8181),
            fontColor: const Color(0xff077522));
      case Category.toSchedule:
        return TodoCategoryData(
            title: 'To Schedule',
            description: "Not Urgent, Important Things.",
            bgColor: const Color(0xffFCE38A),
            fontColor: const Color(0xff6677bb));
      case Category.toDelegate:
        return TodoCategoryData(
            title: 'To Delegate',
            description: "Urgent, Not Important Things.",
            bgColor: const Color(0xffEAFFD0),
            fontColor: const Color(0xffBA55D3));
      case Category.toDelete:
        return TodoCategoryData(
            title: 'To Delete',
            description: "Not Urgent, Not Important Things.",
            bgColor: const Color(0xff95E1D3),
            fontColor: const Color(0xff569889));
      default:
        return TodoCategoryData(
          title: "Unknown",
          description: "Unknown",
          bgColor: Colors.white,
          fontColor: Colors.black,
        );
    }
  }
}

class TodoItem {
  String title;
  bool star;
  bool done;

  TodoItem({required this.title, this.star = false, this.done = false});
}

class TodoController extends GetxController {
  var selectedCategory = ''.obs;

  var todoList = {
    Category.toDo: <TodoItem>[
      TodoItem(title: 'Buy groceries', done: true),
      TodoItem(title: 'Walk the dog', star: true),
      TodoItem(title: 'Old newsletters'),
      TodoItem(title: 'Unused files'),
    ].obs,
    Category.toSchedule: <TodoItem>[
      TodoItem(title: 'Doctor appointment'),
      TodoItem(title: 'Team meeting'),
      TodoItem(title: 'Write monthly report'),
    ].obs,
    Category.toDelegate: <TodoItem>[
      TodoItem(title: 'Update website'),
    ].obs,
    Category.toDelete: <TodoItem>[].obs,
  }; // 각 카테고리의 할 일 목록도 관찰 가능한 리스트로 정의합니다.

  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  // 새로운 할 일 항목을 특정 카테고리에 추가합니다.
  void addTodoItem(Category category, String todoItem) {
    todoList[category]?.add(TodoItem(title: todoItem));
  }

  // 할 일 항목의 완료 상태를 토글합니다.
  void setTodoDone(Category category, int index) {
    var todoItem = todoList[category]?[index];
    if (todoItem != null) {
      todoItem.done = !todoItem.done;
      todoList[category]?.refresh();
    }
  }

  // 할 일 항목의 별표 상태를 토글합니다.
  void setTodoStar(Category category, int index) {
    var todoItem = todoList[category]?[index];
    if (todoItem != null) {
      todoItem.star = !todoItem.star;
      todoList[category]?.refresh();
    }
  }

  // 할 일 항목을 삭제합니다.
  void deleteTodo(Category category, int index) {
    todoList[category]?.removeAt(index);
    todoList[category]?.refresh();
  }
}

enum Method { get, put, delete }

class ApiController extends GetxController {
  String devId;
  Method method;

  ApiController({required this.devId, required this.method});

  var apiData = ''.obs;

  String url = "http://ec2-3-22-101-127.us-east-2.compute.amazonaws.com:8000";

  // API 호출 메서드
  Future<void> fetchApiData() async {
    final response = await http.post(Uri.parse("$url/$devId/$method"));
    if (response.statusCode == 200) {
      apiData.value = response.body;
    } else {
      // 오류 처리
      print('Failed to load data');
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
