import 'package:flutter/material.dart';
import 'package:to_do_app/utils/result/result.dart';
import 'package:to_do_app/domain/models/todo_model.dart';

abstract class TodosRepository extends ChangeNotifier {
  List<TodoModel> get todos;
  Future<Result<List<TodoModel>>> get();
  Future<Result<TodoModel>> add({required String name, required String description, required bool done});
  Future<Result<void>> delete({required TodoModel todo});
  Future<Result<TodoModel>> update({required TodoModel todo});
  Future<Result<TodoModel>> getTodoById({required String id});
}
