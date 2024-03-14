import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'tarefa_dao.dart';

// método para recuperar ref do banco de dados no futuro
Future<Database> getDatabase() async {
  const String tableSQL2 = 'CREATE TABLE cursos ('
      'id INTEGER PRIMARY KEY, '
      'nome TEXT, '
      'descricao TEXT)';

  final String path = join(await getDatabasesPath(), 'dbtarefas.db');
  return openDatabase(path, onCreate: (db, version) {
    // criação do database (primeira execução do app cria a tabela)
    db.execute(TarefaDao.tableSQL);
  }, onUpgrade: (db, oldVersion, newVersion) async {
    var batch = db.batch();
    print("Versão atinga: " + oldVersion.toString());
    print("Versão nova: " + newVersion.toString());
    if (newVersion == 2) {
      batch.execute(tableSQL2);
    }
    print("Criando nova tabela");
    await batch.commit();
  }, version: 2);
}
