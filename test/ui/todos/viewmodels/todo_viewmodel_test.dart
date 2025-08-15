import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/data/repositories/todos/todos_repository.dart';
import 'package:to_do_app/data/repositories/todos/todos_repository_dev.dart';
import 'package:to_do_app/ui/todo/viewmodels/todo_viewmodel.dart';

void main() {
  group('Should test todo viewmodel', () {
    late TodoViewmodel todoViewmodel;
    late TodosRepository todosRepository;

    setUp(() {
      todosRepository = TodosRepositoryDev();
      todoViewmodel = TodoViewmodel(todosRepository: todosRepository);
    });
    test('Verifying Viewmodel initialState', () {
      expect(todoViewmodel.todos, isEmpty);
    });
    test('Should add todo', () async {
      await todoViewmodel.addTodo.execute('Todo teste');

      expect(todoViewmodel.todos, isNotEmpty);

      expect(todoViewmodel.todos.first.name, contains('Todo teste'));

      expect(todoViewmodel.todos.first.id, 1);
    });
    test('Should remove todo', () async {
      if (todoViewmodel.todos.isNotEmpty) {
        await todoViewmodel.removeTodo.execute(todoViewmodel.todos.first);
      }

      expect(todoViewmodel.todos, isEmpty);
    });
  });
}
