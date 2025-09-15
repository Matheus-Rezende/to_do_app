import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/data/services/api/api_client.dart';
import 'package:to_do_app/data/services/api/models/todo/todo_api_model.dart';
import 'package:to_do_app/domain/models/todo_model.dart';
import 'package:to_do_app/utils/result/result.dart';

import '../../mock/http_client_mock.dart';
import '../../mock/todos.dart';

void main() {
  late ApiClient apiClient;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    apiClient = ApiClient(clientHttpFactory: () => mockHttpClient);
  });
  group('Should test [ApiClient]', () {
    test('Should return Result Ok when getTodos()', () async {
      // Arrange
      mockHttpClient.mockGet(path: '/todos', object: mockGetTodos);
      // Act
      final result = await apiClient.getTodos();
      // Assert
      expect(result.asOk.value, isA<List<TodoModel>>());
    });
    test('Should getTodoById()', () async {
      // Arrange
      mockHttpClient.mockGet(path: '/todos/1', object: mockGetById);

      // Act
      final result = await apiClient.getTodoById('1');

      // Assert
      final todo = result.asOk.value;
      expect(todo.id, '1');
    });

    test('Should return Result Ok when creating postTodo()', () async {
      const CreateApiTodoModel todoCreated = CreateApiTodoModel(
        name: 'Teste',
        description: 'Test description',
        done: false,
      );
      final result = await apiClient.postTodo(todoCreated);
      expect(result.asOk.value, isA<TodoModel>());
    });

    test('Should delete when deleteTodo()', () async {
      const CreateApiTodoModel todoCreated = CreateApiTodoModel(
        name: 'Teste',
        description: 'Test description',
        done: false,
      );

      final createdTodoResult = await apiClient.postTodo(todoCreated);

      final deleteTodoResult = await apiClient.deleteTodo(createdTodoResult.asOk.value);

      expect(deleteTodoResult.asOk, isA<Result<void>>());
    });

    test('Should update when updateTodo()', () async {
      const CreateApiTodoModel todoCreated = CreateApiTodoModel(
        name: 'Teste',
        description: 'Test description',
        done: false,
      );

      final createdTodoResult = await apiClient.postTodo(todoCreated);

      final result = await apiClient.updateTodo(
        UpdateApiTodoModel(
          id: createdTodoResult.asOk.value.id,
          name:
              '${createdTodoResult.asOk.value.name} updatedDate ${DateTime.now().toIso8601String()}',
          description: createdTodoResult.asOk.value.description,
          done: true,
        ),
      );

      expect(result, isA<Result<TodoModel>>());
      expect(result.asOk.value.done, true);
    });
  });
}
