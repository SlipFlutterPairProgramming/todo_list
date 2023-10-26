import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});
  final String category = "category";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.close),
        title: const Text("Create Todo"),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Text("What to do?"),
        TextField(),
        SizedBox(
          height: 50,
        ), 
        Text('How important it is?'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('To do'),
                Text('Urgent, Important Things.')
              ],
            ),
            Radio(
              value: Text('To Do'), groupValue: category, onChanged: (value) {
            },),
          ],
        ),
      ]),
    );
  }
}


class AddRadio extends StatelessWidget {
  const AddRadio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
