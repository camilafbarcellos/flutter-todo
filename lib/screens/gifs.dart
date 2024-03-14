import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

class GifsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GifsPageState();
  }
}

class GifsPageState extends State<GifsPage> {
  String? _search = null; // para o campo de busca
  int _offset = 0; // para paginação
  final url = Uri.parse('https://api.giphy.com/v1/gifs/trending?api_key'
      '=wBJx6Dl3ImwPTuKq9bnrx7Xh1S7bf0tN&limit=19&offset=0&rating=g&'
      'bundle=messaging_non_clips');

  Future<Map> _getGifs() async {
    http.Response response;

    if (_search == null || _search!.isEmpty) {
      response = await http.get(url);
    } else {
      final url2 = Uri.parse('https://api.giphy.com/v1/gifs/search?'
          'api_key=wBJx6Dl3ImwPTuKq9bnrx7Xh1S7bf0tN&'
          'q=$_search&limit=19&offset=0&rating=g&lang=en&'
          'bundle=messaging_non_clips');
      response = await http.get(url2);
    }
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Gifs'),
    );
  }
}
