import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v6.dart';

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
                      color: getColors(Group.toDo).$2,
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

enum Group { all, toDo, toSchedule, toDelegate, toDelete }

(Color, Color) getColors(Group group) {
  switch (group) {
    case Group.toDo:
      return (
        const Color.fromRGBO(228, 120, 120, 1),
        const Color.fromARGB(255, 226, 235, 128),
      );
    case Group.toSchedule:
      return (
        const Color.fromARGB(255, 233, 210, 145),
        const Color.fromARGB(255, 84, 37, 212),
      );
    case Group.toDelegate:
      return (
        const Color.fromARGB(255, 187, 237, 175),
        const Color.fromARGB(255, 195, 127, 219),
      );
    case Group.toDelete:
      return (
        const Color.fromARGB(255, 102, 167, 169),
        const Color.fromARGB(255, 186, 90, 90),
      );

    default:
      return (Colors.black, Colors.white);
  }
}

class TodoController extends GetxController {
  //사실 <TodoGroupWidget>[].obs; 으로 하고, 각 todoGroupwidget에게 각각 자신의 리스트를 책임지게 하는게(또는 글로벌 obs에 depth를 주는게) 렌더링이 더 적을 것 같지만,
  //또 개인적으로는 추후 백엔드와 동기화가 필요한 obs와 그렇지 않은 obs를 분리해서 관리하는 것이
  //getx에 익숙하지 않으실 것 같아서 빠른 구현을 위한 형태로 짰습니다. 수월하시면 개선 부탁드려여
  final list = <TodoTile>[
    TodoTile(
      group: Group.toDo,
      content: 'hellohellohellohello\nhen\nee\nee',
    ),
    TodoTile(
      group: Group.toDelegate,
      content: 'do',
    ),
  ].obs;
  final selectedGroup = Group.all.obs;

  void removeTile(String uuid) {
    list.removeWhere((TodoTile tile) => tile.uuid == uuid);
  }

  void addTile(Group group, String content) {
    list.insert(
      0,
      TodoTile(
        group: group,
        content: content,
      ),
    );
  }

  void selectGroup(Group group) {
    selectedGroup.value = group;
  }
}

class InputingDialog extends StatefulWidget {
  const InputingDialog({super.key});

  @override
  State<InputingDialog> createState() => _InputingDialogState();
}

class _InputingDialogState extends State<InputingDialog> {
  final todoCtrl = Get.find<TodoController>();

  Group selectedGrop = Group.toDo;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Column(
            children: [
              for (var g in Group.values)
                if (g != Group.all)
                  ListTile(
                    title: Text(g.name),
                    leading: Radio<Group>(
                      value: g,
                      groupValue: selectedGrop,
                      onChanged: (Group? value) {
                        if (value != null) {
                          setState(() {
                            selectedGrop = value;
                          });
                        }
                      },
                    ),
                  )
            ],
          ),
          TextField(
            onSubmitted: (value) {
              if (value != '') {
                todoCtrl.addTile(selectedGrop, value);
              }
              Get.back();
            },
          ),
        ],
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
    final (bg, fg) = getColors(widget.group);
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

class TodoTile extends StatefulWidget {
  TodoTile({
    super.key,
    required this.group,
    required this.content,
  });
  static const uuidGen = Uuid();
  final Group group;
  final String content;
  bool favorite = false;
  bool done = false;
  final String uuid = TodoTile.uuidGen.v4();

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  Offset begin = Offset.zero;
  Offset end = Offset.zero;
  @override
  Widget build(BuildContext context) {
    final (_, color) = getColors(widget.group);
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onHorizontalDragStart: (DragStartDetails details) {
              begin = details.localPosition;
            },
            onHorizontalDragUpdate: (details) {
              end = details.localPosition;
            },
            onHorizontalDragEnd: (details) {
              final movement = end - begin;
              if (movement.dy.abs() < 10 && movement.dx > 20) {
                setState(() {
                  widget.done = true;
                });
              } else if (movement.dy.abs() < 10 && movement.dx < -20) {
                Get.find<TodoController>().removeTile(widget.uuid);
              }
              begin = Offset.zero;
              end = Offset.zero;
            },
            onLongPress: () => setState(() {
              widget.favorite = !widget.favorite;
            }),
            key: Key(widget.uuid),
            child: Row(
              children: [
                widget.favorite
                    ? Icon(Icons.star, color: color)
                    : const Text(''),
                Text(widget.content,
                    style: TextStyle(
                      color: color,
                      decoration:
                          widget.done ? TextDecoration.lineThrough : null,
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
