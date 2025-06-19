// lib/services/movie_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieService {
  static const String _baseUrl =
      'http://10.0.2.2:8080/graphql'; // Ganti dengan URL GraphQL Anda

  static Future<List<Map<String, dynamic>>> fetchMovies() async {
    const String query = '''
      query GetMovies {
        movies {
          id
          title
          rating
          duration
          synopsis
          poster
          broadcasts
          genres {
            name
          }
          actors {
            name
          }
          statuses {
            name
          }
        }
      }
    ''';

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'query': query,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['errors'] != null) {
          throw Exception('GraphQL Error: ${data['errors']}');
        }

        final List<dynamic> movies = data['data']['movies'];
        return movies.cast<Map<String, dynamic>>();
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch movies: $e');
    }
  }

  static Future<Map<String, dynamic>> fetchMovieById(String id) async {
    const String query = '''
      query GetMovie(\$id: ID!) {
        movie(id: \$id) {
          id
          title
          rating
          duration
          synopsis
          poster
          broadcasts
          genres {
            name
          }
          actors {
            name
          }
          statuses {
            name
          }
        }
      }
    ''';

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'query': query,
          'variables': {'id': id},
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['errors'] != null) {
          throw Exception('GraphQL Error: ${data['errors']}');
        }

        return data['data']['movie'];
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch movie: $e');
    }
  }
}
