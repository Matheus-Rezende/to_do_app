import 'package:flutter/material.dart';
import 'package:to_do_app/ui/todo_details/viewmodels/todo_details_viewmodel.dart';
import 'package:to_do_app/ui/todo_details/widgets/edit_todo_widget.dart';
import 'package:to_do_app/ui/todo_details/widgets/todo_appbar_widget.dart';
import 'package:to_do_app/ui/todo_details/widgets/todo_widget.dart';

class TodoDetailsScreen extends StatelessWidget {
  final TodoDetailsViewmodel todoDetailsViewmodel;
  const TodoDetailsScreen({super.key, required this.todoDetailsViewmodel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: todoDetailsViewmodel.load,
        builder: (context, child) {
          if (todoDetailsViewmodel.load.running) {
            return const Center(child: CircularProgressIndicator());
          }
          if (todoDetailsViewmodel.load.error) {
            return const Center(child: Text('Ocorreu um erro ao carregar os detalhes do Todo'));
          }

          return child!;
        },
        child: ListenableBuilder(
          listenable: todoDetailsViewmodel,
          builder: (context, child) {
            return Column(
              children: [
                TodoAppbarWidget(title: todoDetailsViewmodel.todo.name),
                TodoWidget(todo: todoDetailsViewmodel.todo),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (todoDetailsViewmodel.load.completed) {
            showDialog(
              context: context,
              builder: (context) {
                return EditTodoWidget(todoDetailsViewmodel: todoDetailsViewmodel);
              },
            );
          }
        },
        child: ListenableBuilder(
          listenable: todoDetailsViewmodel.load,
          builder: (context, child) {
            if (todoDetailsViewmodel.load.running) {
              return const CircularProgressIndicator();
            }
            if (todoDetailsViewmodel.load.error) {
              return const Icon(Icons.warning);
            } else {
              return const Icon(Icons.edit);
            }
          },
        ),
      ),
    );
  }
}
