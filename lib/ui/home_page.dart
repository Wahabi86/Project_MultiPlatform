import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_uts/ui/detail_page.dart';
import 'package:project_uts/widgets/tabbar_genre.dart';
import 'package:project_uts/datas/data_dummy.dart';

const primaryColor = Color(0xFF0F172A);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedGenre = "All";
  final List<String> genres = [
    "All",
    "Action",
    "Drama",
    "Comedy",
    "Horror",
    "Romance"
  ];

  @override
  Widget build(BuildContext context) {
    // --film sesuai genre--
    final filteredMovies = selectedGenre == "All"
        ? movies
        : movies.where((movie) {
            final genres = (movie["genre"] as String).split(',').map(
                (g) => g.trim().toLowerCase()); // hapus spasi dan lowercase
            return genres.contains(selectedGenre.toLowerCase());
          }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Mebalih Film",
          style: TextStyle(
            color: primaryColor,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 20),

            // --- COMING SOON ---
            _sectionTitle("Coming Soon"),
            const SizedBox(height: 16),

            // --- BANNER CAROUSEL ---
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                height: 230,
                enlargeCenterPage: true,
                viewportFraction: 0.7,
              ),
              items: banners.map((banner) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => MovieDetailsPage(
                          title: banner["title"],
                          poster: banner["poster"],
                          genre: banner["genre"],
                          status: banner["status"],
                          actors: banner["actors"] != null
                              ? List<Map<String, String>>.from(banner["actors"])
                              : null,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      banner["poster"],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 25),

            // --- GENRE TAB ---
            GenresTabBar(
              genres: genres,
              selectedGenre: selectedGenre,
              onGenreSelected: (g) => setState(() => selectedGenre = g),
            ),
            const SizedBox(height: 20),

            // --- NOW SHOWING ---
            _sectionTitle("Now Showing"),
            const SizedBox(height: 16),

            // --- MOVIES GRID ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: filteredMovies.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          "Belum ada film untuk genre ini.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredMovies.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (context, index) {
                        final movie = filteredMovies[index];
                        return _MovieCard(movie: movie);
                      },
                    ),
            ),
            const SizedBox(height: 30),

            // --- RECOMMENDATIONS ---
            _sectionTitle("Recommendations"),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: recommendations.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final movie = recommendations[index];
                  return _RecommendationCard(movie: movie);
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Title Section
  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          text,
          style: const TextStyle(
            color: primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}

// Section Now Showing
class _MovieCard extends StatelessWidget {
  final Map<String, dynamic> movie;
  const _MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MovieDetailsPage(
            title: movie["title"],
            rating: (movie["rating"] as num).toDouble(),
            poster: movie["poster"],
            genre: movie["genre"],
            duration: movie["duration"],
            status: movie["status"],
            actors: movie["actors"] != null
                ? List<Map<String, String>>.from(movie["actors"])
                : null,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: movie["poster"],
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    movie["poster"],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie["title"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        movie["rating"].toString(),
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.star,
                          color: Color(0xFFFFD700), size: 16),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Section Recomend
class _RecommendationCard extends StatelessWidget {
  final Map<String, dynamic> movie;
  const _RecommendationCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MovieDetailsPage(
            title: movie["title"],
            rating: (movie["rating"] as num).toDouble(),
            poster: movie["poster"],
            genre: movie["genre"],
            duration: movie["duration"],
            status: movie["status"],
            actors: movie["actors"] != null
                ? List<Map<String, String>>.from(movie["actors"])
                : null,
          ),
        ),
      ),
      child: Container(
        width: 135,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
              child: Image.asset(
                movie["poster"],
                height: 210,
                width: 135,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie["title"],
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        movie["rating"].toString(),
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.star,
                          color: Color(0xFFFFD700), size: 16),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
