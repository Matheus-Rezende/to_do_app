import 'package:flutter/material.dart';
import 'package:to_do_app/domain/models/todo_model.dart';
import 'package:to_do_app/ui/todo/viewmodels/todo_viewmodel.dart';

class TodoTile extends StatefulWidget {
  final TodoModel todo;
  final TodoViewmodel todoViewmodel;
  const TodoTile({super.key, required this.todo, required this.todoViewmodel});

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  void initState() {
    super.initState();
    widget.todoViewmodel.removeTodo.addListener(_onResult);
  }

  @override
  void dispose() {
    super.dispose();
    widget.todoViewmodel.removeTodo.removeListener(_onResult);
  }

  void _onResult() {
    if (widget.todoViewmodel.removeTodo.running) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const AlertDialog(
          content: IntrinsicHeight(child: Center(child: CircularProgressIndicator())),
        ),
      );
    } else {
      Navigator.of(context).pop();
      if (widget.todoViewmodel.removeTodo.completed) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tarefa excluida com sucesso!'), backgroundColor: Colors.green),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Um erro ocorreu ao excluir a tarefa!'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('${widget.todo.id}'),
      title: Text(widget.todo.name),
      trailing: IconButton(
        onPressed: () => widget.todoViewmodel.removeTodo.execute(widget.todo),
        icon: const Icon(Icons.delete, color: Colors.red),
      ),
    );
  }
}
