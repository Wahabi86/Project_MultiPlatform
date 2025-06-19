import 'package:graphql_flutter/graphql_flutter.dart';
import '../graphql/query/me_query.dart';
import '../graphql/mutations/update_username.dart';
import 'package:project_uts/graphql/graphql_client.dart';

class UserService {
  Future<Map<String, dynamic>?> getProfile() async {
    final client = await getGraphQLClient();
    final result = await client.query(
      QueryOptions(document: gql(meQuery)),
    );
    if (result.hasException) {
      print(result.exception.toString());
      return null;
    }
    return result.data?['me'];
  }

  Future<Map<String, dynamic>?> updateUsername(String newName) async {
    final client = await getGraphQLClient();
    final result = await client.mutate(
      MutationOptions(
        document: gql(updateUsernameMutation),
        variables: {'newName': newName},
      ),
    );
    if (result.hasException) {
      print(result.exception.toString());
      return null;
    }
    return result.data?['updateUsername'];
  }
}
