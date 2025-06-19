import 'package:graphql_flutter/graphql_flutter.dart';
import '../services/auth_service.dart';

Future<GraphQLClient> getGraphQLClient() async {
  final httpLink = HttpLink('http://10.0.2.2:8080/query');

  final authToken = await AuthService.getToken();

  final authLink = AuthLink(
    getToken: () async => authToken != null ? 'Bearer $authToken' : null,
  );

  final link = authLink.concat(httpLink);

  return GraphQLClient(
    cache: GraphQLCache(store: InMemoryStore()),
    link: link,
  );
}
