import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_bentley/main.dart';
import 'package:todo_bentley/pages/add_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TodoController controller = Get.put(TodoController());

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

enum Category { toDo, toSchedule, toDelegate, toDelete }

extension CategoryExtension on Category {
  TodoCategoryData get value {
    switch (this) {
      case Category.toDo:
        return TodoCategoryData(
            title: "To Do",
            description: "Urgent, Important Things.",
            bgColor: const Color(0xffFF8181),
            fontColor: const Color(0xffD0F4A4));
      case Category.toSchedule:
        return TodoCategoryData(
            title: 'To Schedule',
            description: "Not Urgent, Important Things.",
            bgColor: const Color(0xffFCE38A),
            fontColor: const Color(0xff6677bb));
      case Category.toDelegate:
        return TodoCategoryData(
            title: 'To Delegate',
            description: "Urgent, Not Important Things.",
            bgColor: const Color(0xffEAFFD0),
            fontColor: const Color(0xffD297F3));
      case Category.toDelete:
        return TodoCategoryData(
            title: 'To Delete',
            description: "Not Urgent, Not Important Things.",
            bgColor: const Color(0xff95E1D3),
            fontColor: const Color(0xffE27C7F));
      default:
        return TodoCategoryData(
          title: "Unknown",
          description: "Unknown",
          bgColor: Colors.white,
          fontColor: Colors.black,
        );
    }
  }
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

    return Obx(() {
      bool isSelected = Get.find<TodoController>().selectedCategory.value ==
          category.value.title;

      bool isClicked = Get.find<TodoController>().selectedCategory.value != '';

      var todoItems = controller.todoList[category.value.title];
      return Flexible(
        flex: isSelected ? 2 : 1,
        child: GestureDetector(
          onTap: () => controller.changeCategory(category.value.title),
          child: Container(
            decoration: BoxDecoration(color: category.value.bgColor),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                          category == Category.toDo ? Icons.add_outlined : null,
                          color: category.value.fontColor,
                          size: 32,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  isClicked
                      ? isSelected
                          ? Expanded(
                              child: todoItems == null || todoItems.isEmpty
                                  ? const Text("Todo를 생성해주세요.")
                                  : ListView.builder(
                                      itemCount: todoItems.length,
                                      itemBuilder: (context, index) {
                                        return Dismissible(
                                          key: Key(
                                            todoItems[index].title +
                                                index.toString(),
                                          ),
                                          onDismissed: (direction) {
                                            controller.deleteTodo(
                                              category.value.title,
                                              index,
                                            );
                                          },
                                          child: Card(
                                            color: category.value.bgColor
                                                .withOpacity(0.7),
                                            child: ListTile(
                                              onTap: () {
                                                controller.setTodoDone(
                                                  category.value.title,
                                                  index,
                                                );
                                              },
                                              onLongPress: () {
                                                controller.setTodoStar(
                                                  category.value.title,
                                                  index,
                                                );
                                              },
                                              title: Text(
                                                todoItems[index].star
                                                    ? '★ ${todoItems[index].title}'
                                                    : todoItems[index].title,
                                                style: TextStyle(
                                                  decoration:
                                                      todoItems[index].done
                                                          ? TextDecoration
                                                              .lineThrough
                                                          : TextDecoration.none,
                                                  fontWeight:
                                                      todoItems[index].star
                                                          ? FontWeight.w700
                                                          : FontWeight.w400,
                                                ),
                                              ),
                                              // 여기에 ListTile 구성요소들을 추가
                                            ),
                                          ),
                                        );
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
}
