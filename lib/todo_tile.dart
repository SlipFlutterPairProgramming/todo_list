import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import 'package:todo_bentley/main.dart';
import 'package:todo_bentley/todo_controller.dart';

enum Group { toDo, toSchedule, toDelegate, toDelete }

extension GroupExtension on Group {
  Color get fg {
    switch (this) {
      case Group.toDo:
        return const Color.fromARGB(255, 226, 235, 128);
      case Group.toSchedule:
        return const Color.fromARGB(255, 84, 37, 212);
      case Group.toDelegate:
        return const Color.fromARGB(255, 195, 127, 219);
      case Group.toDelete:
        return const Color.fromARGB(255, 186, 90, 90);
    }
  }

  Color get bg {
    switch (this) {
      case Group.toDo:
        return const Color.fromRGBO(228, 120, 120, 1);
      case Group.toSchedule:
        return const Color.fromARGB(255, 233, 210, 145);
      case Group.toDelegate:
        return const Color.fromARGB(255, 187, 237, 175);
      case Group.toDelete:
        return const Color.fromARGB(255, 102, 167, 169);
    }
  }

  String get title {
    switch (this) {
      case Group.toDo:
        return 'ToDo';
      case Group.toSchedule:
        return 'ToSchedule';
      case Group.toDelegate:
        return 'ToDelegate';
      case Group.toDelete:
        return 'ToDelete';
    }
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
    return Expanded(
      child: GestureDetector(
        key: Key(widget.uuid),
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
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: const Color.fromRGBO(1, 1, 1, 0.1),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    widget.favorite
                        ? Icon(Icons.star, color: widget.group.fg)
                        : const Text(''),
                    Text(widget.content,
                        style: TextStyle(
                          color: widget.group.fg,
                          decoration:
                              widget.done ? TextDecoration.lineThrough : null,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
