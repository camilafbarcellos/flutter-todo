import 'package:flutter/material.dart';
import '/model/tarefa.dart';
import '/screens/form.dart';

// card de uma tarefa
class ItemTarefa extends StatelessWidget {
  // widget estático
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
  final List<Tarefa> _tarefas = [];

  @override
  Widget build(BuildContext context) {
    _tarefas.add((Tarefa("Estudar Flutter", "Ler documentação")));
    _tarefas.add((Tarefa("Fazer trabalho", "TDM")));

    return Scaffold(
      // widget da página home
      appBar: AppBar(
        // widget da barra superior
        title: Text("Lista de Tarefas"), // título da página
      ),
      body: ListView.builder(
          // componente automático de listagem
          itemCount:
              _tarefas.length, // tamanho da lista é a quantidade de items
          itemBuilder: (context, indice) {
            // retorna um ItemTarefa para cada tarefa da lista
            final tarefa = _tarefas[indice];
            return ItemTarefa(tarefa);
          }),
      floatingActionButton: FloatingActionButton(
        // botão flutuante
        onPressed: () {
          print("Pressionou botão"); // print no terminal ao pressionar
          // future indica o retorno futuro (ex.: alguma info da tarefa que será feita)
          final Future future = Navigator.push(
              context, // push indica adicionar na pilha Navigator
              MaterialPageRoute(builder: (context) {
            // gerenciador de rotas
            return FormTarefa(); // abre FormTarefa na nova tela
          }));
          future.then((tarefa) {
            print('Tarefa retornada no future: $tarefa');
            _tarefas.add(tarefa); // adicionar tarefa na lista
          });
        },
        child: Icon(Icons.add),
      ),
    );
    throw UnimplementedError();
  }
}
