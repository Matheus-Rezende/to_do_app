import 'package:flutter/material.dart';
import 'package:to_do_app/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:to_do_app/ui/todo_details/widgets/todo_dialog_content_widget.dart';

class AddTodoWidget extends StatefulWidget {
  final TodoViewmodel todoViewmodel;
  const AddTodoWidget({super.key, required this.todoViewmodel});

  @override
  State<AddTodoWidget> createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.todoViewmodel.addTodo.addListener(_onResult);
  }

  void _onResult() {
    if (widget.todoViewmodel.addTodo.running) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const AlertDialog(
          content: IntrinsicHeight(child: Center(child: CircularProgressIndicator())),
        ),
      );
    } else {
      if (widget.todoViewmodel.addTodo.completed) {
        Navigator.pop(context);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nova tarefa adicionada com sucesso!'), backgroundColor: Colors.green),
        );
      }
      if (widget.todoViewmodel.addTodo.error) {
        Navigator.pop(context);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao adicionar uma nova tarefa!'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TodoDialogContentWidget(
      formKey: _formKey,
      nameController: nameController,
      descriptionController: descriptionController,
      todoTitle: 'Criar tarefa',
      todoViewmodel: widget.todoViewmodel,
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
    widget.todoViewmodel.addTodo.removeListener(_onResult);
  }
}
