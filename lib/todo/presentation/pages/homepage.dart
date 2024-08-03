import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/todo/presentation/manager/todo_controller.dart';
import 'package:todo_list/todo/data/models/todo_model.dart';
import 'package:todo_list/todo/presentation/widgets/add_floating_button.dart';
import 'package:todo_list/todo/presentation/widgets/todo_card.dart';

class HomeView extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'Filter',
            onSelected: (value) {
              if (value == 'completed') {
                todoController.loadTodos();
                todoController.todoList.value =
                    todoController.getCompletedTodos();
              } else if (value == 'pending') {
                todoController.loadTodos();
                todoController.todoList.value =
                    todoController.getPendingTodos();
              } else {
                todoController.loadTodos();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'all', child: Text('All')),
              PopupMenuItem(value: 'completed', child: Text('Completed')),
              PopupMenuItem(value: 'pending', child: Text('Pending')),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return Column(
            children: [
              todoController.todoList.isEmpty
                  ? Center(
                      child: Padding(
                      padding: EdgeInsets.symmetric(vertical: Get.height * 0.4),
                      child: Text(
                        "No List",
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    ))
                  : TodoCard(),
              Container(height: 50)
            ],
          );
        }),
      ),
      floatingActionButton: AddFloatingButton(),
    );
  }
}

class TodoDialog extends StatelessWidget {
  final TodoController todoController;
  final int? index;
  final Todo? todo;
  final TextEditingController titleController = TextEditingController();

  TodoDialog({required this.todoController, this.index, this.todo}) {
    if (todo != null) {
      titleController.text = todo!.title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(index == null ? 'Add Todo' : 'Update Todo'),
      content: TextField(
        controller: titleController,
        decoration: InputDecoration(hintText: 'Title'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            final newTodo = Todo(
              title: titleController.text,
              isCompleted: todo?.isCompleted ?? false,
            );
            if (titleController.text != '') {
              if (index == null) {
                todoController.addTodoItem(newTodo);
              } else {
                todoController.updateTodoItem(index!, newTodo);
              }
              Get.back();
            } else {
              Get.snackbar('Message', 'Please add title ',
                  backgroundColor: Colors.redAccent.withOpacity(0.7));
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
