class Validators {
  static String? searchValidator(String? value) {
    if(value == null || value.trim().isEmpty) {
      return 'Ingrese un parámetro de búsqueda';
    }

    return null;
  }
}