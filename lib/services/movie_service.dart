import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:project_uts/graphql/graphql_client.dart';
import 'package:project_uts/graphql/mutations/movies_query.dart';
import 'package:project_uts/models/movie.dart'; // Import model Movie yang baru kita buat

class MovieService {
  Future<List<Movie>> getMovies() async { // Ubah return type menjadi List<Movie>
    final client = await getGraphQLClient();

    final result = await client.query(
      QueryOptions(
        document: gql(moviesQuery),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      print("GraphQL Error: ${result.exception.toString()}");
      return [];
    }

    final List<dynamic>? moviesData = result.data?['movies'];
    if (moviesData == null) {
      print("No movies data found.");
      return [];
    }

    return moviesData.map((e) => Movie.fromJson(e as Map<String, dynamic>)).toList();
  }
}