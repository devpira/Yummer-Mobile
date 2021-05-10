

class OrderSessionException implements Exception {
  final String? errorMessage;
  const OrderSessionException({required this.errorMessage});

  @override
  String toString() {
    return errorMessage!;
  }
}