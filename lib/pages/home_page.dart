import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_bentley/main.dart';
import 'package:todo_bentley/pages/add_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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

    return Obx(() {
      bool isSelected = Get.find<TodoController>().selectedCategory.value ==
          category.value.title;

      bool isClicked = Get.find<TodoController>().selectedCategory.value != '';

      var todoItems = controller.todoList[category];
      return Flexible(
        flex: isSelected ? 3 : 1,
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
                  isClicked
                      ? isSelected
                          ? Expanded(
                              child: todoItems == null || todoItems.isEmpty
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
                                      itemCount: todoItems.length,
                                      itemBuilder: (context, index) {
                                        return Dismissible(
                                          key: Key(
                                            todoItems[index].title +
                                                index.toString(),
                                          ),
                                          onDismissed: (direction) {
                                            controller.deleteTodo(
                                              category,
                                              index,
                                            );
                                          },
                                          child: Card(
                                            elevation: 2,
                                            color: Colors.white,
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
                                                todoItems[index].star
                                                    ? '★ ${todoItems[index].title}'
                                                    : todoItems[index].title,
                                                style: TextStyle(
                                                  color: todoItems[index].done
                                                      ? category.value.fontColor
                                                      : category.value.fontColor
                                                          .withOpacity(0.6),
                                                  decoration:
                                                      todoItems[index].done
                                                          ? TextDecoration
                                                              .lineThrough
                                                          : TextDecoration.none,
                                                  fontWeight:
                                                      todoItems[index].star
                                                          ? FontWeight.w700
                                                          : FontWeight.w500,
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
