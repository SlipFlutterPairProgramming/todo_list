import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_bentley/page/add/add_controller.dart';
import 'package:todo_bentley/page/home/home_controller.dart';

class AddPage extends GetView<AddController> {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: Colors.brown,
        title: const Text('Add Task', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 16, 0),
              child: Text(
                '제목',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              child: TextField(
                  controller: controller.titleController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.brown.shade50,
                  ),
                  onChanged: (title) => controller.updateTitle(title)),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 16, 0),
              child: Text(
                '설명',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              child: TextField(
                  controller: controller.descController,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.brown.shade50,
                  ),
                  onChanged: (desc) => controller.updateDesc(desc)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {
                      controller.addItem();
                      Get.back();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                    ),
                    child: const Text('추가',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
