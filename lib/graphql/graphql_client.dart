import 'package:graphql_flutter/graphql_flutter.dart';
import '../services/auth_service.dart';

Future<GraphQLClient> getGraphQLClient() async {
  final httpLink = HttpLink('http://10.0.2.2:8080/query');

  final authToken = await AuthService.getToken();

  final authLink = AuthLink(
    getToken: () async => authToken != null ? 'Bearer $authToken' : null,
  );

  final wsLink = WebSocketLink(
    'ws://10.0.2.2:8080/query',
    config: SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: Duration(seconds: 30),
      initialPayload: () async => {
        'Authorization': authToken != null ? 'Bearer $authToken' : '',
      },
    ),
  );

  final link = Link.split(
    (request) => request.isSubscription,
    wsLink,
    authLink.concat(httpLink),
  );

  return GraphQLClient(
    cache: GraphQLCache(store: InMemoryStore()),
    link: link,
  );
}
