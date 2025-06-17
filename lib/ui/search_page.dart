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
  // MENAMPUNG HASIL PENCARIAN DATA MOVIE
  List<Map<String, dynamic>> filteredResults = [];

// MENGAMBIL SEMUA DATA DUMMY
  List<Map<String, dynamic>> getAllUniqueMovies() {
    final allMovies = [...banners, ...movies, ...recommendations];
    final seenTitles = <String>{};

// UNTUK MENGHILANGKAN DUPLIKASI TITLE JIKA ADA
    final uniqueList = allMovies.where((movie) {
      final title = movie['title'] ?? '';
      if (seenTitles.contains(title)) return false;
      seenTitles.add(title);
      return true;
    }).toList();

    return uniqueList;
  }

// MELAKUKAN SEARCH BERDASARKAN TITLE DAN MENYESUAIKAN INPUT DARI USER
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        // SEARCH BAR
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            SearchWidget(
              controller: searchController,
              onSubmitted: performSearch,
            ),
            const SizedBox(height: 20),

            //TEXT SEARCH RESULTS
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Search results (${filteredResults.length})",
                style: const TextStyle(color: Colors.black87),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              // ICON DAN TEXT SAAT MOVIE TIDAK ADA
              child: filteredResults.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.error_outline,
                              color: Colors.grey, size: 48),
                          SizedBox(height: 12),
                          Text(
                            "Movie Not Available",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )

                  // TAMPILAN HASIL PENCARIAN MOVIE DALAM BENTUK LIST
                  : ListView.builder(
                      itemCount: filteredResults.length,
                      itemBuilder: (context, index) {
                        final movie = filteredResults[index];
                        final rating = movie["rating"];

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
                                  duration: movie["duration"],
                                  rating: rating is int
                                      ? rating.toDouble()
                                      : rating,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // POSTER
                                Container(
                                  width: 130,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
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
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      movie["poster"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),

                                // STYLE DATA CARD
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie["title"],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      if (rating != null)
                                        Row(
                                          children: [
                                            Text(
                                              rating % 1 == 0
                                                  ? rating.toInt().toString()
                                                  : rating.toStringAsFixed(1),
                                              style: const TextStyle(
                                                color: Color(0xFFFFC700),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Row(
                                              children: List.generate(5, (i) {
                                                if (i < rating.floor()) {
                                                  return const Icon(Icons.star,
                                                      color: Color(0xFFFFC700),
                                                      size: 18);
                                                } else if (i < rating &&
                                                    (rating - i) >= 0.5) {
                                                  return const Icon(
                                                      Icons.star_half,
                                                      color: Color(0xFFFFC700),
                                                      size: 18);
                                                } else {
                                                  return const Icon(
                                                      Icons.star_border,
                                                      color: Color(0xFFFFC700),
                                                      size: 18);
                                                }
                                              }),
                                            ),
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
