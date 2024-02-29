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
      floatingActionButton: FloatingActionButton( // botão flutuante
        onPressed: (){
          print("Pressionou botão"); // print no terminal ao pressionar
        },
        child: Icon(Icons.add),
      ),
    )
  ));
}

class Tarefa{
  final String descricao;
  final String obs;
  Tarefa(this.descricao, this.obs); // construtor
}

