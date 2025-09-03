import 'package:to_do_app/data/repositories/todos/todos_repository.dart';
import 'package:to_do_app/domain/models/todo_model.dart';
import 'package:to_do_app/utils/result/result.dart';

class TodoUpdateUseCase {
  final TodosRepository _todosRepository;

  TodoUpdateUseCase({required TodosRepository todoRepository}) : _todosRepository = todoRepository;

  Future<Result<TodoModel>> updateTodo(TodoModel todo) async {
    try {
      final result = await _todosRepository.update(todo: todo);

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
