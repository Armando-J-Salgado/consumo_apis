import 'package:consumo_apis/features/imdb/data/datasource/imdb_datasource.dart';
import 'package:consumo_apis/features/imdb/data/models/movie_model.dart';

class ImdbRepository {
  final ImdbDatasource datasource;

  const ImdbRepository({
    required this.datasource,
  });

  Future<List<MovieModel>> searchMovies(String query) async {
    final normalizedQuery = query.trim();

    if (normalizedQuery.isEmpty) {
      return [];
    }

    return datasource.searchMovies(normalizedQuery);
  }
}