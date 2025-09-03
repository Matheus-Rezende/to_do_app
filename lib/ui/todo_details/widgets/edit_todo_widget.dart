import 'package:flutter/material.dart';
import 'package:to_do_app/ui/todo_details/viewmodels/todo_details_viewmodel.dart';
import 'package:to_do_app/ui/todo_details/widgets/todo_dialog_content_widget.dart';

class EditTodoWidget extends StatefulWidget {
  final TodoDetailsViewmodel todoDetailsViewmodel;
  const EditTodoWidget({super.key, required this.todoDetailsViewmodel});

  @override
  State<EditTodoWidget> createState() => _EditTodoWidgetState();
}

class _EditTodoWidgetState extends State<EditTodoWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController = TextEditingController(
    text: widget.todoDetailsViewmodel.todo.name,
  );
  late final TextEditingController descriptionController = TextEditingController(
    text: widget.todoDetailsViewmodel.todo.description,
  );
  @override
  Widget build(BuildContext context) {
    return TodoDialogContentWidget(
      formKey: _formKey,
      nameController: nameController,
      descriptionController: descriptionController,
      todoTitle: 'Editar tarefa',
      todoDetailsViewmodel: widget.todoDetailsViewmodel,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
