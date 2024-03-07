import 'package:sqflite/sqflite.dart';
import 'app_database.dart';
import '/model/tarefa.dart';

class TarefaDao {
  // recebe um objeto e transforma num map
  Map<String, dynamic> toMap(Tarefa tarefa) {
    final Map<String, dynamic> tarefaMap = Map();
    tarefaMap['descricao'] = tarefa.descricao;
    tarefaMap['obs'] = tarefa.obs;
    return tarefaMap;
  }

  // método save retorna o id do objeto criado (por isso Future<int>)
  Future<int> save(Tarefa tarefa) async {
    final Database db = await getDatabase(); // conecta na base de dados
    Map<String, dynamic> tarefaMap = toMap(tarefa); // mapeia o objeto
    return db.insert(('tarefas'), tarefaMap); // insere o map no db
  }

  Future<int> update(Tarefa tarefa) async {
    final Database db = await getDatabase();
    Map<String, dynamic> tarefaMap = toMap(tarefa);
    // alterar somente o id da tarefa
    return db.update(('tarefas'), tarefaMap,
        where: 'id = ?', whereArgs: [tarefa.id]);
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase();
    return db.delete('tarefas', where: 'id = ?', whereArgs: [id]);
  }

  // lista de tarefas em map para ser retornada no método findAll
  List<Tarefa> toList(List<Map<String, dynamic>> result) {
    final List<Tarefa> tarefas = []; // lista que vai ter as tarefas
    // mapear tarefas e inserir na lista
    for (Map<String, dynamic> row in result) {
      final Tarefa tarefa = Tarefa(row['id'], row['descricao'], row['obs']);
      tarefas.add(tarefa);
    }
    return tarefas;
  }

  // método para retornar a lista de tarefas
  Future<List<Tarefa>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query('tarefas');
    List<Tarefa> tarefas = toList(result);
    return tarefas;
  }
}
