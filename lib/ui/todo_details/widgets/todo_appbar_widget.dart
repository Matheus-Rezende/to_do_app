import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TodoAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const TodoAppbarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0), // Padding ajustado
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16.0,
          children: [
            IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
            Expanded(
              child: Text(
                'Tarefa: $title',
                style: const TextStyle(fontSize: 22.0),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
