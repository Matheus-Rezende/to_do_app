import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_app/data/repositories/todos/todos_repository_remote.dart';
import 'package:to_do_app/data/services/api/api_client.dart';
import 'package:to_do_app/data/services/api/models/todo/todo_api_model.dart';
import 'package:to_do_app/domain/models/todo_model.dart';
import 'package:to_do_app/utils/result/result.dart';

import '../../../mock/todos.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  setUpAll(() {
    registerFallbackValue(updateTodoMock);
  });

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
      when(
        () => apiClient.postTodo(createTodoMock),
      ).thenAnswer((invocation) => Future.value(Result.ok(addTodoMock)));

      bool wasNotified = false;

      todosRepository.addListener(() {
        wasNotified = true;
      });

      final result = await todosRepository.add(
        name: createTodoMock.name,
        description: createTodoMock.description,
        done: createTodoMock.done,
      );

      expect(todosRepository.todos.contains(addTodoMock), isTrue);

      expect(result, isA<Ok<TodoModel>>());
      expect(result.asOk.value.id, '1');
      expect(result.asOk.value.name, 'Tarefa Criada');
      expect(result.asOk.value.description, 'Descrição Tarefa Criada');

      expect(wasNotified, true);
    });

    test('delete()', () async {
      when(
        () => apiClient.deleteTodo(addTodoMock),
      ).thenAnswer((invocation) => Future.value(Result.ok(null)));
      when(
        () => apiClient.getTodos(),
      ).thenAnswer((invocation) => Future.value(Result.ok([addTodoMock])));

      final getResult = await todosRepository.get();

      expect(getResult, isA<Ok<List<TodoModel>>>());
      expect(todosRepository.todos.contains(addTodoMock), isTrue);

      bool wasNotifier = false;

      todosRepository.addListener(() {
        wasNotifier = true;
      });

      final deleteResult = await todosRepository.delete(todo: addTodoMock);

      expect(deleteResult, isA<Ok<void>>());
      expect(todosRepository.todos.contains(addTodoMock), isFalse);
      expect(wasNotifier, true);
    });

    test('updateTodo()', () async {
      when(
        () => apiClient.getTodos(),
      ).thenAnswer((invocation) => Future.value(Result.ok(mockGetTodos)));

      when(
        () => apiClient.updateTodo(any(that: isA<UpdateApiTodoModel>())),
      ).thenAnswer((invocation) => Future.value(Result.ok(updateTodoMockResponse)));

      final result = await todosRepository.get();

      expect(result, isA<Ok<List<TodoModel>>>());

      final todos = result.asOk.value;

      bool wasNotified = false;

      todosRepository.addListener(() {
        wasNotified = true;
      });

      final resultUpdate = await todosRepository.update(
        todo: todos.first.copyWith(
          name: 'Nome alterado',
          description: 'Descrição alterada',
          done: true,
        ),
      );

      expect(resultUpdate, isA<Ok<TodoModel>>());

      final updatedTodo = resultUpdate.asOk.value;

      expect(updatedTodo.id, '1');
      expect(updatedTodo.name, 'Nome alterado');
      expect(updatedTodo.description, 'Descrição alterada');
      expect(updatedTodo.done, true);
      expect(todosRepository.todos.contains(updatedTodo), isTrue);
      expect(wasNotified, isTrue);
    });

    test('get()', () async {
      // Arrange - O que vai ser feito quando acontecer
      when(
        () => apiClient.getTodos(),
      ).thenAnswer((invocation) => Future.value(Result.ok(mockGetTodos)));

      // Act - A ação em progresso
      bool wasNotified = false;
      todosRepository.addListener(() {
        wasNotified = true;
      });
      final result = await todosRepository.get();

      // Assert - Verifica se a ação saiu como o esperado
      expect(result, isA<Ok<List<TodoModel>>>());
      expect(todosRepository.todos.length, 2);
      expect(todosRepository.todos, equals(mockGetTodos));

      expect(wasNotified, isTrue);
    });
  });
}
