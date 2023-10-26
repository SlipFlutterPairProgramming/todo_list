import 'package:get/get.dart';
import 'package:todo_bentley/todo_tile.dart';

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
