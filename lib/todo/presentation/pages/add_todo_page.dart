import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/todo/data/models/todo_model.dart';
import 'package:todo_list/todo/presentation/manager/todo_controller.dart';

class AddTodoPage extends StatelessWidget {
  final TodoController controller = Get.find();
  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Todo Title'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                if (title.isNotEmpty) {
                  controller.addTodoItem(Todo(
                    title: title,
                  ));
                  Get.back();
                }
              },
              child: Text('Add Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
