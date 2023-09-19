import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokemon/pokemon_list/models/pokemon_list_model.dart';

class PokemonListRepository {
  static var client = http.Client();

  Future<PokemonListModel?> getPokemonList(nextUrl) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.parse(nextUrl);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return PokemonListModel.fromJson(data);
    } else {
      return null;
    }
  }
}
