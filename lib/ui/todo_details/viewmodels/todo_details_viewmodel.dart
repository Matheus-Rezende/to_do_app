import 'package:flutter/material.dart';
import 'package:to_do_app/data/repositories/todos/todos_repository.dart';
import 'package:to_do_app/domain/models/todo_model.dart';
import 'package:to_do_app/utils/commands/commands.dart';
import 'package:to_do_app/utils/result/result.dart';

class TodoDetailsViewmodel extends ChangeNotifier {
  final TodosRepository _todosRepository;

  TodoDetailsViewmodel({required TodosRepository todosRepository}) : _todosRepository = todosRepository {
    load = Command1(_load);
  }

  late final Command1<TodoModel, String> load;

  late TodoModel _todo;

  TodoModel get todo => _todo;

  Future<Result<TodoModel>> _load(String id) async {
    try {
      final result = await _todosRepository.getTodoById(id: id);
      await Future.delayed(const Duration(seconds: 1));

      switch (result) {
        case Ok<TodoModel>():
          _todo = result.value;
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
