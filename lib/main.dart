import 'package:flutter/material.dart';
import '/database/tarefa_dao.dart';
import '/model/tarefa.dart';
import '/screens/list.dart';

void main() {
  runApp(TarefaApp());
  TarefaDao db = TarefaDao();
  db.save(Tarefa(0, 'tarefa teste', 'obs teste')).then((id) {
    print('id gerado: ' + id.toString());
    db.findAll().then((tarefa) => print(tarefa.toString()));
  });
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
