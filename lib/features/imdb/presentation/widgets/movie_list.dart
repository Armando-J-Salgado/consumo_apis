import 'package:consumo_apis/features/imdb/data/models/movie_model.dart';
import 'package:consumo_apis/features/imdb/presentation/widgets/movie_card.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  final List<MovieModel> movies;

  const MovieList({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: movies
          .map(
            (movie) => MovieCard(movie: movie),
          )
          .toList(),
    );
  }
}