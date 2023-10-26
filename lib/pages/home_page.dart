import 'package:flutter/material.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 56,
        ),
        TodoCard(title: 'TODO', description: 'Urgent, Important Thins', Colors.red, Colors.lightGreenAccent),
        TodoCard(title: 'To Schedule', description: 'Urgent, Important Thins',),
        TodoCard(title: 'To Delegate', description: 'Urgent, Important Thins',),
        TodoCard(title: 'To Delelte', description: 'Urgent, Important Thins',),
      ],
    ));
  }
}

class TodoCard extends StatelessWidget {
  final String title;
  final String description;
  final MaterialColor backgroundColor;
  final MaterialColor textColor;
  const TodoCard({
    super.key,
    required this.title, required this.description, required this.backgroundColor, required this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(color: backgroundColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(fontSize: 24, color:  textColor,),),
                Icon(
                  title == "TODO" ? Icons.add_outlined : null,
                )
              ],
            ),
            Text(description, style: TextStyle(fontSize: 24, color:  textColor,),),
          ],
        ),
      ),
    );
  }
}
