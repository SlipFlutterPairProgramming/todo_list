import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_bentley/main.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String _selectedValue = '';
  Color _selectedBgColor = const Color(0xffC8C8C8);
  Color _selectedFontColor = const Color(0xff000000);

  final TodoController controller =
      Get.put(TodoController()); // 컨트롤러 인스턴스를 생성하고 GetX에 등록합니다.

  // TextEditingController 인스턴스를 생성합니다.
  final textController = TextEditingController();

  @override
  void dispose() {
    // 위젯이 dispose 될 때 컨트롤러도 dispose 해줍니다.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              todoRow(
                title: 'To Do',
                description: 'Urgent, Important Things.',
                fontColor: const Color(0xffD0F4A4),
                bgColor: const Color(0xffFF8181),
              ),
              todoRow(
                title: 'To Schedule',
                description: 'Not Urgent, Important Things.',
                bgColor: const Color(0xffFCE38A),
                fontColor: const Color(0xff6677bb),
              ),
              todoRow(
                title: 'To Delegate',
                description: 'Urgent, Not Important Things.',
                bgColor: const Color(0xffEAFFD0),
                fontColor: const Color(0xffD297F3),
              ),
              todoRow(
                title: 'To Delete',
                description: 'Not Urgent, Not Important Things.',
                bgColor: const Color(0xff95E1D3),
                fontColor: const Color(0xffE27C7F),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        controller.addTodoItem(
                            _selectedValue, textController.text);
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(BorderSide(
                          color: _selectedFontColor, // 테두리 색상을 파란색으로 설정
                          width: 2.0, // 테두리 두께를 2.0으로 설정
                        )),
                      ),
                      child: Text(
                        'Create',
                        style: TextStyle(
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

  GestureDetector todoRow({
    required String title,
    required String description,
    required Color fontColor,
    required Color bgColor,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedBgColor = bgColor;
          _selectedFontColor = fontColor;
          _selectedValue = title;
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
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    color: _selectedValue == title ? fontColor : Colors.black,
                    fontFamily: "Jalnan",
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: _selectedValue == title ? fontColor : Colors.black,
                  ),
                ),
              ],
            ),
            Radio(
              value: title,
              activeColor: fontColor,
              groupValue: _selectedValue,
              onChanged: (value) {
                setState(() {
                  _selectedValue = value.toString();
                  _selectedBgColor = bgColor;
                  _selectedFontColor = fontColor;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
