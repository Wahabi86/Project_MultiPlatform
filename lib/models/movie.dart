class Movie {
  final String id;
  final String nameMovies;
  final String poster;
  final String descriptionMovies;
  final int views;
  final double rating;
  final int duration;
  final List<String> genres;
  final List<String> actors;
  final List<String> statuses;

  Movie({
    required this.id,
    required this.nameMovies,
    required this.poster,
    required this.descriptionMovies,
    required this.views,
    required this.rating,
    required this.duration,
    required this.genres,
    required this.actors,
    required this.statuses,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id']
          .toString(), // ID mungkin int di Go, pastikan di-convert ke String jika perlu
      nameMovies: json['name_movies'] as String,
      poster: json['poster'] as String,
      descriptionMovies: json['description_movies'] as String,
      views: json['views'] as int,
      rating: (json['rating'] as num)
          .toDouble(), // Rating mungkin int atau double, pastikan ke double
      duration: json['duration'] as int,
      genres: (json['genres'] as List<dynamic>)
          .map((e) => e['name'] as String)
          .toList(),
      actors: (json['actors'] as List<dynamic>)
          .map((e) => e['name'] as String)
          .toList(),
      statuses: (json['statuses'] as List<dynamic>)
          .map((e) => e['name'] as String)
          .toList(),
    );
  }
}
