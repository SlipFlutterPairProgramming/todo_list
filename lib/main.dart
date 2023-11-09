import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TodoAppWidget(),
    );
  }
}

class TodoAppWidget extends StatelessWidget {
  const TodoAppWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class TodoController extends GetxController {
  final list = [].obs;
}

enum Group {toDo, toSchedule, toDelegate, toDelete}
(Color, Color) getGroupColors(Group group) {
  switch(group) {
    case Group.toDo:
      return (
      Color.fromRGBO(255, 129, 129, 1),
      Color.fromRGBO(208, 244, 164, 1)
      );
    case Group.toSchedule:
      return (
      Color.fromRGBO(208, 244, 164, 1),
      Color.fromRGBO(102, 119, 187, 1)
      );
    case Group.toDelegate:
      return (
      Color.fromRGBO(234, 255, 208, 1),
      Color.fromRGBO(210, 151, 243, 1)
      );
    case Group.toDelete:
      return (
      Color.fromRGBO(149, 225, 211, 1),
      Color.fromRGBO(226, 124, 127, 1)
      );
  }
}

class TodoCard extends StatefulWidget {
  const TodoCard({super.key, required this.group, required this.content,});
  final Group group;
  final String content;

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = getGroupColors(widget.group);
    return Row(
      children: [
        Expanded(child: Row(
          children: [

          ],
        ),),
      ],
    );
  }
}