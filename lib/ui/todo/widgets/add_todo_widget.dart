import 'package:flutter/material.dart';
import 'package:to_do_app/ui/todo/viewmodels/todo_viewmodel.dart';

class AddTodoWidget extends StatefulWidget {
  final TodoViewmodel todoViewmodel;
  const AddTodoWidget({super.key, required this.todoViewmodel});

  @override
  State<AddTodoWidget> createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController = TextEditingController();

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
    return AlertDialog(
      content: IntrinsicHeight(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16.0,
            children: [
              const Row(children: [Text('Adicione novos TODO')]),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Nome tarefa',
                  hintStyle: TextStyle(fontSize: 16.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                ),
                validator: (value) {
                  if (value!.isEmpty || value.trim().isEmpty) {
                    return 'Por favor, preencha nome';
                  }
                  return null;
                },
                controller: nameController,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    widget.todoViewmodel.addTodo.execute(nameController.text);
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

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    widget.todoViewmodel.addTodo.removeListener(_onResult);
  }
}
