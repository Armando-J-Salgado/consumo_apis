import 'package:consumo_apis/features/imdb/presentation/widgets/search_field.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatelessWidget {
  FormScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consumo de APIs')),
      body: SafeArea(child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: ()=>FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SearchField(controller: searchController),
                  ElevatedButton(onPressed: () => {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Cambiar por consumo de API'), behavior: SnackBarBehavior.floating,),
                      )
                    }
                  }, child: const Text('Send')),
                ],
              )
            )
          ],)
        )
      ))
    );
  }
}