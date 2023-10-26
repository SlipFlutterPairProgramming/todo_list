import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_bentley/main.dart';
import 'package:todo_bentley/model/todo_item.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String category = "category";
  final todoController = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Todo"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("What to do?"),
          const TextField(),
          const SizedBox(
            height: 50,
          ),
          const Text('How important it is?'),
          radioWidget(title: "To Do", subTitle: "Urgent, Important Things."),
          radioWidget(
              title: "To Schedule", subTitle: "Not Urgent, Important Things."),
          radioWidget(
              title: "To Delegate", subTitle: "Urgent, Not Important Things."),
          radioWidget(
              title: "To Delete",
              subTitle: "Not Urgent, Not Important Things."),
      TextButton(
        onPressed: () {
          todoController.addItem(TodoItem('test'));
          // Navigator.pop(context);
          Get.back();
        },
        child: const Text('Create'),
      )
        ],
      ),
    );
  }

  Row radioWidget({required String title, required String subTitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(title), Text(subTitle)],
        ),
        Radio(
          value: title,
          groupValue: category,
          onChanged: (value) {
            setState(() {
              category = value.toString();
            });
          },
        ),
      ],
    );
  }
}
