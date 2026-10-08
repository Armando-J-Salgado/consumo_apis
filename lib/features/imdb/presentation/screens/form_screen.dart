import 'package:consumo_apis/features/imdb/data/models/movie_model.dart';
import 'package:consumo_apis/features/imdb/presentation/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:consumo_apis/features/imdb/presentation/widgets/movie_list.dart';
import 'package:consumo_apis/features/imdb/data/datasource/imdb_datasource.dart';
import 'package:consumo_apis/features/imdb/data/repositories/imdb_repository.dart';
import 'package:consumo_apis/features/imdb/data/datasource/imdb_exception.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();

  late final ImdbRepository repository;

  bool isLoading = false;
  List<MovieModel> movies = [];

  @override
  void initState() {
    super.initState();

    repository = ImdbRepository(
      datasource: ImdbDatasource(),
    );
  }

  Future<void> searchMovies() async {
    setState(() {
      isLoading = true;
    });

    final query = searchController.text.trim();

    try {
      final results = await repository.searchMovies(query);

      if (!mounted) return;

      setState(() {
        movies = results;
      });
    } on ImdbException catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message)),
      );
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ocurrió un error al buscar las películas'),
        ),
      );
    } finally {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    }
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