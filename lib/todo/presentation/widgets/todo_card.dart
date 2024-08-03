import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/todo/data/models/todo_model.dart';
import 'package:todo_list/todo/presentation/manager/todo_controller.dart';

class TodoCard extends StatelessWidget {
  TodoCard({super.key});
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.815,
      // color: Colors.green,
      child: ListView.builder(
        itemCount: todoController.todoList.length,
        itemBuilder: (context, index) {
          final todo = todoController.todoList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(todo.title),
                trailing: Checkbox(
                  value: todo.isCompleted,
                  activeColor: Colors.black,
                  onChanged: (value) {
                    todoController.toggleTodoStatus(index);
                  },
                ),
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => TodoDialog(
                    index: index,
                    todo: todo,
                    todoController: todoController,
                  ),
                ),
                onLongPress: () {
                  todoController.deleteTodoItem(index);
                },
              ),
            ),
          );
        },
      ),
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
