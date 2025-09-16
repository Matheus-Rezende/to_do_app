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
      // Arrange
      mockHttpClient.mockPost(path: '/todos', object: createTodoMockResponse);

      // Act
      final result = await apiClient.postTodo(createTodoMockPost);

      // Assert
      expect(result.asOk.value, isA<TodoModel>());
    });

    test('Should delete when deleteTodo()', () async {
      mockHttpClient.mockDelete(path: '/todos/1', object: deleteTodoMock);

      final result = await apiClient.deleteTodo(deleteTodoMock);

      expect(result, isA<Result<void>>());
    });

    test('Should update when updateTodo()', () async {
      final updatedTodo = TodoModel(
        id: '1',
        name: 'Tarefa atualizada',
        description: 'Descrição atualizada',
        done: false,
      );
      const todoToUpdate = UpdateApiTodoModel(
        id: '1',
        name: 'Tarefa que vai ser atualizada',
        description: 'descrição que vai ser atualizada',
        done: false,
      );

      mockHttpClient.mockPut(path: '/todos/1', object: updatedTodo);

      final result = await apiClient.updateTodo(todoToUpdate);

      expect(result, isA<Result<TodoModel>>());
      expect(result.asOk.value.name, isNot(todoToUpdate.name));
      expect(result.asOk.value.description, isNot(todoToUpdate.description));
    });
  });
}
