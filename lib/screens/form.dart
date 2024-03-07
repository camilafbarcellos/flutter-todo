import 'package:flutter/material.dart';
import '/database/tarefa_dao.dart';
import '/components/editor.dart';
import '/model/tarefa.dart';

// tela do formulário
class FormTarefa extends StatefulWidget {
  // ao editar uma tarefa, o objeto vem preenchido
  final Tarefa? tarefa; // pode chegar com valor nulo (inclusão de tarefa)
  FormTarefa({this.tarefa}); // {} -> opcionalidade
  // controladores para capturar os dados da tarefa
  final TextEditingController _controladorTarefa = TextEditingController();
  final TextEditingController _controladorObs = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return FormTarefaState();
  }
}

class FormTarefaState extends State<FormTarefa> {
  int? _id; // pode conter valor nulo (inclusão de tarefa)

  // preparar form para receber edição de tarefa
  @override
  void initState() {
    super.initState();
    // caso seja alteração
    if (widget.tarefa != null) {
      _id = widget.tarefa!.id; // ! indica garantia de não-nulo
      widget._controladorTarefa.text = widget.tarefa!.descricao;
      widget._controladorObs.text = widget.tarefa!.obs;
    }
  }

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
    TarefaDao _dao = TarefaDao();
    // checar se é alteração ou inclusão
    if (_id != null) {
      // alteração
      // captura dados da tarefa pelos controladores
      final tarefaCriada = Tarefa(
          _id!, widget._controladorTarefa.text, widget._controladorObs.text);
      _dao.update(tarefaCriada).then((id) {
        // mandar tarefa criada para a tela de lista tarefas pelo Navigator
        Navigator.pop(context, tarefaCriada);
      });
    } else {
      // inclusão
      final tarefaCriada = Tarefa(
          0, widget._controladorTarefa.text, widget._controladorObs.text);
      _dao.save(tarefaCriada).then((id) {
        // mandar tarefa criada para a tela de lista tarefas pelo Navigator
        Navigator.pop(context, tarefaCriada);
      });
    }
    // exibir mensagem snackbar avisando que a tarefa foi criada
    final SnackBar snackBar = SnackBar(content: const Text("Tarefa criada!"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
