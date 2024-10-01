import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo_application/models/todo_model.dart';
import 'package:todo_application/notifiers/todo_list_notifier.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({super.key, required this.todoList});

  final List<Todo> todoList;

  @override
  Widget build(BuildContext context) {
    return (todoList.isNotEmpty)
        ? ListView(
            children: [
              for (final todo in todoList) TodoListTile(todo: todo),
            ],
          )
        : ListView();
  }
}

class TodoListTile extends ConsumerWidget {
  const TodoListTile({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(todo.description),
      onLongPress: () {
        ref.watch(todoListProvider.notifier).deleteTodo(todo);
      },
      trailing: Checkbox(
        value: todo.completed,
        onChanged: (value) {
          ref.watch(todoListProvider.notifier).toggleCompleted(todo);
        },
      ),
    );
  }
}
