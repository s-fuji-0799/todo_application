import 'package:flutter/material.dart';

import 'package:todo_application/models/todo_model.dart';
import 'package:todo_application/components/todo_list_tile.dart';

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
