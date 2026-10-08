import 'package:consumo_apis/features/imdb/data/models/movie_model.dart';
import 'package:consumo_apis/features/imdb/presentation/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:consumo_apis/features/imdb/presentation/widgets/movie_card.dart';
import 'package:consumo_apis/features/imdb/presentation/widgets/movie_list.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();

  bool isLoading = false;
  List<MovieModel> movies = [];

  Future<void> searchMovies() async {
    setState(() {
      isLoading = true;
    });

    final query = searchController.text.trim();

    // PONER LLAMADA AL REPOSITORIO AQUÍ
    // final results = await repository.searchMovies(query);
    // setState(() {
    //   movies = results;
    // });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consumo de APIs')),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SearchField(controller: searchController),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            searchMovies();
                          }
                        },
                        child: const Text('Search'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                if (isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                MovieList(movies: movies),
              ],
            ),
          ),
        ),
      ),
    );
  }
}