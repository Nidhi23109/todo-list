import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/todo_controller.dart';
import 'package:todo_list/todo_model.dart';

class HomeView extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return Column(
            children: [
              todoController.todoList.isEmpty?Center(child: Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.4),
                child: Text("No List",style: TextStyle(fontSize: 24, color: Colors.black),),
              )):Container(
                height: Get.height * 0.83,
                // color: Colors.green,
                child: ListView.builder(
                  itemCount: todoController.todoList.length,
                  itemBuilder: (context, index) {
                    final todo = todoController.todoList[index];
                    return ListTile(
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
                    );
                  },
                ),
              ),
              Container(height: 50)
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => TodoDialog(
            todoController: todoController,
          ),
        ),
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
            if(titleController.text != ''){
              if (index == null) {
                todoController.addTodoItem(newTodo);
              } else {
                todoController.updateTodoItem(index!, newTodo);
              }
              Get.back();
            }else{
              Get.snackbar('Message', 'Please add title ',backgroundColor: Colors.redAccent.withOpacity(0.7));
            }

          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
