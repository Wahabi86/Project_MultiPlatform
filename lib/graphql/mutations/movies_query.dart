const String moviesQuery = r'''
query GetMovies {
  movies {
    id
    name_movies
    poster
    description_movies
    views
    rating
    duration
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
