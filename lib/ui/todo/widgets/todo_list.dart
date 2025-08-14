import 'package:flutter/material.dart';
import 'package:to_do_app/domain/models/todo_model.dart';
import 'package:to_do_app/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:to_do_app/ui/todo/widgets/todo_tile.dart';

class TodoList extends StatelessWidget {
  final List<TodoModel> todos;
  final TodoViewmodel todoViewmodel;
  const TodoList({super.key, required this.todos, required this.todoViewmodel});

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(
        child: Text(
          'Vamos adicionar novas tarefas?',
          style: TextStyle(fontSize: 32.0),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return TodoTile(todo: todos[index], todoViewmodel: todoViewmodel);
        },
      );
    }
  }
}
