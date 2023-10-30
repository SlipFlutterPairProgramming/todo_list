import 'package:get/get.dart';
import 'package:todo_bentley/page/add/add_controller.dart';
import 'package:todo_bentley/page/home/home_controller.dart';

class AddPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddController());
    Get.put(HomeController());
  }
}
