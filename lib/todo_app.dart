import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'page_router.dart';

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        enableLog: true,
        getPages: PageRouter.pages,
        theme: ThemeData(useMaterial3: true),
        initialRoute: Pages.homePage);
  }
}
