// objeto da tarefa
class Tarefa {
  final String descricao;
  final String obs;
  Tarefa(this.descricao, this.obs); // construtor

  @override
  String toString() {
    return 'Tarefa{descricao: $descricao, obs: $obs}';
  }
}
