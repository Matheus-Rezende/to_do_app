import 'package:flutter/material.dart';
import 'package:to_do_app/domain/models/todo_model.dart';
import 'package:to_do_app/ui/todo/viewmodels/todo_viewmodel.dart';

class TodoDeleteButtonWidget extends StatefulWidget {
  final TodoModel todo;
  final TodoViewmodel todoViewmodel;
  const TodoDeleteButtonWidget({super.key, required this.todoViewmodel, required this.todo});

  @override
  State<TodoDeleteButtonWidget> createState() => _TodoDeleteButtonWidgetState();
}

class _TodoDeleteButtonWidgetState extends State<TodoDeleteButtonWidget> {
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
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
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
    return IconButton(
      onPressed: () => widget.todoViewmodel.removeTodo.execute(widget.todo),
      icon: const Icon(Icons.delete, color: Colors.red),
    );
  }
}
