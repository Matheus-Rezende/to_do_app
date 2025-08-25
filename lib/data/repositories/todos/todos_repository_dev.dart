import 'package:to_do_app/utils/result/result.dart';
import 'package:to_do_app/data/repositories/todos/todos_repository.dart';
import 'package:to_do_app/domain/models/todo_model.dart';

class TodosRepositoryDev implements TodosRepository {
  final List<TodoModel> _todos = [];
  @override
  Future<Result<TodoModel>> add({required String name}) async {
    final lastTodoIndex = _todos.length;

    final TodoModel createdTodo = TodoModel(id: (lastTodoIndex).toString(), name: name);

    return Result.ok(createdTodo);
  }

  @override
  Future<Result<void>> delete({required TodoModel todo}) async {
    if (_todos.contains(todo)) {
      _todos.remove(todo);
    }

    return Result.ok(null);
  }

  @override
  Future<Result<List<TodoModel>>> get() async {
    return Result.ok(_todos);
  }
}
