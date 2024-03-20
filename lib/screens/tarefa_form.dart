import 'package:flutter/material.dart';
import '/database/tarefa_dao.dart';
import '/components/editor.dart';
import '/model/tarefa.dart';

// tela do formulário
class FormTarefa extends StatefulWidget {
  // ao editar uma tarefa, o objeto vem preenchido
  final Tarefa? tarefa; // pode chegar com valor nulo (inclusão de tarefa)
  FormTarefa({super.key, this.tarefa}); // {} -> opcionalidade
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
  final _formTarefaKey = GlobalKey<FormState>(); // key para o widget do form

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
      body: Form(
        key: _formTarefaKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preenchimento obrigatório!';
                  }
                  return null;
                },
                controller: widget._controladorTarefa,
                decoration: InputDecoration(
                  labelText: 'Tarefa',
                  hintText: 'Indique a tarefa',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Icon(Icons.assignment),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preenchimento obrigatório!';
                  }
                  return null;
                },
                controller: widget._controladorObs,
                decoration: InputDecoration(
                  labelText: 'Observação',
                  hintText: 'Indique a observação',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Icon(Icons.emoji_objects),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              width: 125,
              child: ElevatedButton(
                onPressed: () {
                  if (_formTarefaKey.currentState!.validate()) {
                    criarTarefa(context);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save),
                    Text(' Salvar'),
                  ],
                ),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric()),
                ),
              ),
            ),
          ],
        ),
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
