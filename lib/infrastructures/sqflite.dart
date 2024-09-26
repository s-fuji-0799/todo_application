import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

// SQLiteではboolが使えないので、intとして保存する。

/// bool型をint型に変換する
///
/// trueなら1、falseなら0へと変換
int boolToInt(bool value) {
  return value ? 1 : 0;
}

/// int型をbool型に変換する
///
/// 1ならtrue、0ならfalseへと変換
bool intToBool(int value) {
  return (value == 1) ? true : false;
}

/// Todo用データベースを開くための関数
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

/// 必ずProviderScope内でオーバーライドする。
final dbProvider = Provider<Database>((ref) => throw UnimplementedError());
