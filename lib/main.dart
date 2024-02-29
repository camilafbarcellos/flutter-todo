import 'package:flutter/material.dart';
import '/screens/list.dart';

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
