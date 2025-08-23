import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/data/services/api/api_client.dart';
import 'package:to_do_app/data/services/api/models/todo/todo_api_model.dart';
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
      const CreateApiTodoModel todoCreated = CreateApiTodoModel(name: 'Teste');
      final result = await apiClient.postTodo(todoCreated);
      expect(result.asOk.value, isA<TodoModel>());
    });

    test('Should delete when deleteTodo()', () async {
      const CreateApiTodoModel todoCreated = CreateApiTodoModel(name: 'Teste');

      final createdTodoResult = await apiClient.postTodo(todoCreated);

      final deleteTodoResult = await apiClient.deleteTodo(createdTodoResult.asOk.value);

      expect(deleteTodoResult.asOk, isA<Result<void>>());
    });

    test('Should update when updateTodo()', () async {
      const CreateApiTodoModel todoCreated = CreateApiTodoModel(name: 'Teste');

      final createdTodoResult = await apiClient.postTodo(todoCreated);

      final result = await apiClient.updateTodo(
        UpdateApiTodoModel(
          id: createdTodoResult.asOk.value.id!,
          name: '${createdTodoResult.asOk.value.name} updatedDate ${DateTime.now().toIso8601String()}',
        ),
      );

      expect(result, isA<Result<TodoModel>>());
    });
  });
}
