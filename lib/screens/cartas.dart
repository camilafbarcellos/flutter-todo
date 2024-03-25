import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

class CartasPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CartasPageState();
  }
}

class CartasPageState extends State<CartasPage> {
  late Future<Map<String, dynamic>> _cartas;
  late List<bool> _toggleCartaList;

  @override
  void initState() {
    super.initState();
    _cartas = _getCartas();
    _toggleCartaList = List.generate(54, (_) => true);
  }

  Future<Map<String, dynamic>> _getCartas() async {
    // embaralha um deck de cartas e retorna o seu deck_id
    String shuffleCards =
        'https://deckofcardsapi.com/api/deck/new/shuffle/?jokers_enabled=true';
    http.Response response = await http.get(Uri.parse(shuffleCards));
    Map<String, dynamic> _baralho = json.decode(response.body);
    String deck_id = _baralho['deck_id'];
    // usa o deck_id para tirar as 52 cartas do deck
    String drawCards =
        'https://deckofcardsapi.com/api/deck/$deck_id/draw/?count=54';
    response = await http.get(Uri.parse(drawCards));
    // retorna lista de 52 cartas do deck
    return json.decode(response.body);
  }

  Widget _buildCartasDeck(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: snapshot.data!['cards'].length,
      itemBuilder: (context, index) {
        if (index < snapshot.data!['cards'].length) {
          var carta = snapshot.data!['cards'][index];
          String imageUrl = carta['image'];
          String backImageUrl =
              'https://deckofcardsapi.com/static/img/back.png';
          return GestureDetector(
            onTap: () => {
              setState(() {
                _toggleCartaList[index] = !_toggleCartaList[index];
              })
            },
            child: Container(
              child: Card(
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: _toggleCartaList[index] ? imageUrl : backImageUrl,
                  fit: BoxFit.fill,
                ),
                elevation: 5,
              ),
            ),
          );
        } else {
          return Container(); // Retorna um container vazio se não houver mais cartas
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Deck of Cards API",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Image.network(
              "https://cdn-icons-png.flaticon.com/512/8983/8983569.png",
              width: 60,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _cartas,
              builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    return _buildCartasDeck(context, snapshot);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
