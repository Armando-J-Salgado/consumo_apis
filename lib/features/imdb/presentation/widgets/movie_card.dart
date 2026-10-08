import 'package:consumo_apis/features/imdb/data/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: movie.poster.isNotEmpty && movie.poster != 'N/A'
            ? Image.network(
                movie.poster,
                width: 50,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) {
                  return const Icon(Icons.movie);
                },
              )
            : const Icon(Icons.movie),
        title: Text(movie.title, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: Text(movie.year),
      ),
    );
  }
}
