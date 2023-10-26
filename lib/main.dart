import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v6.dart';

import 'package:todo_bentley/inputing_dialog.dart';
import 'package:todo_bentley/todo_tile.dart';
import 'package:todo_bentley/todo_controller.dart';

void main() {
  runApp(TodoWidget());
}

class TodoWidget extends StatefulWidget {
  TodoWidget({super.key});
  // provider 스타일로 거진 최상위 위젯에 컨트롤러를 생성했고, put 하여 global singleton 처럼 사용하게 했어영
  final ctrl = Get.put(TodoController());

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'to HK H KH do',
      home: Scaffold(
        body: Stack(
          children: [
            const Column(
              children: [
                TodoGroupWidget(group: Group.toDo),
                TodoGroupWidget(group: Group.toSchedule),
                TodoGroupWidget(group: Group.toDelegate),
                TodoGroupWidget(group: Group.toDelete),
              ],
            ),
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(''),
                ),
                GestureDetector(
                  onTap: () => Get.bottomSheet(
                    const InputingDialog(),
                  ),
                  child: Text(
                    "+",
                    style: TextStyle(
                      color: getGroupColors(Group.toDo).$2,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TodoGroupWidget extends StatefulWidget {
  const TodoGroupWidget({super.key, required this.group});
  final Group group;

  @override
  State<TodoGroupWidget> createState() => _TodoGroupWidgetState();
}

class _TodoGroupWidgetState extends State<TodoGroupWidget> {
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<TodoController>();
    final (bg, fg) = getGroupColors(widget.group);
    return Obx(
      () => Expanded(
        //추후 animation을 위해 flex를 크게 잡음
        flex: ctrl.selectedGroup.value == widget.group ? 300 : 100,
        child: GestureDetector(
          onTap: () {
            if (ctrl.selectedGroup.value == widget.group) {
              ctrl.selectedGroup.value = Group.all;
            } else {
              ctrl.selectedGroup.value = widget.group;
            }
          },
          child: Container(
            color: bg,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      widget.group.name,
                      style: TextStyle(
                        color: fg,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Obx(() => ListView(
                        children: [
                          for (var tile in ctrl.list)
                            if (tile.group == widget.group) tile,
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
