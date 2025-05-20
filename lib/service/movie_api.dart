import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MovieApi {
  final dio = Dio();
  final String _baseUrl = "https://api.themoviedb.org/3/discover/movie";
  final String _apiKey = "901f1d8971cb65ce5f8f2a0c579ef5e1";

  Future<List<Map<String, dynamic>>> fetchMovies() async {
    try {
      final response = await dio.get("$_baseUrl?api_key=$_apiKey");
      if (response.statusCode == 200) {
        List results = response.data['results'];
        return results.map<Map<String, dynamic>>((movie) {
          return {
            "title": movie["title"],
            "rating": movie["vote_average"],
            "poster": "https://image.tmdb.org/t/p/w500${movie['poster_path']}"
          };
        }).toList();
      } else {
        throw Exception("Failed to load movies");
      }
    } catch (e) {
      Text("Error fetching movies: $e");
      return [];
    }
  }
}
