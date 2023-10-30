import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_bentley/data/model/task.dart';
import 'package:todo_bentley/page/home/home_controller.dart';

class TaskTile extends GetView<HomeController> {
  const TaskTile({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 3,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => controller.updateIsFavorite(
                    task.timeStamp ?? DateTime.now(), !task.isFavorite),
                icon: Icon(Icons.star,
                    color: task.isFavorite ? Colors.yellow : Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.all(7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title),
                    Text(
                      task.desc,
                      style:
                          const TextStyle(color: Colors.black12, fontSize: 12),
                    )
                  ],
                ),
              )
            ],
          ),
          IconButton(
              onPressed: () => controller.deleteItem(task),
              icon: const Icon(
                Icons.remove_circle_rounded,
                color: Colors.brown,
              ))
        ],
      ),
    );
  }
}
