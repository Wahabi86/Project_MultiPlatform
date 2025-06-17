import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_uts/ui/detail_page.dart';
import 'package:project_uts/widgets/tabbar_genre.dart';
import 'package:project_uts/datas/data_dummy.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedGenre = "All";
  List<String> genres = [
    "All",
    "Action",
    "Drama",
    "Comedy",
    "Horror",
    "Romance"
  ];

  // FILTER MOVIE PER GENRE
  List<Map<String, dynamic>> get filteredMovies {
    if (selectedGenre == "All") {
      return movies;
    }
    return movies.where((movie) {
      final movieGenres = movie["genre"] as String? ?? "";
      return movieGenres.toLowerCase().contains(selectedGenre.toLowerCase());
    }).toList();
  }

  // MEMFORMAT DATA ANGKA VIEWS MENJADI K DAN M
  String _formatViews(int views) {
    if (views >= 1000000) {
      return "${(views / 1000000).toStringAsFixed(1)}M";
    } else if (views >= 1000) {
      return "${(views / 1000).toStringAsFixed(1)}K";
    } else {
      return views.toString();
    }
  }

  // ISI DARI MOVIE CARD KETIKA DI CLICK
  Widget _buildMovieCard(Map<String, dynamic> movie, double width) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsPage(
              title: movie["title"] ?? "Unknown Title",
              rating: movie["rating"] != null
                  ? (movie["rating"] as num).toDouble()
                  : 0.0,
              poster: movie["poster"] ?? "",
              genre: movie["genre"] ?? "Unknown Genre",
              duration: movie["duration"] ?? "Unknown Duration",
              status: movie["status"] ?? "Unknown Status",
              synopsis: movie["synopsis"],
              actors: movie["actors"] != null
                  ? List<Map<String, String>>.from(movie["actors"])
                  : null,
            ),
          ),
        );
      },

      // STYLING CARD
      child: Container(
        width: width,
        margin: const EdgeInsets.only(bottom: 10), // Tambah margin untuk shadow
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        // MENAMPILKAN POSTER
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  movie["poster"] ?? "",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            
            // STYLING DALAM CARD MOVIE
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie["title"] ?? "Unknown Title",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        movie["rating"]?.toString() ?? "0.0",
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.star,
                          color: Color(0xFFFFD700), size: 16),
                      const SizedBox(width: 8),
                      const Icon(Icons.remove_red_eye,
                          color: Colors.grey, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        _formatViews(movie["views"] ?? 0),
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
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

  @override
  Widget build(BuildContext context) {
    // UNTUK MENGHITUNG LEBAR UI AGAR TAMPILAN CARD
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - 44) / 2;

    return Scaffold(
      // APP BAR
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Mebalih Film",
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),

          // COMING SOON
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Coming Soon",
              style: TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // BANNER CAROUSEL
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              height: 230,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              viewportFraction: 0.7,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
            ),
            items: banners.map((banner) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsPage(
                        title: banner["title"] ?? "Unknown Title",
                        poster: banner["poster"] ?? "",
                        genre: banner["genre"] ?? "Unknown Genre",
                        status: banner["status"] ?? "Unknown Status",
                        actors: banner["actors"] != null
                            ? List<Map<String, String>>.from(banner["actors"])
                            : null,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      banner["poster"] ?? "",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                              size: 50,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 25),

          // GENRE TAB
          GenresTabBar(
            genres: genres,
            selectedGenre: selectedGenre,
            onGenreSelected: (genre) {
              setState(() {
                selectedGenre = genre;
              });
            },
          ),
          const SizedBox(height: 20),

          // NOW SHOWING
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Now Showing",
              style: TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // MOVIES GRID FILTER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: filteredMovies.isEmpty
                ? Container(
                    height: 200,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.movie_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "No movies found for $selectedGenre",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )

                // UNTUK TAMPILAN BERAPA CARD MOVIE YANG MUNCUL
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
                      return _buildMovieCard(movie, double.infinity);
                    },
                  ),
          ),
          const SizedBox(height: 30),

          // RECOMMENDATIONS
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Recommendations",
              style: TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // CARD MOVIE RECOMMENDATIONS
          SizedBox(
            height: (cardWidth / 0.6) +
                20, // Tambah 20 untuk space shadow dan margin
            child: recommendations.isEmpty
                ? Center(
                    child: Text(
                      "No recommendations available",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: recommendations.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 20),
                    itemBuilder: (context, index) {
                      final movie = recommendations[index];
                      return _buildMovieCard(movie, cardWidth);
                    },
                  ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
