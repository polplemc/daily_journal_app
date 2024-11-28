class APIException implements Exception {
  final String message;
  final String statusCode;

  const APIException({required this.message, required this.statusCode});
}
