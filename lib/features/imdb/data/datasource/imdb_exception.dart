class ImdbException implements Exception {
  final String message;

  const ImdbException(this.message);

  @override
  String toString() => message;
}
