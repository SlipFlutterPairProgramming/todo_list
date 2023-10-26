import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Todo"),
      ),
      body: const Column(children: [
        Text("What to do?"),
        TextField(),
        SizedBox(
          height: 50,
        )
      ]),
    );
  }
}
