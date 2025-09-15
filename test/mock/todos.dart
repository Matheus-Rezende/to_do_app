import 'package:to_do_app/data/services/api/models/todo/todo_api_model.dart';
import 'package:to_do_app/domain/models/todo_model.dart';

final mockGetById = TodoModel(
  id: '1',
  name: 'Primeiro',
  description: 'Primeira descrição',
  done: false,
);

const createTodoMock = CreateApiTodoModel(
  name: 'Tarefa Criada',
  description: 'Descrição Tarefa Criada',
  done: false,
);

final addTodoMock = TodoModel(
  id: '1',
  name: createTodoMock.name,
  description: createTodoMock.description,
  done: createTodoMock.done,
);

final List<TodoModel> mockGetTodos = [
  TodoModel(
    id: '1',
    name: 'Primeira tarefa',
    description: 'Primeira descrição tarefa',
    done: false,
  ),
  TodoModel(id: '2', name: 'Segunda tarefa', description: 'Segunda descrição tarefa', done: true),
];

const updateTodoMock = UpdateApiTodoModel(
  id: '1',
  name: 'Nome alterado',
  description: 'Descrição alterada',
  done: true,
);

final updateTodoMockResponse = TodoModel(
  id: '1',
  name: 'Nome alterado',
  description: 'Descrição alterada',
  done: true,
);
