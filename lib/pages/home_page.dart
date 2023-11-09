import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_bentley/main.dart';
import 'package:todo_bentley/pages/add_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TodoController controller =
      Get.put(TodoController()); // 컨트롤러 인스턴스를 생성하고 GetX에 등록합니다.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFF8181),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          TodoCategory(
            category: "To Do",
            text: "Urgent, Important Things.",
            bgColor: const Color(0xffFF8181),
            fontColor: const Color(0xffD0F4A4),
            onTap: () => controller.changeCategory("To Do"),
          ),
          TodoCategory(
            category: "To Schedule",
            text: "Not Urgent, Important Things.",
            bgColor: const Color(0xffFCE38A),
            fontColor: const Color(0xff6677bb),
            onTap: () => controller.changeCategory("To Schedule"),
          ),
          TodoCategory(
            category: "To Delegate",
            text: "Urgent, Not Important Things.",
            bgColor: const Color(0xffEAFFD0),
            fontColor: const Color(0xffD297F3),
            onTap: () => controller.changeCategory("To Delegate"),
          ),
          TodoCategory(
            category: "To Delete",
            text: "Not Urgent, Not Important Things.",
            bgColor: const Color(0xff95E1D3),
            fontColor: const Color(0xffE27C7F),
            onTap: () => controller.changeCategory("To Delete"),
          ),
        ],
      ),
    );
  }
}

class TodoCategory extends StatelessWidget {
  final String category, text;
  final Color bgColor, fontColor;
  final VoidCallback onTap;

  const TodoCategory({
    super.key,
    required this.category,
    required this.text,
    required this.bgColor,
    required this.fontColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final TodoController controller =
        Get.put(TodoController()); // 컨트롤러 인스턴스를 생성하고 GetX에 등록합니다.

    return Obx(() {
      bool isSelected =
          Get.find<TodoController>().selectedCategory.value == category;

      bool isClicked = Get.find<TodoController>().selectedCategory.value != '';

      var todoItems = controller.todoList[category];
      return Flexible(
        flex: isSelected ? 2 : 1,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(color: bgColor),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category,
                        style: TextStyle(
                            color: fontColor,
                            fontSize: 32,
                            fontFamily: 'Jalnan'),
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
                          category == 'To Do' ? Icons.add_outlined : null,
                          color: fontColor,
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
                                          key: Key(index.toString()),
                                          //우측 드래그 배경
                                          background:
                                              Container(color: Colors.red),
                                          //좌측 드래그 배경
                                          secondaryBackground:
                                              Container(color: Colors.green),
                                          onDismissed: (direction) {
                                            if (direction ==
                                                DismissDirection.startToEnd) {
                                              // 우측으로 드래그 시 수행할 액션
                                              controller.setTodoStar(
                                                  category,
                                                  index,
                                                  !todoItems[index].star);
                                            } else if (direction ==
                                                DismissDirection.endToStart) {
                                              // 좌측으로 드래그 시 수행할 액션
                                              controller.deleteTodo(
                                                category,
                                                index,
                                              );
                                            }
                                          },
                                          child: InkWell(
                                            onTap: () {
                                              // ListTile 클릭 시 수행할 액션
                                              controller.setTodoDone(
                                                  category,
                                                  index,
                                                  !todoItems[index].done);
                                            },
                                            child: Card(
                                              color: bgColor.withOpacity(0.7),
                                              child: ListTile(
                                                title: Text(
                                                  todoItems[index].star
                                                      ? '★ ${todoItems[index].title}'
                                                      : todoItems[index].title,
                                                  style: TextStyle(
                                                    decoration: todoItems[index]
                                                            .done
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
                                          ),
                                        );
                                      },
                                    ))
                          : const SizedBox()
                      : Text(
                          text,
                          style: TextStyle(
                            color: fontColor,
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
