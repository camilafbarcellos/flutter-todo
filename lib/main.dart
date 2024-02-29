import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp( // widget pai do app com Material
    home: Scaffold( // widget da página home
      appBar: AppBar( // widget da barra superior
        title: Text("Lista de Tarefas"), // título da página
      ),
      body: Column( // lista das tarefas em uma coluna de cards
        children: [
          Card(
            child: ListTile( // tarefa
              leading: Icon(Icons.add_alert),
              title: Text("Organizar aula TDM"),
              subtitle: Text("Publicar no classroom"),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.add_alert),
              title: Text("Estudar Flutter"),
              subtitle: Text("Ler documentação e codar"),
            ),
          ),
        ],
      ),
    )
  ));
}

