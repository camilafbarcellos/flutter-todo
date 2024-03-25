import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PokemonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PokemonPageState();
  }
}

class PokemonPageState extends State<PokemonPage> {
  String? _search = null; // para o campo de busca
  int _offset = 0; // para paginação
  late Future<Map<String, dynamic>> _pokemonData;

  @override
  void initState() {
    super.initState();
    _pokemonData = _getPokemonData('');
  }

  Future<Map<String, dynamic>> _getPokemonData(String query) async {
    String apiUrl =
        'https://pokeapi.co/api/v2/pokemon/$query?limit=19&offset=$_offset';
    http.Response response = await http.get(Uri.parse(apiUrl));
    return json.decode(response.body);
  }

  Widget _buildPokemonCard(BuildContext context, AsyncSnapshot snapshot) {
    var pokemon = snapshot.data!;
    String name = pokemon['name'];
    int id = pokemon['id'];
    int height = pokemon['height'];
    int weight = pokemon['weight'];
    // List<String> types = pokemon['types'];
    print(pokemon['types']);
    String imageUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${id}.png';
    return Wrap(
      children: [
        Card(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            child: Column(
              children: [
                Image.network(
                  imageUrl,
                  height: 100,
                  width: 100,
                ),
                Text(
                  name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Altura:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${(height * 0.1).toStringAsFixed(2)} m',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Peso:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${(weight * 0.1).toStringAsFixed(2)} kg',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                    children: pokemon['types']
                        .map(
                          (type) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Card(
                              // color: Utils.colorType(type.type.name),
                              elevation: 15,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: Text(
                                  type.type.name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPokemonsTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
      itemCount: snapshot.data!['results'].length,
      itemBuilder: (context, index) {
        if (index < snapshot.data!['results'].length) {
          var pokemon = snapshot.data!['results'][index];
          String name = pokemon['name'];
          String imageUrl =
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png';
          return GestureDetector(
            onTap: () => _buildPokemonCard(context, snapshot),
            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      imageUrl,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        '#$index $name',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Card(
            child: GestureDetector(
              // botão para carregar mais gifs
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add,
                    color: Colors.blue,
                    size: 80.0,
                  ),
                  Text(
                    "Carregar mais...",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              onTap: () {
                setState(() {
                  _offset += 19; // carrega mais 19 gifs para a segunda página
                });
              },
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.network(
          "https://raw.githubusercontent.com/PokeAPI/media/master/logo/pokeapi.png",
          width: 140,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar Pokémon...',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.black, fontSize: 18.0),
              textAlign: TextAlign.center,
              onSubmitted: (value) {
                setState(() {
                  _search = value;
                  _offset = 0;
                  _pokemonData = _getPokemonData(value);
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _pokemonData,
              builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (_search == null || _search!.isEmpty) {
                      return _buildPokemonsTable(context, snapshot);
                    } else {
                      return _buildPokemonCard(context, snapshot);
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
