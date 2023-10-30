import 'package:get/get.dart';

import 'page/add/add_page.dart';
import 'page/add/add_page_binding.dart';
import 'page/home/home_page.dart';
import 'page/home/home_page_binding.dart';

abstract class PageRouter {
  static const initialPage = Pages.homePage;

  static final pages = [
    GetPage(
        name: Pages.homePage,
        page: () => const HomePage(),
        bindings: [
          HomePageBinding(),
        ],
        transition: Transition.fadeIn),
    GetPage(
        name: Pages.addPage,
        page: () => const AddPage(),
        bindings: [
          AddPageBinding(),
        ],
        transition: Transition.rightToLeft)
  ];
}

abstract class Pages {
  static const homePage = '/home';
  static const addPage = '/add';
}
