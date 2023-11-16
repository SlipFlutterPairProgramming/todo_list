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
            Column(
              children: [
                for (var group in Group.values) TodoGroupWidget(group: group),
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
                      color: Group.toDo.fg,
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

class _TodoGroupWidgetState extends State<TodoGroupWidget>
    with TickerProviderStateMixin {
  late AnimationController anmCtrl;
  late Animation flex;

  @override
  void initState() {
    super.initState();
    anmCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    flex = IntTween(
      begin: 100,
      end: 300,
    ).animate(anmCtrl);
  }

  void checkStateAndAction() {
    final ctrl = Get.find<TodoController>();
    if (ctrl.selectedGroup.value == widget.group) {
      anmCtrl.forward();
    } else {
      anmCtrl.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<TodoController>();
    return AnimatedBuilder(
      animation: anmCtrl,
      builder: (_, __) => Obx(
        () {
          checkStateAndAction();
          return Expanded(
            //추후 animation을 위해 flex를 크게 잡음
            flex: ctrl.selectedGroup.value == null ? flex.value : flex.value,
            child: GestureDetector(
              onTap: () {
                if (ctrl.selectedGroup.value == widget.group) {
                  ctrl.selectedGroup.value = null;
                } else {
                  ctrl.selectedGroup.value = widget.group;
                }
                checkStateAndAction();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6.5),
                color: widget.group.bg,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.group.title,
                          style: TextStyle(
                            color: widget.group.fg,
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
          );
        },
      ),
    );
  }
}
