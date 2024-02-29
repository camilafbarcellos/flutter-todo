import 'package:flutter/material.dart';

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
