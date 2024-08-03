import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/todo/data/models/todo_model.dart';

class TodoController extends GetxController {
  var todoList = <Todo>[].obs;
  late Box<Todo> todoBox;
  var filter = 'all'.obs;
  final TextEditingController titleController = TextEditingController();
  final int index = 0;
  late final Todo? todo;


  @override
  void onInit() {
    super.onInit();
    todoBox = Hive.box<Todo>('todos');
    loadTodos();
      todoList.value= getPendingTodos();

  }

  void loadTodos() {
    todoList.value = todoBox.values.toList();
  }

  void addTodoItem(Todo todo) {
    todoBox.add(todo);
    loadTodos();
  }

  updateTodoItem(int index, Todo todo) {
    todoBox.putAt(index, todo);
    loadTodos();
  }

  deleteTodoItem(int index) {
    todoBox.deleteAt(index);
    loadTodos();
  }

  List<Todo> getCompletedTodos() {
    return todoList.where((todo) => todo.isCompleted).toList();
  }

  List<Todo> getPendingTodos() {
    todoList.length;
    return todoList.where((todo) => !todo.isCompleted).toList();
  }

  void toggleTodoStatus(int index) {
    Todo todo = todoList[index];
    todo.isCompleted = !todo.isCompleted;
    todoBox.putAt(index, todo);
    loadTodos();
  }
}
