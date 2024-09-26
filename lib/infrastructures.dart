import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> openTodoDatabase() async {
  return await openDatabase(
    version: 1,
    'todo.db',
    onCreate: (db, version) async {
      await db.execute(
        '''CREATE TABLE Todo (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              description TEXT, 
              completed INTEGER)''',
      );
    },
  );
}

final dbProvider = Provider<Database>((ref) => throw UnimplementedError());
