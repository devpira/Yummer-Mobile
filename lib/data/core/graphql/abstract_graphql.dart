import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';
import 'package:yummer/config/config.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:yummer/data/core/graphql/graphql.dart';

abstract class AbstractGraphQL {
  final AppValues _appValues;

  AbstractGraphQL.instance({@required AppValues appValues})
      : assert(appValues != null),
        _appValues = appValues;

  Future<GraphQLClient> createClient() async {
    final String idToken =
        await firebase_auth.FirebaseAuth.instance.currentUser.getIdToken();
    final httpLink = HttpLink(_appValues.graphQLUri);
    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer $idToken',
    );
    final Link link = authLink.concat(httpLink);

    return GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      //cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: link,
    );
  }

  /// Executes a graphql query.
  ///
  /// Throws an [GraphQLException] if the query fails
  Future<dynamic> executeQuery({
    @required String query,
    Map<String, dynamic> variables,
    String defaultErrorMessage,
  }) async {
    final client = await createClient();
    final QueryResult result = await client.query(QueryOptions(
      document: gql(query),
      variables: variables,
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      // ignore all GraphQL errors.
      errorPolicy: ErrorPolicy.ignore,
      // ignore cache data.
      cacheRereadPolicy: CacheRereadPolicy.mergeOptimistic
    ));

    checkForErrors(result: result, defaultErrorMessage: defaultErrorMessage);

    return result.data;
  }

  /// Executes a graphql mutation.
  ///
  /// Throws an [GraphQLException] if the query fails
  Future<dynamic> executeMutation({
    @required String mutation,
    Map<String, dynamic> variables,
    String defaultErrorMessage,
  }) async {
    final client = await createClient();
    final QueryResult result = await client.mutate(MutationOptions(
      document: gql(mutation),
      variables: variables,
    ));

    checkForErrors(result: result, defaultErrorMessage: defaultErrorMessage);

    return result.data;
  }

  void checkForErrors({
    @required QueryResult result,
    String defaultErrorMessage,
  }) {
    if (result.hasException) {
      // Check if any custom user friendly errors sent from graphql:
      if (result?.exception?.graphqlErrors != null) {
        // If any found, throw those errors:
        for (final GraphQLError error in result.exception.graphqlErrors) {
          print(error.message);
          throw GraphQLException(errorMessage: error.message);
        }
      }

      if (result.exception != null &&
          result.exception.linkException != null &&
          result.exception.linkException
              .toString()
              .contains("Failed to connect to")) {
        throw const GraphQLException(
          errorMessage:
              "Oops, there was an issue connecting to our servers. Please try again.",
        );
      }

      // If none found then throw a generic error:
      if (defaultErrorMessage != null) {
        throw GraphQLException(
          errorMessage: defaultErrorMessage,
        );
      } else {
        throw const GraphQLException(
          errorMessage: "Unexpected error occurred. Please try again.",
        );
      }
    }
  }
}
