import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo_application/models/todo_model.dart';
import 'package:todo_application/repositories/todo_repository.dart';

final todoListNotifierProvider =
    AsyncNotifierProvider<TodoListNotifier, List<Todo>>(
  () => TodoListNotifier(),
);

class TodoListNotifier extends AsyncNotifier<List<Todo>> {
  Future<List<Todo>> _fetchTodoList() async {
    final todoRepository = ref.watch(todoRepositoryProvider);
    return await todoRepository.readAllTodo();
  }

  @override
  FutureOr<List<Todo>> build() {
    return _fetchTodoList();
  }

  Future<void> getAllTodo() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetchTodoList);
  }

  Future<void> createTodo({
    required String description,
    required bool completed,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final todoRepository = ref.watch(todoRepositoryProvider);
        await todoRepository.createTodo(
            description: description, completed: completed);
        return _fetchTodoList();
      },
    );
  }

  Future<void> toggleTodo(Todo todo) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final todoRepository = ref.watch(todoRepositoryProvider);

        await todoRepository.updateTodo(
          todo.copyWith(completed: !todo.completed),
        );

        return _fetchTodoList();
      },
    );
  }

  Future<void> deleteTodo(Todo todo) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final todoRepository = ref.watch(todoRepositoryProvider);

        await todoRepository.deleteTodo(todo);

        return _fetchTodoList();
      },
    );
  }
}
