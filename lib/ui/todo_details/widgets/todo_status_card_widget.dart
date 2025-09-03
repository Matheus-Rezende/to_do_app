import 'package:flutter/material.dart';
import 'package:to_do_app/domain/models/todo_model.dart';

class TodoStatusCardWidget extends StatelessWidget {
  final TodoModel todo;
  const TodoStatusCardWidget({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        color: Color.fromARGB(255, 53, 26, 99),
      ),
      child: IntrinsicWidth(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8.0,
          children: [
            Icon(
              todo.done ? Icons.check : Icons.access_time_rounded,
              color: todo.done ? Colors.green : Colors.red,
            ),
            Text(
              todo.done ? 'Tarefa concluída' : 'Tarefa Pendente',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
