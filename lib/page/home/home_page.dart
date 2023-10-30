import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_bentley/page/home/home_controller.dart';
import 'package:todo_bentley/page/home/widget/task_tile.dart';
import 'package:todo_bentley/page_router.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.brown,
            title: const Center(
                child:
                    Text('To-Do List', style: TextStyle(color: Colors.white))),
          ),
          body: controller.taskList.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
                  child: ListView.builder(
                      itemCount: controller.taskList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          TaskTile(task: controller.taskList[index])),
                )
              : const Center(
                  child: Text(
                    '할 일을 추가해주세요!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.toNamed(Pages.addPage);
              },
              backgroundColor: Colors.brown.shade300,
              child: const Icon(Icons.add, color: Colors.white)),
          floatingActionButtonLocation: FloatingActionButtonLocation
              .centerFloat // This trailing comma makes auto-formatting nicer for build methods.
          ),
    );
  }
}
