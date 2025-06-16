import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';
import '../datas/data_dummy.dart';
import 'detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredResults = [];

  List<Map<String, dynamic>> getAllUniqueMovies() {
    final allMovies = [...banners, ...movies, ...recommendations];
    final seenTitles = <String>{};

    return allMovies.where((movie) {
      final title = movie['title'] ?? '';
      if (seenTitles.contains(title)) return false;
      seenTitles.add(title);
      return true;
    }).toList();
  }

  void performSearch(String keyword) {
    final allMovies = getAllUniqueMovies();
    final results = allMovies.where((movie) {
      return movie['title']
          .toLowerCase()
          .contains(keyword.toLowerCase().trim());
    }).toList();

    setState(() {
      filteredResults = results;
    });
  }

  Widget buildRatingStars(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = rating - fullStars >= 0.5;
    List<Widget> stars = [];

    for (int i = 0; i < 5; i++) {
      if (i < fullStars) {
        stars.add(const Icon(Icons.star, color: Color(0xFFFFD700), size: 18));
      } else if (i == fullStars && hasHalfStar) {
        stars.add(
            const Icon(Icons.star_half, color: Color(0xFFFFD700), size: 18));
      } else {
        stars.add(
            const Icon(Icons.star_border, color: Color(0xFFFFD700), size: 18));
      }
    }

    return Row(children: stars);
  }

  @override
  Widget build(BuildContext context) {
    final resultsCount = filteredResults.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            SearchWidget(
              controller: searchController,
              onSubmitted: performSearch,
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Search results ($resultsCount)",
                style: const TextStyle(color: Colors.black87),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: resultsCount == 0
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.error_outline,
                              color: Colors.grey, size: 48),
                          SizedBox(height: 12),
                          Text(
                            "Film Not Available",
                            style:
                                TextStyle(fontSize: 18, color: Colors.black54),
                          )
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: resultsCount,
                      itemBuilder: (context, index) {
                        final movie = filteredResults[index];
                        final rating = movie["rating"] ?? 0;
                        final isDecimal = rating % 1 != 0;
                        final ratingLabel = isDecimal
                            ? rating.toStringAsFixed(1)
                            : rating.toStringAsFixed(0);

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MovieDetailsPage(
                                  title: movie["title"],
                                  poster: movie["poster"],
                                  genre: movie["genre"],
                                  status: movie["status"],
                                  synopsis: movie["synopsis"],
                                  actors: movie["actors"],
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 130,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      )
                                    ],
                                    image: DecorationImage(
                                      image: AssetImage(movie["poster"]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie["title"],
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            "$ratingLabel ",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          buildRatingStars(rating.toDouble()),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        movie["genre"],
                                        style: const TextStyle(
                                            color: Colors.black54),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        movie["synopsis"],
                                        style: const TextStyle(
                                            color: Colors.black45),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
