import 'package:flutter/material.dart';
import 'package:to_do_app/domain/models/todo_model.dart';

class TodoContentCardWidget extends StatelessWidget {
  final TodoModel todo;
  const TodoContentCardWidget({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        color: Colors.deepPurple,
      ),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.0,
          children: [
            Text(todo.name, style: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.w700)),
            Text(todo.description, style: const TextStyle(fontSize: 24.0)),
          ],
        ),
      ),
    );
  }
}
