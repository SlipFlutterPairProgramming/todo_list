import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_bentley/pages/home_page.dart';

void main() {
  runApp(const MyApp());
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
    'To Do': <TodoItem>[
      TodoItem(title: 'Buy groceries', done: true),
      TodoItem(title: 'Walk the dog', star: true),
      TodoItem(title: 'Old newsletters'),
      TodoItem(title: 'Unused files'),
    ].obs,
    'To Schedule': <TodoItem>[
      TodoItem(title: 'Doctor appointment'),
      TodoItem(title: 'Team meeting'),
      TodoItem(title: 'Write monthly report'),
    ].obs,
    'To Delegate': <TodoItem>[
      TodoItem(title: 'Update website'),
    ].obs,
    'To Delete': <TodoItem>[].obs,
  }.obs; // 각 카테고리의 할 일 목록도 관찰 가능한 리스트로 정의합니다.

  void changeCategory(String category) {
    selectedCategory.value = category; // 상태를 업데이트하는 메서드입니다.
  }

  // 새로운 할 일 항목을 특정 카테고리에 추가합니다.
  void addTodoItem(String category, String todoItem) {
    // 카테고리의 존재 여부를 체크하고 항목을 추가합니다.
    if (todoList.containsKey(category)) {
      todoList[category]?.add(TodoItem(title: todoItem));
    } else {
      // 주어진 카테고리가 존재하지 않을 경우 경고 메시지를 표시하거나 예외를 처리합니다.
      print('Category does not exist');
    }
  }

  void setTodoDone(String category, int index, bool isDone) {
    var todoItem = todoList[category]?[index];
    if (todoItem != null) {
      todoItem.done = isDone;
      todoList[category]?.refresh(); // UI 업데이트를 위해 상태를 갱신합니다.
    }
  }

  // 할 일 항목의 별표 상태를 토글합니다.
  void setTodoStar(String category, int index, bool isStar) {
    var todoItem = todoList[category]?[index];
    if (todoItem != null) {
      todoItem.star = isStar;
      todoList[category]?.refresh(); // UI 업데이트를 위해 상태를 갱신합니다.
    }
  }

  // 할 일 항목을 삭제합니다.
  void deleteTodo(String category, int index) {
    todoList[category]?.removeAt(index);
    todoList[category]?.refresh(); // UI 업데이트를 위해 상태를 갱신합니다.
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
