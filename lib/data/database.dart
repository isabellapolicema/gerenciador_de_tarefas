import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDarabase() async {
  final String path = join(await getDatabasesPath(), 'task.db');
  return openDatabase(
      path, onCreate: (db, version{
        db.execute(TaskDao.tableSql);
      }, version:1,);
}

