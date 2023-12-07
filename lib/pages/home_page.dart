import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_bentley/main.dart';
import 'package:todo_bentley/pages/add_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TodoController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffFF8181),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          TodoCategory(
            category: Category.toDo,
          ),
          TodoCategory(
            category: Category.toSchedule,
          ),
          TodoCategory(
            category: Category.toDelegate,
          ),
          TodoCategory(
            category: Category.toDelete,
          ),
        ],
      ),
    );
  }
}

class TodoCategoryData {
  final String description, title;
  final Color bgColor;
  final Color fontColor;

  TodoCategoryData({
    required this.title,
    required this.description,
    required this.bgColor,
    required this.fontColor,
  });
}

class TodoCategory extends StatelessWidget {
  final Category category;

  const TodoCategory({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.find();
    final ApiController apiController = Get.put(ApiController());
    // final data = apiController.fetchApiData({}, "get");
    // Test test = Test.fromJson(data);
    // print("test${apiController.apiData.value}");

    return FutureBuilder<dynamic>(
      future: apiController.fetchApiData({}, "get"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 데이터를 기다리는 동안 로딩 인디케이터를 보여줍니다.
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // 에러가 발생했을 때의 처리
          return Text('Error: ${snapshot.error}');
        } else {
          Map<String, dynamic> jsonMap =
              jsonDecode(apiController.apiData.value);
          Test test = Test.fromJson(jsonMap);

          List<Todo> filteredTodos = test.filterTodosByCategory(category);
          print(filteredTodos);
          return Obx(() {
            bool isSelected =
                Get.find<TodoController>().selectedCategory.value ==
                    category.value.title;

            bool isClicked =
                Get.find<TodoController>().selectedCategory.value != '';

            return Flexible(
              flex: isSelected ? 3 : 1,
              child: GestureDetector(
                onTap: () => controller.changeCategory(category.value.title),
                child: Container(
                  decoration: BoxDecoration(color: category.value.bgColor),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              category.value.title,
                              style: TextStyle(
                                color: category.value.fontColor,
                                fontSize: 32,
                                fontFamily: 'Jalnan',
                              ),
                            ),
                            GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AddScreen(),
                                    fullscreenDialog: true,
                                  ),
                                )
                              },
                              child: Icon(
                                category == Category.toDo
                                    ? Icons.add_outlined
                                    : null,
                                color: category.value.fontColor,
                                size: 32,
                              ),
                            )
                          ],
                        ),
                        isClicked
                            ? isSelected
                                ? Expanded(
                                    child: test.todos.isEmpty
                                        ? Center(
                                            child: Text(
                                              "Please create a Todo item.",
                                              style: TextStyle(
                                                color: category.value.fontColor,
                                                fontSize: 24,
                                              ),
                                            ),
                                          )
                                        : ListView.builder(
                                            itemCount: filteredTodos.length,
                                            itemBuilder: (context, index) {
                                              var todo = filteredTodos[index];
                                              return TodoTile(
                                                  todo.uuid,
                                                  TodoItem(
                                                      title: todo.content,
                                                      star: todo.favorite,
                                                      done: todo.done),
                                                  parseCategory(todo.category),
                                                  index);
                                            },
                                          ))
                                : const SizedBox()
                            : Text(
                                category.value.description,
                                style: TextStyle(
                                  color: category.value.fontColor,
                                  fontSize: 18,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        }
      },
    );
  }
}

class TodoTile extends StatelessWidget {
  TodoTile(
    this.uuid,
    this.item,
    this.category,
    this.index, {
    super.key,
  });
  final String uuid;
  final TodoItem item;
  final int index;
  final Category category;
  final TodoController controller = Get.find<TodoController>();
  final ApiController apiController = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(
        item.title + index.toString(),
      ),
      onDismissed: (direction) {
        apiController.fetchApiData({}, "delete",
            queryParameters: {"uuid": uuid});
        // controller.deleteTodo(
        //   category,
        //   index,
        // );
      },
      child: Card(
        elevation: 1.2,
        color: item.done ? Colors.white.withOpacity(0.4) : Colors.white,
        child: ListTile(
          onTap: () {
            controller.setTodoDone(
              category,
              index,
            );
          },
          onLongPress: () {
            controller.setTodoStar(
              category,
              index,
            );
          },
          title: Text(
            item.star ? '★ ${item.title}' : item.title,
            style: TextStyle(
              color: item.done
                  ? category.value.fontColor.withOpacity(0.6)
                  : category.value.fontColor,
              decoration:
                  item.done ? TextDecoration.lineThrough : TextDecoration.none,
              fontWeight: item.star ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          // 여기에 ListTile 구성요소들을 추가
        ),
      ),
    );
  }
}
