import 'package:flutter/material.dart';
import 'package:to_do_app/data/repositories/todos/todos_repository.dart';
import 'package:to_do_app/domain/models/todo_model.dart';
import 'package:to_do_app/domain/use_cases/todo_update_use_case.dart';
import 'package:to_do_app/utils/commands/commands.dart';
import 'package:to_do_app/utils/result/result.dart';

class TodoDetailsViewmodel extends ChangeNotifier {
  TodoDetailsViewmodel({
    required TodosRepository todosRepository,
    required TodoUpdateUseCase todoUpdateUsecase,
  }) : _todosRepository = todosRepository,
       _todoUpdateUseCase = todoUpdateUsecase {
    load = Command1(_load);
    updateTodo = Command1(_todoUpdateUseCase.updateTodo);
  }

  final TodosRepository _todosRepository;
  final TodoUpdateUseCase _todoUpdateUseCase;

  late final Command1<TodoModel, String> load;
  late final Command1<TodoModel, TodoModel> updateTodo;

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
