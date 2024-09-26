import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo_application/notifiers/todo_list_notifier.dart';

class CreateTodoDialog extends ConsumerStatefulWidget {
  const CreateTodoDialog({super.key});

  @override
  ConsumerState<CreateTodoDialog> createState() => _CreateTodoDialogState();
}

class _CreateTodoDialogState extends ConsumerState<CreateTodoDialog> {
  String description = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('ToDoを追加'),
      content: TextField(
        onChanged: (value) => description = value,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('キャンセル'),
        ),
        ElevatedButton(
          onPressed: () {
            ref.watch(todoListNotifierProvider.notifier).createTodo(
                  description: description,
                  completed: false,
                );
            Navigator.of(context).pop();
          },
          child: const Text('追加'),
        ),
      ],
    );
  }
}
