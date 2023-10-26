import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todo_bentley/main.dart';
import 'package:todo_bentley/todo_controller.dart';
import 'package:todo_bentley/todo_tile.dart';

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
    print('hello');
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
