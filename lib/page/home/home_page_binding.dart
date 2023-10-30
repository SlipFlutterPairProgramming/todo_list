import 'package:get/get.dart';
import 'package:todo_bentley/page/home/home_controller.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
