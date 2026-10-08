import 'package:consumo_apis/features/imdb/data/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: movie.poster.isNotEmpty
            ? Image.network(
                movie.poster,
                width: 50,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.movie),
        title: Text(movie.title),
        subtitle: Text(movie.year),
      ),
    );
  }
}