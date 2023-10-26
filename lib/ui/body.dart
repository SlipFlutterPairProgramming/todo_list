import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_bentley/ui/todo.dart';

class TodoBody extends StatelessWidget {
  List<Todo> todoList;

  TodoBody({super.key, required this.todoList,});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoList>(builder: (controller) {
      return ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) => ListTile(
          
          leading: Icon(
            todoList[index].isDone ?
                Icons.done : Icons.circle_outlined
          ),
          title: Text(todoList[index].title),
          subtitle: Text(todoList[index].content),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: () {
                controller.isLike(todoList[index]);
              }, icon: Icon(
                todoList[index].isLike ?
                    Icons.star : Icons.star_border_outlined
              ),),
              IconButton(onPressed: () {
                controller.removeList(todoList[index]);
              }, icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),)
            ],
          ),
        ),
      );
    },);
  }
}
