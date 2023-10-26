import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:todo_bentley/main.dart';
import 'package:todo_bentley/pages/add_page.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color(0xffFF8181),
        body: Column(
          children: [
            SizedBox(
              height: 56,
            ),
            TodoCard(
              title: 'To Do',
              description: 'Urgent, Important Things.',
              backgroundColor: Color(0xffFF8181),
              textColor: Color(0xffD0F4A4),
            ),
            TodoCard(
              title: 'To Schedule',
              description: 'Not Urgent, Important Things.',
              backgroundColor: Color(0xffFCE38A),
              textColor: Color(0xff6677BB),
            ),
            TodoCard(
              title: 'To Delegate',
              description: 'Urgent, Not Important Things.',
              backgroundColor: Color(0xffEAFFD0),
              textColor: Color(0xffD297F3),
            ),
            TodoCard(
              title: 'To Delelte',
              description: 'Not Urgent, Not Important Things.',
              backgroundColor: Color(0xff95E1D3),
              textColor: Color(0xffE27C7F),
            ),
          ],
        ));
  }
}

class TodoCard extends StatelessWidget {
  final String title;
  final String description;
  final Color backgroundColor;
  final Color textColor;
  const TodoCard({
    super.key,
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      // flex: 1,
      child: Container(
        decoration: BoxDecoration(color: backgroundColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Jalnan',
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddPage(),
                            fullscreenDialog: true,
                          ))
                    },
                    child: Icon(
                      title == "To Do" ? Icons.add_outlined : null,
                      size: 36,
                      color: textColor,
                    ),
                  )
                ],
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 20,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                child: Obx(() => ListView(
                  children: [
                    for (var tile in Get.find<MyController>().todoList)
                      Text(tile.title)
                  ],
                )),
              ),
              // Expanded(
              //   child: GetX<MyController>(
              //     builder: (controller){
              //       return ListView.builder(
              //         itemCount: controller.todoList.length,
              //         itemBuilder: (context, index) {
              //           return Text('${controller.todoList[index].title}');
              //       },);
              //     },
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
