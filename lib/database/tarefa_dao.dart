import 'package:sqflite/sqflite.dart';
import 'app_database.dart';
import '/model/tarefa.dart';

class TarefaDao {
  static const String _tableName = 'tarefas';
  static const String _id = 'id';
  static const String _descricao = 'descricao';
  static const String _obs = 'obs';
  static const String tableSQL = 'CREATE TABLE tarefas ('
      'id INTEGER PRIMARY KEY, '
      'descricao TEXT, '
      'obs TEXT)';

  // recebe um objeto e transforma num map
  Map<String, dynamic> toMap(Tarefa tarefa) {
    final Map<String, dynamic> tarefaMap = Map();
    tarefaMap[_descricao] = tarefa.descricao;
    tarefaMap[_obs] = tarefa.obs;
    return tarefaMap;
  }

  // método save retorna o id do objeto criado (por isso Future<int>)
  Future<int> save(Tarefa tarefa) async {
    final Database db = await getDatabase(); // conecta na base de dados
    Map<String, dynamic> tarefaMap = toMap(tarefa); // mapeia o objeto
    return db.insert((_tableName), tarefaMap); // insere o map no db
  }

  Future<int> update(Tarefa tarefa) async {
    final Database db = await getDatabase();
    Map<String, dynamic> tarefaMap = toMap(tarefa);
    // alterar somente o id da tarefa
    return db.update((_tableName), tarefaMap,
        where: '$_id = ?', whereArgs: [tarefa.id]);
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase();
    return db.delete(_tableName, where: '$_id = ?', whereArgs: [id]);
  }

  // lista de tarefas em map para ser retornada no método findAll
  List<Tarefa> toList(List<Map<String, dynamic>> result) {
    final List<Tarefa> tarefas = []; // lista que vai ter as tarefas
    // mapear tarefas e inserir na lista
    for (Map<String, dynamic> row in result) {
      final Tarefa tarefa = Tarefa(row[_id], row[_descricao], row[_obs]);
      tarefas.add(tarefa);
    }
    return tarefas;
  }

  // método para retornar a lista de tarefas
  Future<List<Tarefa>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Tarefa> tarefas = toList(result);
    return tarefas;
  }
}
