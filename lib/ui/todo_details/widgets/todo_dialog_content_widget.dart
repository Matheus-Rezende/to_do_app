import 'package:flutter/material.dart';
import 'package:to_do_app/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:to_do_app/ui/todo_details/viewmodels/todo_details_viewmodel.dart';

class TodoDialogContentWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TodoViewmodel? todoViewmodel;
  final TodoDetailsViewmodel? todoDetailsViewmodel;
  final String todoTitle;
  const TodoDialogContentWidget({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.descriptionController,
    this.todoViewmodel,
    this.todoDetailsViewmodel,
    required this.todoTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(todoTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Nome tarefa',
                  hintStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, preencha o nome';
                  }
                  return null;
                },
                controller: nameController,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                minLines: 5,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Descrição tarefa',
                  hintStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, preencha a descrição';
                  }
                  return null;
                },
                controller: descriptionController,
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() == true) {
                    if (todoViewmodel != null) {
                      todoViewmodel!.addTodo.execute((
                        nameController.text,
                        descriptionController.text,
                        false,
                      ));
                    }
                    if (todoDetailsViewmodel != null) {
                      todoDetailsViewmodel!.updateTodo.execute(
                        todoDetailsViewmodel!.todo.copyWith(
                          name: nameController.text,
                          description: descriptionController.text,
                        ),
                      );
                    }
                  }
                },
                child: const Text('Salvar tarefa'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
