import 'package:flutter/material.dart';
import 'package:to_do_app/core/commands/commands.dart';
import 'package:to_do_app/core/result/result.dart';
import 'package:to_do_app/domain/models/todo_model.dart';

class TodoViewmodel extends ChangeNotifier {
  TodoViewmodel() {
    load = Command0(_load)..execute();
    addTodo = Command1(_addTodo);
    removeTodo = Command1(_removeTodo);
  }
  late Command0 load;

  late Command1<TodoModel, String> addTodo;

  late Command1<String, TodoModel> removeTodo;

  List<TodoModel> _todos = [];

  List<TodoModel> get todos => _todos;

  Future<Result> _load() async {
    await Future.delayed(const Duration(seconds: 2));
    final List<TodoModel> todos = [];

    _todos = todos;

    notifyListeners();

    return Result.ok(todos);
  }

  Future<Result<TodoModel>> _addTodo(String name) async {
    await Future.delayed(const Duration(seconds: 2));

    final lastTodoIndex = _todos.length;

    final createdTodo = TodoModel(id: lastTodoIndex, name: name);

    _todos.add(createdTodo);

    notifyListeners();

    return Result.ok(createdTodo);
  }

  Future<Result<String>> _removeTodo(TodoModel todo) async {
    await Future.delayed(const Duration(seconds: 1));

    _todos.remove(todo);

    notifyListeners();
    return Result.ok('Removido com sucesso!');
  }
}
