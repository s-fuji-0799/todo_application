import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo_application/models/todo_model.dart';
import 'package:todo_application/notifiers/todo_list_notifier.dart';

class TodoListTile extends ConsumerWidget {
  const TodoListTile({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(todo.description),
      onLongPress: () {
        ref.watch(todoListNotifierProvider.notifier).deleteTodo(todo);
      },
      trailing: Checkbox(
        value: todo.completed,
        onChanged: (value) {
          ref.watch(todoListNotifierProvider.notifier).toggleTodo(todo);
        },
      ),
    );
  }
}
