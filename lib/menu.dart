import 'package:flutter/material.dart';
import '/screens/livro_list.dart';
import '/screens/gifs.dart';
import '/screens/tarefa_list.dart';

class MenuOptions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MenuOptionsState();
  }
}

class MenuOptionsState extends State<MenuOptions> {
  int paginaAtual = 0;
  PageController? pc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: [
          ListaTarefa(),
          ListaLivro(),
          GifsPage(),
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm), label: 'Tarefas'),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined), label: 'Livros'),
          BottomNavigationBarItem(
              icon: Icon(Icons.gif_box_outlined), label: 'GIFs')
        ],
        onTap: (pagina) {
          // animação ao clicar para trocar de página
          pc?.animateToPage(pagina,
              duration: const Duration(microseconds: 400), curve: Curves.ease);
        },
        backgroundColor: Colors.grey[200],
      ),
    );
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }
}
