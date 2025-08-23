import 'package:to_do_app/data/services/api/models/todo/todo_api_model.dart';

void main() {
  const TodoApiModel todoApiModel = TodoApiModel.create(name: 'Teste');

  print(todoApiModel.toJson());

  const todoCreate = CreateApiTodoModel(name: 'Teste1');

  print(todoCreate.toJson());

  const updateTodo = UpdateApiTodoModel(id: '3bd5', name: 'Testtando api');

  print(updateTodo.toJson());
}
