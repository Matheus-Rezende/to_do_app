import 'package:logging/logging.dart';
import 'package:to_do_app/data/repositories/todos/todos_repository.dart';
import 'package:to_do_app/domain/models/todo_model.dart';
import 'package:to_do_app/utils/result/result.dart';

class TodoUpdateUseCase {
  final TodosRepository _todosRepository;
  final _log = Logger('TodoUpdateUsecase');

  TodoUpdateUseCase({required TodosRepository todosRepository}) : _todosRepository = todosRepository;

  Future<Result<TodoModel>> updateTodo(TodoModel todo) async {
    try {
      final result = await _todosRepository.update(todo: todo);

      switch (result) {
        case Ok<TodoModel>():
          _log.fine('Todo alterado com sucesso!');
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error, stacktrace) {
      _log.warning('Falha ao alterar todo: ', error, stacktrace);
      return Result.error(error);
    }
  }
}
