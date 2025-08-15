import 'package:flutter/material.dart';
import 'package:to_do_app/data/repositories/todos/todos_repository_dev.dart';
import 'package:to_do_app/ui/todo/viewmodels/todo_viewmodel.dart';
import 'package:to_do_app/ui/todo/widgets/todo_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home: TodoScreen(todoViewmodel: TodoViewmodel(todosRepository: TodosRepositoryDev())),
    );
  }
}
