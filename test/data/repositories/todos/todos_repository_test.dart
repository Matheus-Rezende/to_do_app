import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_app/data/repositories/todos/todos_repository_remote.dart';
import 'package:to_do_app/data/services/api/api_client.dart';
import 'package:to_do_app/domain/models/todo_model.dart';
import 'package:to_do_app/utils/result/result.dart';

import '../../../mock/todos.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late TodosRepositoryRemote todosRepository;
  late ApiClient apiClient;

  setUp(() {
    apiClient = MockApiClient();
    todosRepository = TodosRepositoryRemote(apiClient: apiClient);
  });

  group('TodosRepositoryRemote test', () {
    test('getById()', () async {
      // Arrange (Organização) - O que deve ser feito quando acontecer.
      when(
        () => apiClient.getTodoById(any()),
      ).thenAnswer((invocation) => Future.value(Result.ok(mockGetById)));

      // Act (Ação) - A execução da ação escolhida.
      final firstCallResult = await todosRepository.getTodoById(id: '1');
      final secondCallResult = await todosRepository.getTodoById(id: '1');

      // Assert (Verificação) - Verificamos se ação feita gerou o resultado esperado.
      expect(firstCallResult, isA<Ok<TodoModel>>());
      final firstCallTodo = firstCallResult.asOk.value;
      expect(firstCallTodo.id, '1');
      expect(firstCallTodo.name, 'Primeiro');
      expect(firstCallTodo.description, 'Primeira descrição');
      expect(firstCallTodo.done, false);

      expect(secondCallResult, isA<Ok<TodoModel>>());
      final secondCallTodo = secondCallResult.asOk.value;
      expect(secondCallTodo.id, '1');
      expect(secondCallTodo.name, 'Primeiro');
      expect(secondCallTodo.description, 'Primeira descrição');
      expect(secondCallTodo.done, false);

      verify(() => apiClient.getTodoById(any())).called(1);
    });

    test('add()', () async {
      when(() => apiClient.postTodo(createTodoMock)).thenAnswer(
        (invocation) => Future.value(
          Result.ok(
            TodoModel(
              id: '1',
              name: createTodoMock.name,
              description: createTodoMock.description,
              done: createTodoMock.done,
            ),
          ),
        ),
      );

      final result = await todosRepository.add(
        name: createTodoMock.name,
        description: createTodoMock.description,
        done: createTodoMock.done,
      );

      expect(result, isA<Ok<TodoModel>>());
      expect(result.asOk.value.id, '1');
    });
  });
}
