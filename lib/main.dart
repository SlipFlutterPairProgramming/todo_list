import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_bentley/pages/home_page.dart';

void main() {
  Get.put(TodoController("kh"));
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

class TodoProvider extends GetConnect {
  Future<Response> getTodos(String devId) {
    return post(
        "http://ec2-3-22-101-127.us-east-2.compute.amazonaws.com:8000/$devId/get",
        {});
  }

  Future<Response> putTodos(
      String devId, TodoItem todoItem, Category category) {
    return post(
        "http://ec2-3-22-101-127.us-east-2.compute.amazonaws.com:8000/$devId/put",
        {
          "uuid": todoItem.title,
          "content": todoItem.title,
          "category": category.name,
          "favorite": todoItem.star,
          "done": todoItem.done,
        });
  }
}

class TodoController extends GetxController {
  TodoController(String devId) {
    todoProvider.getTodos(devId).then((value) {
      var resTodo = value.body["todos"];
      var todo = {for (var item in todoList.keys) item: todoList[item]!.value};
      for (var item in resTodo) {
        String category = item["category"];
        todo[Category.values.byName(category)]!.add(TodoItem(
            title: item["content"],
            done: item["done"],
            star: item["favorite"]));
      }
      for (var category in todo.keys) {
        todoList[category]!.value = todo[category]!;
      }
    });
  }

  TodoProvider todoProvider = TodoProvider();

  var selectedCategory = ''.obs;

  var todoList = {
    Category.toDo: <TodoItem>[].obs,
    Category.toSchedule: <TodoItem>[].obs,
    Category.toDelegate: <TodoItem>[].obs,
    Category.toDelete: <TodoItem>[].obs,
  }; // 각 카테고리의 할 일 목록도 관찰 가능한 리스트로 정의합니다.

  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  // 새로운 할 일 항목을 특정 카테고리에 추가합니다.
  void addTodoItem(Category category, String content) async {
    final todoItem = TodoItem(title: content);
    todoList[category]?.add(todoItem);
    await todoProvider.putTodos("kh", todoItem, category);
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
