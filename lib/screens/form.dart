import 'package:flutter/material.dart';
import '/components/editor.dart';
import '/model/tarefa.dart';

// tela do formulário
class FormTarefa extends StatefulWidget {
  // controladores para capturar os dados da tarefa
  final TextEditingController _controladorTarefa = TextEditingController();
  final TextEditingController _controladorObs = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return FormTarefaState();
  }
}

class FormTarefaState extends State<FormTarefa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Tarefa"),
      ),
      body: Column(
        children: [
          Editor(widget._controladorTarefa, "Tarefa", "Indique a tarefa",
              Icons.assignment),
          Editor(widget._controladorObs, "Observação", "Indique a observação",
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
    final tarefaCriada =
        Tarefa(widget._controladorTarefa.text, widget._controladorObs.text);
    print(tarefaCriada);
    // mandar tarefa criada para a tela de lista tarefas pelo Navigator
    Navigator.pop(context, tarefaCriada);
    // exibir mensagem snackbar avisando que a tarefa foi criada
    final SnackBar snackBar = SnackBar(content: const Text("Tarefa criada!"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
