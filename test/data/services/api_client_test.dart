import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/data/services/api/api_client.dart';
import 'package:to_do_app/domain/models/todo_model.dart';
import 'package:to_do_app/utils/result/result.dart';

void main() {
  late ApiClient apiClient;

  setUp(() {
    apiClient = ApiClient();
  });
  group('Should test [ApiClient]', () {
    test('Should return Result Ok when getTodos()', () async {
      final result = await apiClient.getTodos();
      expect(result.asOk.value, isA<List<TodoModel>>());
    });

    test('Should return Result Ok when creating postTodo()', () async {
      final TodoModel todoCreated = TodoModel(name: 'Todo created on test');
      final result = await apiClient.postTodo(todoCreated);
      expect(result.asOk.value, isA<TodoModel>());
    });

    test('Should delete when deleteTodo()', () async {
      final TodoModel todoCreated = TodoModel(name: 'Todo criado com sucesso');

      final createdTodoResult = await apiClient.postTodo(todoCreated);

      final deleteTodoResult = await apiClient.deleteTodo(createdTodoResult.asOk.value);

      expect(deleteTodoResult.asOk, isA<Result<void>>());
    });
  });
}
