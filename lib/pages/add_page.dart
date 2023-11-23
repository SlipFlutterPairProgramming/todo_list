import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_bentley/main.dart';
import 'package:uuid/v4.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  Category _selectedCategory = Category.unknown;
  Color _selectedBgColor = const Color(0xffC8C8C8);
  Color _selectedFontColor = const Color(0xff000000);

  final TodoController controller = Get.find();

  final textController = TextEditingController();

  String devId = "";

  final textUserController = TextEditingController();

  @override
  void dispose() {
    // 위젯이 dispose 될 때 컨트롤러도 dispose 해줍니다.
    textController.dispose();
    textUserController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    textUserController.addListener(() {
      setState(() {
        devId = textUserController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final apiController = Get.put(ApiController());

    return Scaffold(
      backgroundColor: _selectedBgColor,
      appBar: AppBar(
        backgroundColor: _selectedBgColor,
        foregroundColor: _selectedFontColor,
        elevation: 0,
        title: const Text('Create Todo'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Divider(
            height: 2,
            color: _selectedFontColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What to do?',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: "Jalnan",
                  color: _selectedFontColor,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextField(
                controller: textController,
                style: TextStyle(
                  color: _selectedFontColor,
                  fontWeight: FontWeight.w600,
                ), // TextField에 컨트롤러를 할당합니다.
                decoration: InputDecoration(
                  hintText: 'Enter To Do Item',
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _selectedFontColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'How important it is?',
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: "Jalnan",
                  color: _selectedFontColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              todoRow(Category.toDo),
              todoRow(Category.toSchedule),
              todoRow(Category.toDelegate),
              todoRow(Category.toDelete),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        apiController.fetchApiData({
                          "uuid": UuidV4,
                          "category": _selectedCategory,
                          "content": textController.text,
                          "favorite": false,
                          "done": false
                        }, devId, "put");
                        controller.addTodoItem(
                            _selectedCategory, textController.text);
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(BorderSide(
                          color: _selectedFontColor,
                          width: 2.0,
                        )),
                      ),
                      child: Text(
                        'Create',
                        style: TextStyle(
                          fontSize: 24,
                          color: _selectedFontColor,
                          fontFamily: "Jalnan",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector todoRow(Category category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedBgColor = category.value.bgColor;
          _selectedFontColor = category.value.fontColor;
          _selectedCategory = category;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.value.title,
                  style: TextStyle(
                    fontSize: 22,
                    color: _selectedCategory == category
                        ? category.value.fontColor
                        : Colors.black,
                    fontFamily: "Jalnan",
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  category.value.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: _selectedCategory == category
                        ? category.value.fontColor
                        : Colors.black,
                  ),
                ),
              ],
            ),
            Radio(
              value: category,
              activeColor: category.value.fontColor,
              groupValue: _selectedCategory,
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                  _selectedBgColor = category.value.bgColor;
                  _selectedFontColor = category.value.fontColor;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
