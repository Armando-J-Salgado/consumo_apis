import 'package:consumo_apis/features/imdb/presentation/validators/search_validator.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;

  const SearchField({super.key, required this.controller});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
   
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: 'Buscar',
        suffixIcon: Icon(Icons.search),
      ),
      validator: Validators.searchValidator,
      autovalidateMode: AutovalidateMode.onUserInteractionIfError,
    );
  }
}