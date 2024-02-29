import 'package:flutter/material.dart';

void main() {
  runApp(TarefaApp());
}

// material app da lista de tarefas
class TarefaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // widget pai do app com Material
        home: Scaffold( // widget da página home
          appBar: AppBar( // widget da barra superior
            title: Text("Lista de Tarefas"), // título da página
          ),
          body: ListaTarefa(),
          floatingActionButton: FloatingActionButton( // botão flutuante
            onPressed: (){
              print("Pressionou botão"); // print no terminal ao pressionar
            },
            child: Icon(Icons.add),
          ),
        )
    );
    throw UnimplementedError();
  }

}

// objeto da tarefa
class Tarefa {
  final String descricao;
  final String obs;
  Tarefa(this.descricao, this.obs); // construtor
}

// card de uma tarefa
class ItemTarefa extends StatelessWidget { // widget estático
  final Tarefa _tarefa; // convenção de nome de objetos privados com _
  const ItemTarefa(this._tarefa); // ao ser chamado, deve receber uma Tarefa

  @override // construtor que define o que o widget vai mostrar (card da tarefa)
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.add_alert),
        title: Text(this._tarefa.descricao),
        subtitle: Text(this._tarefa.obs),
      ),
    );
    throw UnimplementedError();
  }

}

// lista de tarefas
class ListaTarefa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column( // lista das tarefas em uma coluna de cards
      children: [
        ItemTarefa((Tarefa("Estudar Flutter", "Ler documentação"))),
        ItemTarefa((Tarefa("Ler livro", "Percy Jackson"))),
        ItemTarefa((Tarefa("Fazer trabalho", "TDM"))),
      ],
    );
    throw UnimplementedError();
  }

}