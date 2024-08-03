import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/todo/presentation/manager/todo_controller.dart';
import 'package:todo_list/todo/presentation/pages/add_todo_page.dart';
import 'package:todo_list/todo/presentation/pages/homepage.dart';

class AddFloatingButton extends StatelessWidget {
  AddFloatingButton({super.key});
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      child: const Icon(Icons.add),
      onPressed: () => Get.to(AddTodoPage()),
    );
  }
}
