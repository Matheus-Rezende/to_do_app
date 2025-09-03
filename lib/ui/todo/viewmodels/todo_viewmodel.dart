import 'package:flutter/material.dart';
import 'package:to_do_app/utils/commands/commands.dart';
import 'package:to_do_app/utils/result/result.dart';
import 'package:to_do_app/data/repositories/todos/todos_repository.dart';
import 'package:to_do_app/domain/models/todo_model.dart';

class TodoViewmodel extends ChangeNotifier {
  TodoViewmodel({required TodosRepository todosRepository}) : _todosRepository = todosRepository {
    load = Command0(_load)..execute();
    addTodo = Command1(_addTodo);
    removeTodo = Command1(_removeTodo);
    updateTodo = Command1(_updateTodo);
  }

  final TodosRepository _todosRepository;
  late Command0 load;

  late Command1<TodoModel, (String, String, bool)> addTodo;

  late Command1<void, TodoModel> removeTodo;

  late Command1<TodoModel, TodoModel> updateTodo;

  List<TodoModel> _todos = [];

  List<TodoModel> get todos => _todos;

  Future<Result<List<TodoModel>>> _load() async {
    final result = await _todosRepository.get();

    switch (result) {
      case Ok<List<TodoModel>>():
        _todos = result.value;
        notifyListeners();
        break;
      case Error():
        //TODO: Implement Logging
        break;
    }
    return result;
  }

  Future<Result<TodoModel>> _addTodo((String, String, bool) todo) async {
    final (name, description, done) = todo;
    final result = await _todosRepository.add(name: name, description: description, done: done);

    switch (result) {
      case Ok<TodoModel>():
        _todos.add(result.value);
        notifyListeners();
        break;
      case Error():
        // TODO: Implement logging
        break;
    }
    return result;
  }

  Future<Result<void>> _removeTodo(TodoModel todo) async {
    final result = await _todosRepository.delete(todo: todo);

    switch (result) {
      case Ok<void>():
        _todos.remove(todo);
        notifyListeners();
        break;
      case Error():
        //TODO: Implement logging
        break;
    }
    return result;
  }

  Future<Result<TodoModel>> _updateTodo(TodoModel todo) async {
    final result = await _todosRepository.update(todo: todo);

    switch (result) {
      case Ok<TodoModel>():
        final todoIndex = _todos.indexWhere((e) => e.id == todo.id);
        _todos[todoIndex] = todo;
        notifyListeners();
        return Result.ok(result.value);
      default:
        return result;
    }
  }
}
