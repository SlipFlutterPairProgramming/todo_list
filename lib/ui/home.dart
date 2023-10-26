import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_bentley/ui/body.dart';
import 'package:todo_bentley/ui/todo.dart';

class HomePage extends StatelessWidget {
  String title = "";
  String content = "";

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoList>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text("My Todo Lists"),
          backgroundColor: Color.fromARGB(255, 116, 137, 214),
          actions: [
            IconButton(onPressed: () {

            }, icon: Icon(
              Icons.account_box,
              color: Colors.white,
            ),),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: Text("input todo list"),
              actions: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "input title",
                  ),
                  onChanged: (value) {
                    title = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "input content",
                  ),
                  onChanged: (value) {
                    content = value;
                  },
                ),
                SizedBox(
                  height: 60,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: TextButton(
                      onPressed: () {
                        controller.addList(Todo(title, content));

                        Navigator.pop(context);
                      },
                      child: Text("add"),
                    ),
                  ),
                ),
              ],
            );
          },);

        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
        body: TodoBody(todoList: controller.todoList),
    ),
    );
  }
}
