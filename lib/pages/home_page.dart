import 'package:flutter/material.dart';

class ToDoPage extends StatelessWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 56,
        ),
        TodoCard(),
        TodoCard(),
        TodoCard(),
        TodoCard(),
      ],
    ));
  }
}

class TodoCard extends StatelessWidget {
  const TodoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        decoration: const BoxDecoration(color: Colors.amber),
        child: const Row(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text('Title'),
                    Icon(
                      Icons.add_outlined,
                    )
                  ],
                ),
                Text('Descrition'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
