import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo_application/infrastructures/sqflite.dart';

import 'package:todo_application/notifiers/todo_list_notifier.dart';

import 'package:todo_application/components/create_todo_dialog.dart';
import 'package:todo_application/components/todo_list_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      overrides: [
        dbProvider.overrideWithValue(
          await openTodoDatabase(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      home: const MainPage(),
    );
  }
}

class MainPage extends ConsumerWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('ToDoアプリ')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const CreateTodoDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: switch (ref.watch(todoListProvider)) {
        AsyncData(:final value) => RefreshIndicator(
            onRefresh: () => ref.refresh(todoListProvider.future),
            child: TodoListView(todoList: value),
          ),
        AsyncError(:final error) => Center(child: Text('Error: $error')),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
