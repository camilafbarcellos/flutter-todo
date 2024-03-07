import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// método para recuperar ref do banco de dados no futuro
Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'dbtarefas.db');
  return openDatabase(path, onCreate: (db, version) {
    // criação do database (primeira execução do app cria a tabela)
    db.execute('CREATE TABLE tarefas ('
        'id INTEGER PRIMARY KEY, '
        'descricao TEXT, '
        'obs TEXT)');
  }, version: 1);
}
