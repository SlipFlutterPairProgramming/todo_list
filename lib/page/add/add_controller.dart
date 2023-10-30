import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_bentley/data/model/task.dart';
import 'package:todo_bentley/page/home/home_controller.dart';

class AddController extends GetxController {
  final HomeController homeController = Get.find();

  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController descController = TextEditingController(text: '');

  late RxList<Task> taskList = homeController.taskList;
  Task? newItem;

  @override
  void onClose() {
    titleController.dispose();
    descController.dispose();
    super.onClose();
  }

  void addItem() {
    if (newItem != null) {
      newItem?.timeStamp = DateTime.now();
      taskList.add(newItem!);
      taskList.sort(
              (a, b) => a.isFavorite ? 0 : b.timeStamp!.compareTo(a.timeStamp!));
      newItem = null;
      // titleController = TextEditingController(text: '');
      // descController = TextEditingController(text: '');
    }
  }

  updateTitle(String title) {
    if (newItem == null) {
      newItem = Task(title, "");
    } else {
      newItem?.title = title;
    }
  }

  updateDesc(String desc) {
    if (newItem == null) {
      newItem = Task("", desc);
    } else {
      newItem?.desc = desc;
    }
  }
}
