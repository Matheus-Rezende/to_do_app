import 'package:flutter/material.dart';
import 'package:to_do_app/domain/models/todo_model.dart';
import 'package:to_do_app/ui/todo_details/widgets/todo_content_card_widget.dart';
import 'package:to_do_app/ui/todo_details/widgets/todo_status_card_widget.dart';

class TodoWidget extends StatelessWidget {
  final TodoModel todo;
  const TodoWidget({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        spacing: 16.0,
        children: [
          TodoStatusCardWidget(todo: todo),
          TodoContentCardWidget(todo: todo),
        ],
      ),
    );
  }
}
