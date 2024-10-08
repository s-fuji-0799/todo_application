import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

import 'package:todo_application/infrastructures/sqflite.dart';
import 'package:todo_application/models/todo_model.dart';

final todoRepositoryProvider = Provider<TodoRepository>(
  (ref) => TodoRepository(ref.watch(dbProvider)),
);

class TodoRepository {
  const TodoRepository(this._db);

  final Database _db;

  Future<void> createTodo({
    required String description,
    required bool completed,
  }) async {
    await _db.transaction(
      (txn) async {
        await txn.rawInsert(
          'INSERT INTO Todo(description, completed) VALUES(?, ?)',
          [description, boolToInt(completed)],
        );
      },
    );
  }

  Future<void> updateTodo(Todo todo) async {
    await _db.transaction(
      (txn) async {
        await txn.rawUpdate(
          'UPDATE Todo SET description = ?, completed = ? WHERE id = ?',
          [todo.description, todo.completed, todo.id],
        );
      },
    );
  }

  Future<void> deleteTodo(Todo todo) async {
    await _db.transaction(
      (txn) async {
        await txn.rawDelete(
          'DELETE FROM Todo WHERE id = ?',
          [todo.id],
        );
      },
    );
  }

  Future<List<Todo>> readAllTodo() async {
    final rawData = await _db.rawQuery('SELECT * FROM Todo');

    return rawData
        .map(
          (e) => Todo(
            id: e['id'] as int,
            description: e['description'] as String,
            completed: intToBool(e['completed'] as int),
          ),
        )
        .toList();
  }
}
