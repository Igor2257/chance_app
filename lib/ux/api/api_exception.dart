class ApiException implements Exception {
  const ApiException(this.message);

  factory ApiException.unknown() => const ApiException("Помилка");

  final String message;

  factory ApiException.fromJson(Map<String, dynamic> json) {
    final message = (json["message"] is List)
        ? (json["message"] as List<dynamic>).cast<String>().first
        : json["message"] as String?;
    if (message != null) return ApiException(message);
    return ApiException.unknown();
  }

  @override
  String toString() => message;
}