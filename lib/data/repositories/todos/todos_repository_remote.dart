import 'package:to_do_app/data/repositories/todos/todos_repository.dart';
import 'package:to_do_app/data/services/api/api_client.dart';
import 'package:to_do_app/data/services/api/models/todo/todo_api_model.dart';
import 'package:to_do_app/domain/models/todo_model.dart';
import 'package:to_do_app/utils/result/result.dart';

class TodosRepositoryRemote implements TodosRepository {
  const TodosRepositoryRemote({required ApiClient apiClient}) : _apiClient = apiClient;
  final ApiClient _apiClient;

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
    }
  }

  @override
  Future<Result<List<TodoModel>>> get() async {
    try {
      final result = await _apiClient.getTodos();

      switch (result) {
        case Ok<List<TodoModel>>():
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
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
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
