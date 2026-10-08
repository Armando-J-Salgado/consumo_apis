import 'dart:convert';

import 'package:consumo_apis/features/imdb/data/datasource/imdb_exception.dart';
import 'package:consumo_apis/features/imdb/data/models/movie_model.dart';
import 'package:http/http.dart' as http;

class ImdbDatasource {
  static const String _baseUrl = 'https://www.omdbapi.com/';
  static const String _apiKey = '4409fb2a';

  final http.Client _client;

  ImdbDatasource({http.Client? client}) : _client = client ?? http.Client();

  Future<List<MovieModel>> searchMovies(String query) async {
    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {'apikey': _apiKey, 's': query},
    );

    final http.Response response;
    try {
      response = await _client.get(uri);
    } on http.ClientException {
      throw const ImdbException('No se pudo conectar con el servidor');
    }

    if (response.statusCode != 200) {
      throw ImdbException('Error del servidor (${response.statusCode})');
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;

    // OMDb responde 200 aun cuando falla; el error viene en el body
    if (body['Response'] == 'False') {
      throw ImdbException(body['Error'] ?? 'Error desconocido');
    }

    final results = body['Search'] as List<dynamic>;
    return results
        .map((json) => MovieModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
