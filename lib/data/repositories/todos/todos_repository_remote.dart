import 'package:flutter/material.dart';
import 'package:to_do_app/data/repositories/todos/todos_repository.dart';
import 'package:to_do_app/data/services/api/api_client.dart';
import 'package:to_do_app/data/services/api/models/todo/todo_api_model.dart';
import 'package:to_do_app/domain/models/todo_model.dart';
import 'package:to_do_app/utils/result/result.dart';

class TodosRepositoryRemote extends ChangeNotifier implements TodosRepository {
  TodosRepositoryRemote({required ApiClient apiClient}) : _apiClient = apiClient;
  final ApiClient _apiClient;

  @override
  // TODO: implement todos
  List<TodoModel> get todos => _todos;

  List<TodoModel> _todos = [];

  @override
  Future<Result<TodoModel>> add({
    required String name,
    required String description,
    required bool done,
  }) async {
    try {
      final result = await _apiClient.postTodo(
        CreateApiTodoModel(name: name, description: description, done: done),
      );

      switch (result) {
        case Ok<TodoModel>():
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<void>> delete({required TodoModel todo}) async {
    try {
      final result = await _apiClient.deleteTodo(todo);

      switch (result) {
        case Ok<void>():
          return Result.ok(null);
        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<List<TodoModel>>> get() async {
    try {
      final result = await _apiClient.getTodos();

      switch (result) {
        case Ok<List<TodoModel>>():
          _todos = result.value;
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<TodoModel>> getTodoById({required String id}) async {
    try {
      final result = await _apiClient.getTodoById(id);

      switch (result) {
        case Ok<TodoModel>():
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<TodoModel>> update({required TodoModel todo}) async {
    try {
      final result = await _apiClient.updateTodo(
        UpdateApiTodoModel(id: todo.id, name: todo.name, description: todo.description, done: todo.done),
      );

      switch (result) {
        case Ok<TodoModel>():
          final todoIndex = _todos.indexWhere((e) => e.id == todo.id);
          _todos[todoIndex] = result.value;
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }
}
