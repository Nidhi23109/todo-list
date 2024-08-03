import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/todo_model.dart';

class TodoController extends GetxController {
  var todoList = <Todo>[].obs;
  late Box<Todo> todoBox;

  @override
  void onInit() {
    super.onInit();
    todoBox = Hive.box<Todo>('todos');
    loadTodos();
  }

  void loadTodos() {
    todoList.value = todoBox.values.toList();
  }

  void addTodoItem(Todo todo) {
    todoBox.add(todo);
    loadTodos();
  }

  void updateTodoItem(int index, Todo todo) {
    todoBox.putAt(index, todo);
    loadTodos();
  }

  void deleteTodoItem(int index) {
    todoBox.deleteAt(index);
    loadTodos();
  }

  void toggleTodoStatus(int index) {
    Todo todo = todoList[index];
    todo.isCompleted = !todo.isCompleted;
    todoBox.putAt(index, todo);
    loadTodos();
  }
}
