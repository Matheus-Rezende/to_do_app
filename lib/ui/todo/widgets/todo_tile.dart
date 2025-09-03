import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/domain/models/todo_model.dart';
import 'package:to_do_app/routing/routes.dart';
import 'package:to_do_app/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:to_do_app/ui/todo/widgets/todo_delete_button_widget.dart';

class TodoTile extends StatelessWidget {
  final TodoModel todo;
  final TodoViewmodel todoViewmodel;
  const TodoTile({super.key, required this.todo, required this.todoViewmodel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(Routes.todoDetails(todo.id)),
      child: Card(
        child: ListTile(
          leading: Checkbox(
            value: todo.done,
            onChanged: (value) {
              todoViewmodel.updateTodo.execute(todo.copyWith(done: value));
            },
          ),
          title: Text(todo.name),
          trailing: TodoDeleteButtonWidget(todoViewmodel: todoViewmodel, todo: todo),
        ),
      ),
    );
  }
}
