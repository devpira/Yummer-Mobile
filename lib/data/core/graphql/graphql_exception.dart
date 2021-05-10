

class GraphQLException implements Exception {
  final String errorCode;
  final String errorMessage;
  const GraphQLException({this.errorCode = "", required this.errorMessage});

  @override
  String toString() {
    return errorMessage;
  }
}