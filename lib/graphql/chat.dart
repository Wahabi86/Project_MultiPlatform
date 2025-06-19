import 'package:graphql_flutter/graphql_flutter.dart';
import '../graphql/graphql_client.dart';

const String messageSubscription = r'''
subscription MessageAdded($roomID: ID!) {
  messageAdded(roomID: $roomID) {
    id
    content
    senderID
    roomID
    createdAt
  }
}
''';

Future<Stream<QueryResult>> subscribeToRoom(String roomID) async {
  final client = await getGraphQLClient(); // ✅ tunggu sampai client siap

  return client.subscribe(
    SubscriptionOptions(
      document: gql(messageSubscription),
      variables: {'roomID': roomID},
    ),
  );
}

const String sendMessageMutation = r'''
mutation SendMessage($content: String!, $senderID: ID!, $roomID: ID!) {
  sendMessage(content: $content, senderID: $senderID, roomID: $roomID) {
    id
  }
}
''';

Future<void> sendMessageToRoom(
    String content, String senderID, String roomID) async {
  final client = await getGraphQLClient(); // ✅ tunggu hasil Future
  await client.mutate(
    MutationOptions(
      document: gql(sendMessageMutation),
      variables: {
        'content': content,
        'senderID': senderID,
        'roomID': roomID,
      },
    ),
  );
}
