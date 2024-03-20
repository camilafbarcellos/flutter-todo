import 'package:flutter/material.dart';
import '/database/livro_dao.dart';
import '/model/livro.dart';
import '/screens/livro_form.dart';

// lista de livros
class ListaLivro extends StatefulWidget {
  final List<Livro> _livros = [];

  @override
  State<StatefulWidget> createState() {
    return ListaLivroState(); // retorna o controlador de estado
  }
}

// classe para controlar os states da ListaLivro stateful
class ListaLivroState extends State<ListaLivro> {
  final LivroDao _dao = LivroDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // widget da página home
      appBar: AppBar(
          // widget da barra superior
          title: Text("Lista de Livros") // título da página
          ),
      body: FutureBuilder<List<Livro>>(
          // construtor para lista futura
          initialData: [], // inicialmente vazio
          future:
              Future.delayed(Duration(seconds: 1)) // aguarda 1s para o retorno
                  .then((value) => _dao.findAll()), // valor vem do findAll
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              // só constrói caso tenha carregado tudo (done)
              case ConnectionState.done:
                if (snapshot.data != null) {
                  // caso tenha retorno
                  final List<Livro>? livros = snapshot.data; // captura livros
                  return ListView.builder(
                      // constrói ListView com os livros
                      itemBuilder: (context, index) {
                        final Livro livro = livros![index];
                        return ItemLivro(context, livro);
                      },
                      itemCount: livros!.length);
                }
                break;
              default:
                return Center(child: Text("Nenhum livro"));
            }
            return Center(child: Text("Carregando..."));
          }),
      floatingActionButton: FloatingActionButton(
        // botão flutuante
        onPressed: () {
          // future indica o retorno futuro (ex.: alguma info do livro que será feita)
          final Future future = Navigator.push(
              context, // push indica adicionar na pilha Navigator
              MaterialPageRoute(builder: (context) {
            // gerenciador de rotas
            return FormLivro(); // abre FormLivro na nova tela
          }));
          future.then((livro) {
            print('Livro retornado no future: $livro');
            widget._livros.add(livro); // adicionar livro na lista
            // seta o estado da livro e executa o build novamente (reconstrói tudo)
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
    );
    throw UnimplementedError();
  }

  // card de um livro
  Widget ItemLivro(BuildContext context, Livro _livro) {
    return GestureDetector(
      onTap: () {
        // enviar contexto e livro para edição
        final Future future =
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FormLivro(livro: _livro);
        }));
        // em algum momento do futuro, atualizar o estado com setState
        future.then((value) => setState(() {}));
      },
      child: Card(
        child: ListTile(
          leading: Icon(Icons.book_outlined), // esquerda
          title: Text(_livro.nome),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_livro.autor),
              Text(_livro.editora),
              Text(_livro.ano),
              _livro.lido == 1
                  ? Icon(Icons.check_circle_outline)
                  : Icon(Icons.circle_outlined),
            ],
          ),
          trailing: Row(
            // direita
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // chama a janela de confirmação
                  alertaConfirmarExclusao(context, _livro);
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

  alertaConfirmarExclusao(BuildContext context, Livro _livro) {
    Widget cancelButton = TextButton(
      child: Text("Cancelar"),
      onPressed: () {
        // fechar a janela de diálogo
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Confirmar"),
      onPressed: () {
        // remover a livro e atualizar o estado com setState
        _dao.delete(_livro.id).then((value) {
          setState(() {});
          // fechar a janela de diálogo
          Navigator.pop(context);
        });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmação"),
      content: Text("Você tem certeza que deseja excluir este livro?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}