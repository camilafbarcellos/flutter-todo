import 'package:flutter/material.dart';
import 'package:todo/database/tarefa_dao.dart';
import '/model/tarefa.dart';
import '/screens/form.dart';

// lista de tarefas
// primeiro: deixa StatefulWidget e tira o @override antigo
// terceiro: gera o novo @override de stateful
class ListaTarefa extends StatefulWidget {
  final List<Tarefa> _tarefas = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTarefaState(); // retorna o controlador de estado
  }
}

// classe para controlar os states da ListaTarefa stateful
// segundo: cria classe para controlar
class ListaTarefaState extends State<ListaTarefa> {
  final TarefaDao _dao = TarefaDao();

  @override
  Widget build(BuildContext context) {
    // widget._tarefas.add((Tarefa("Estudar Flutter", "Ler documentação")));
    // widget._tarefas.add((Tarefa("Fazer trabalho", "TDM")));

    return Scaffold(
      // widget da página home
      appBar: AppBar(
          // widget da barra superior
          title: Text("Lista de Tarefas") // título da página
          ),
      body: FutureBuilder<List<Tarefa>>(
          // construtor para lista futura
          initialData: [], // inicialmente vazio
          future:
              Future.delayed(Duration(seconds: 1)) // aguarda 1s para o retorno
                  .then((value) => _dao.findAll()), // valor vem do findAll
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState
                    .done: // só constrói caso tenha carregado tudo (done)
                if (snapshot.data != null) {
                  // caso tenha retorno
                  final List<Tarefa>? tarefas =
                      snapshot.data; // captura tarefas
                  return ListView.builder(
                      // constrói ListView com as tarefas
                      itemBuilder: (context, index) {
                        final Tarefa tarefa = tarefas![index];
                        return ItemTarefa(context, tarefa);
                      },
                      itemCount: tarefas!.length);
                }
                break;
              default:
                return Center(child: Text("Nenhuma tarefa"));
            }
            return Center(child: Text("Carregando..."));
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
            widget._tarefas.add(tarefa); // adicionar tarefa na lista
            // seta o estado da tarefa e executa o build novamente (reconstrói tudo)
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
    );
    throw UnimplementedError();
  }

  // card de uma tarefa
  Widget ItemTarefa(BuildContext context, Tarefa _tarefa) {
    return GestureDetector(
      onTap: () {
        // enviar contexto e tarefa para edição
        final Future future =
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FormTarefa(tarefa: _tarefa);
        }));
        // em algum momento do futuro, atualizar o estado com setState
        future.then((value) => setState(() {}));
      },
      child: Card(
        child: ListTile(
          leading: Icon(Icons.add_alert), // esquerda
          title: Text(_tarefa.descricao),
          subtitle: Text(_tarefa.obs),
          trailing: Row(
            // direita
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // remover a tarefa e atualizar o estado com setState
                  _dao.delete(_tarefa.id).then((value) => setState(() {}));
                },
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.remove_circle, color: Colors.red),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
