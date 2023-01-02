import 'package:primeiro_projeto_flutter/components/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:primeiro_projeto_flutter/data/database.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_photo TEXT)';

  static const String _tableName = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _photo = 'photo';

  save(Tasks task) async {
    // print('Iniciando o save:');
    final Database bancoDeDados = await getDatabase();
    var itemExists = await find(task.name);
    Map<String, dynamic> taskMap = toMap(task);
    if (itemExists.isEmpty) {
      // print('A tarefa não existia.');
      return await bancoDeDados.insert(_tableName, taskMap);
    } else {
      // print('A tarefa já existia!');
      return await bancoDeDados.update(
        _tableName,
        taskMap,
        where: '$_name = ?',
        whereArgs: [task.name],
      );
    }
  }

  Map<String, dynamic> toMap(Tasks task) {
    // print('Convertendo Tarefa em Map: ');
    final Map<String, dynamic> mapaDeTarefas = Map();
    mapaDeTarefas[_name] = task.name;
    mapaDeTarefas[_difficulty] = task.difficulty;
    mapaDeTarefas[_photo] = task.photo;
    // print('Mapa de tarefas: $mapaDeTarefas');
    return mapaDeTarefas;
  }

  Future<List<Tasks>> findAll() async {
    // print('Acessando o findAll: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tableName);
    // print('Procurando dados no banco de dados... encontrado: $result.');
    return toList(result);
  }

  List<Tasks> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    // print('Convertendo to List:');
    final List<Tasks> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Tasks tarefa =
          Tasks(linha[_name], linha[_photo], linha[_difficulty]);
      tarefas.add(tarefa);
    }
    // print('Lista de Tarefas $tarefas');
    return tarefas;
  }

  Future<List<Tasks>> find(String taskName) async {
    // print('Acessando find: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tableName,
      where: '$_name = ?',
      whereArgs: [taskName],
    );
    // print('Tarefa encontrada: ${toList(result)}');
    return toList(result);
  }

  delete(String taskName) async {
    // print('Deletando tarefa: $taskName');
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados.delete(
      _tableName,
      where: '$_name = ?',
      whereArgs: [taskName],
    );
  }
}
