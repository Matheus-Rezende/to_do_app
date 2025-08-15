import 'package:to_do_app/utils/result/result.dart';
import 'package:to_do_app/domain/models/todo_model.dart';

abstract class TodosRepository {
  Future<Result<List<TodoModel>>> get();
  Future<Result<TodoModel>> add({required String name});
  Future<Result<void>> delete({required TodoModel todo});
}
