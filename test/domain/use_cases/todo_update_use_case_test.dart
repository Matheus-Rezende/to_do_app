import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_app/data/repositories/todos/todos_repository.dart';
import 'package:to_do_app/domain/models/todo_model.dart';
import 'package:to_do_app/domain/use_cases/todo_update_use_case.dart';
import 'package:to_do_app/utils/result/result.dart';

import '../../mock/todos.dart';

class TodosRepositoryMock extends Mock implements TodosRepository {}

void main() {
  late TodosRepository todosRepository;
  late TodoUpdateUseCase todoUpdateUseCase;

  setUp(() {
    todosRepository = TodosRepositoryMock();
    todoUpdateUseCase = TodoUpdateUseCase(todosRepository: todosRepository);
  });
  group('TodoUpdateUseCase tests', () {
    test('updateTodo() returns Ok()', () async {
      // Arrange - O que deve ser feito.
      when(
        () => todosRepository.update(todo: useCaseUpdateTodoMock),
      ).thenAnswer((_) => Future.value(Result.ok(useCaseUpdateTodoMock)));

      // Act - A ação que sendo feita.
      final result = await todoUpdateUseCase.updateTodo(useCaseUpdateTodoMock);

      // Assert - Verifica se ação saiu como esperada.
      expect(result, isA<Ok<TodoModel>>());
    });

    test('updateTodo() returns error()', () async {
      when(
        () => todosRepository.update(todo: useCaseUpdateTodoMock),
      ).thenAnswer((_) => Future.value(Result.error(Exception('Gerou um erro'))));

      final result = await todoUpdateUseCase.updateTodo(useCaseUpdateTodoMock);

      expect(result, isA<Error>());
    });
  });
}
