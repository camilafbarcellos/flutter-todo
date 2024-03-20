import 'package:flutter/material.dart';
import '/database/livro_dao.dart';
import '/components/editor.dart';
import '/model/livro.dart';

// tela do formulário
class FormLivro extends StatefulWidget {
  // ao editar um livro, o objeto vem preenchido
  final Livro? livro; // pode chegar com valor nulo (inclusão de livro)
  FormLivro({super.key, this.livro}); // {} -> opcionalidade
  // controladores para capturar os dados do livro
  final TextEditingController _controladorLivro = TextEditingController();
  final TextEditingController _controladorAutor = TextEditingController();
  final TextEditingController _controladorEditora = TextEditingController();
  final TextEditingController _controladorAno = TextEditingController();
  int? _lido; // integer se leu ou nao

  @override
  State<StatefulWidget> createState() {
    return FormLivroState();
  }
}

class FormLivroState extends State<FormLivro> {
  int? _id; // pode conter valor nulo (inclusão de livro)
  final _formLivroKey = GlobalKey<FormState>(); // key para o widget do form

  // preparar form para receber edição de livro
  @override
  void initState() {
    super.initState();
    // caso seja alteração
    if (widget.livro != null) {
      _id = widget.livro!.id; // ! indica garantia de não-nulo
      widget._controladorLivro.text = widget.livro!.nome;
      widget._controladorAutor.text = widget.livro!.autor;
      widget._controladorEditora.text = widget.livro!.editora;
      widget._controladorAno.text = widget.livro!.ano;
      widget._lido = widget.livro!.lido;
      // widget._controladorLido.text =
      //     widget.livro!.lido.toString(); // usar int.parse
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Livro"),
      ),
      body: Form(
        key: _formLivroKey,
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
                controller: widget._controladorLivro,
                decoration: InputDecoration(
                  labelText: 'Livro',
                  hintText: 'Indique o livro',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Icon(Icons.auto_stories),
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
                controller: widget._controladorAutor,
                decoration: InputDecoration(
                  labelText: 'Autor',
                  hintText: 'Indique o autor',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Icon(Icons.person),
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
                controller: widget._controladorEditora,
                decoration: InputDecoration(
                  labelText: 'Editora',
                  hintText: 'Indique a editora',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Icon(Icons.account_balance),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                validator: (value) {
                  final regex = new RegExp(r'^[0-9]+$');
                  if (value == null || value.isEmpty) {
                    return 'Preenchimento obrigatório!';
                  } else if (!regex.hasMatch(value)) {
                    return 'O ano deve ser um número inteiro!';
                  }
                  return null;
                },
                controller: widget._controladorAno,
                decoration: InputDecoration(
                  labelText: 'Ano',
                  hintText: 'Indique o ano de publicaçao',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Icon(Icons.event),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Já leu?'),
                  SizedBox(width: 10),
                  Row(
                    children: [
                      Radio<int>(
                        value: 1,
                        groupValue: widget._lido,
                        onChanged: (value) {
                          setState(() {
                            widget._lido = value as int;
                          });
                        },
                      ),
                      Text('Sim'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<int>(
                        value: 0,
                        groupValue: widget._lido,
                        onChanged: (value) {
                          setState(() {
                            widget._lido = value as int;
                          });
                        },
                      ),
                      Text('Não'),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              width: 125,
              child: ElevatedButton(
                onPressed: () {
                  if (_formLivroKey.currentState!.validate()) {
                    criarLivro(context);
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

  // método para criar livro
  void criarLivro(BuildContext context) {
    LivroDao _dao = LivroDao();
    // checar se é alteração ou inclusão
    if (_id != null) {
      // alteração
      // captura dados da livro pelos controladores
      widget._controladorLivro.text = widget.livro!.nome;
      widget._controladorAutor.text = widget.livro!.autor;
      widget._controladorEditora.text = widget.livro!.editora;
      widget._controladorAno.text = widget.livro!.ano;
      widget._lido = widget.livro!.lido;

      final livroNovo = Livro(
          _id!,
          widget._controladorLivro.text,
          widget._controladorAutor.text,
          widget._controladorEditora.text,
          widget._controladorAno.text,
          widget._lido!);
      // mandar livro criada para a tela de lista livros pelo Navigator
      _dao.update(livroNovo).then((id) => Navigator.pop(context, livroNovo));
    } else {
      // inclusão
      final livroNovo = Livro(
          0,
          widget._controladorLivro.text,
          widget._controladorLivro.text,
          widget._controladorAutor.text,
          widget._controladorEditora.text,
          widget._controladorAno.text as int,
          widget._lido!);
      // mandar livro criada para a tela de lista livros pelo Navigator
      _dao.save(livroNovo).then((id) => Navigator.pop(context, livroNovo));
    }
    // exibir mensagem snackbar avisando que a livro foi criada
    final SnackBar snackBar =
        SnackBar(content: const Text("Livro adicionado!"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
