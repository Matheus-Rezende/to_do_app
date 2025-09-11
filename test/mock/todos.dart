import 'package:to_do_app/data/services/api/models/todo/todo_api_model.dart';
import 'package:to_do_app/domain/models/todo_model.dart';

final mockGetById = TodoModel(id: '1', name: 'Primeiro', description: 'Primeira descrição', done: false);

const createTodoMock = CreateApiTodoModel(
  name: 'Tarefa Criada',
  description: 'Descrição Tarefa Criada',
  done: false,
);
