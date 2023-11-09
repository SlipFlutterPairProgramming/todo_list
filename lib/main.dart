import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

/*
1. 
2. getxcontoller debugging, tile 보이기
3. 
4. add tile 구현 및 라우팅
5. delete, done, favorite  fun 구현
6. delete, done, favorite gestureDetector 구현
7. favorite 을 정렬로 재구현

*/

void main() {
  Get.put(TodobContorller());
  runApp(const GetMaterialApp(
      title: 'third JG KH', home: Scaffold(body: Todob())));
}

class Todob extends StatelessWidget {
  const Todob({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var group in Group.values)
          if (group != Group.all) TodobGroup(group: group)
      ],
    );
  }
}

enum Group { all, Todo, ToSedule, ToDelegate, ToDelete }

class TodobContorller extends GetxController {
  final list = <TodobTile>[
    TodobTile(content: 'hello', group: Group.Todo),
  ].obs;
  final selected = Group.all.obs;
  final addSelected = Group.all.obs;

  void addTile(String content, Group group) {
    list.insert(0, TodobTile(content: content, group: group));
  }

  void deleteTile() {}

  void selectGroup() {}
}

class TodobGroup extends GetView<TodobContorller> {
  const TodobGroup({super.key, required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 100,
      child: GestureDetector(
          onTap: () => Get.bottomSheet(const AddPage()),
          //     SingleChildScrollView(
          //   child: Column(
          //     children: [
          //       TextField(
          //           onSubmitted: (text) => controller.addTile(text, Group.Todo)),
          //     ],
          //   ),
          // )
          child: Column(
            children: [
              Text(group.name),
              Expanded(
                child: Obx(
                  () => ListView(
                    children: [
                      for (var tile in controller.list)
                        if (tile.group == group) tile
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class TodobTile extends StatefulWidget {
  TodobTile({
    super.key,
    required this.content,
    required this.group,
  });

  final content;
  final group;
  final uuid = uuidGen.v4();
  static const uuidGen = Uuid();

  @override
  State<TodobTile> createState() => _TodobTileState();
}

class _TodobTileState extends State<TodobTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star),
        Text(widget.content),
      ],
    );
  }
}

class AddPage extends GetView<TodobContorller> {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Column(
          children: [
            TextField(
                onSubmitted: (text) => controller.addTile(text, Group.Todo)),
          ],
        ),
      ),
    );
  }
}
