import 'package:get/get.dart';
import 'package:todo_bentley/data/model/task.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  RxList<Task> taskList = List<Task>.empty().obs;

  updateIsFavorite(DateTime timestamp, bool state) {
    List<Task> newList = List.of(taskList);
    for (var element in taskList) {
      if (element.timeStamp == timestamp) {
        element.isFavorite = state;
        newList.sort((a, b) => a.isFavorite ? 0 : 1);
        taskList.value = newList;
        return;
      }
    }
  }

  deleteItem(Task item) {
    taskList.remove(item);
  }
}
