class Livro {
  final int id;
  final String nome;
  final String autor;
  final String editora;
  final String ano;
  final int lido;
  Livro(this.id, this.nome, this.autor, this.editora, this.ano, this.lido);

  @override
  String toString() {
    return 'Livro{nome: $nome, autor: $autor, editora: $editora, ano: $ano, lido: $lido}';
  }
}
