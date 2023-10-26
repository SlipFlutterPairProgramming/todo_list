import 'package:get/get.dart';

class Todo {
  String title;
  String content;
  bool isDone = false;
  bool isLike = false;

  Todo(this.title, this.content);
}

class TodoList extends GetxController {
  List<Todo> todoList = [];

  addList(Todo item) {
    todoList.add(item);
    update();
  }

  removeList(Todo item) {
    todoList.remove(item);
    update();
  }

  isDone(Todo item) {
    item.isDone = !item.isDone;
    update();
  }
  
  isLike(Todo item) {
    item.isLike = !item.isLike;
    if(item.isLike) {
      todoList.remove(item);
      todoList.insert(0, item);
    }

    update();
  }
}