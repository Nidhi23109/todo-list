import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/todo/presentation/manager/todo_controller.dart';
import 'package:todo_list/todo/presentation/pages/homepage.dart';

class TodoCard extends StatelessWidget {
  TodoCard({super.key});
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.83,
      // color: Colors.green,
      child: ListView.builder(
        itemCount: todoController.todoList.length,
        itemBuilder: (context, index) {
          final todo = todoController.todoList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                // shape: RoundedRectangleBorder(
                //   side: BorderSide(color: Colors.black, width: 1),
                //   borderRadius: BorderRadius.circular(10),
                // ),
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
