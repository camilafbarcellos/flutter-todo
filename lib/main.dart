import 'package:flutter/material.dart';

void main() {
  runApp(TarefaApp());
}

// tela da lista de tarefas
class TarefaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // widget pai do app com Material
        home: ListaTarefa());
    throw UnimplementedError();
  }
}

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

// tela do formulário
class FormTarefa extends StatelessWidget {
  // controladores para capturar os dados da tarefa
  final TextEditingController _controladorTarefa = TextEditingController();
  final TextEditingController _controladorObs = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Tarefa"),
      ),
      body: Column(
        children: [
          Editor(_controladorTarefa, "Tarefa", "Indique a tarefa",
              Icons.assignment),
          Editor(_controladorObs, "Observação", "Indique a observação",
              Icons.emoji_objects),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          criarTarefa(context);
        },
        child: Icon(Icons.save),
      ),
    );
    throw UnimplementedError();
  }

  // método para criar tarefa
  void criarTarefa(BuildContext context) {
    // captura dados da tarefa pelos controladores
    final tarefaCriada = Tarefa(_controladorTarefa.text, _controladorObs.text);
    print(tarefaCriada);
    // mandar tarefa criada para a tela de lista tarefas pelo Navigator
    Navigator.pop(context, tarefaCriada);
    // exibir mensagem snackbar avisando que a tarefa foi criada
    final SnackBar snackBar = SnackBar(content: const Text("Tarefa criada!"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

// construtor da criação de tarefa
class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData? icone; // campo opcional

  Editor(this.controlador, this.rotulo, this.dica, this.icone);

  @override
  Widget build(BuildContext context) {
    return Padding(
      // adicionar espaçamento -> padding
      padding: const EdgeInsets.all(16.0), // padding de 16pt em todos os lados
      child: TextField(
        style: TextStyle(fontSize: 16.0),
        controller: this.controlador,
        decoration: InputDecoration(
            icon: icone != null ? Icon(icone) : null,
            labelText: this.rotulo,
            hintText: this.dica),
      ),
    );
    throw UnimplementedError();
  }
}
