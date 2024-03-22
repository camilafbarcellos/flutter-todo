import 'package:sqflite/sqflite.dart';
import '/models/livro.dart';
import 'app_database.dart';

class LivroDao {
  static const String _tableName = 'livros';
  static const String _id = 'id';
  static const String _nome = 'nome';
  static const String _autor = 'autor';
  static const String _editora = 'editora';
  static const String _ano = 'ano';
  static const String _lido = 'lido';
  static const String tableSQL = 'CREATE TABLE livros ('
      'id INTEGER PRIMARY KEY, '
      'nome TEXT, '
      'autor TEXT, '
      'editora TEXT, '
      'ano TEXT, '
      'lido INTEGER)';

  Map<String, dynamic> toMap(Livro livro) {
    final Map<String, dynamic> livroMap = Map();
    livroMap[_nome] = livro.nome;
    livroMap[_autor] = livro.autor;
    livroMap[_editora] = livro.editora;
    livroMap[_ano] = livro.ano;
    livroMap[_lido] = livro.lido;
    return livroMap;
  }

  // método save retorna o id do objeto criado (por isso Future<int>)
  Future<int> save(Livro livro) async {
    final Database db = await getDatabase(); // conecta na base de dados
    Map<String, dynamic> livroMap = toMap(livro); // mapeia o objeto
    return db.insert((_tableName), livroMap); // insere o map no db
  }

  Future<int> update(Livro livro) async {
    final Database db = await getDatabase();
    Map<String, dynamic> livroMap = toMap(livro);
    // alterar somente o id do livro
    return db.update((_tableName), livroMap,
        where: '$_id = ?', whereArgs: [livro.id]);
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase();
    return db.delete(_tableName, where: '$_id = ?', whereArgs: [id]);
  }

  // lista de livros em map para ser retornada no método findAll
  List<Livro> toList(List<Map<String, dynamic>> result) {
    final List<Livro> livros = []; // lista que vai ter os livros
    // mapear livros e inserir na lista
    for (Map<String, dynamic> row in result) {
      final Livro livro = Livro(row[_id], row[_nome], row[_autor],
          row[_editora], row[_ano], row[_lido]);
      livros.add(livro);
    }
    return livros;
  }

  // método para retornar a lista de livros
  Future<List<Livro>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Livro> livros = toList(result);
    return livros;
  }
}
