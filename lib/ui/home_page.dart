import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_uts/ui/detail_page.dart';
import 'package:project_uts/widgets/tabbar_genre.dart';
// import 'package:project_uts/widgets/bottom_nav.dart';

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
    "Adventure",
    "Comedy",
    "Horror",
    "Romance"
  ];

  List<Map<String, dynamic>> movies = [
    {
      "title": "Sumala",
      "rating": 4,
      "poster": null,
    },
    {
      "title": "Spiderman The Movie",
      "rating": 4,
      "poster": null,
    },
    {
      "title": "Yowis Ben",
      "rating": 5,
      "poster": null,
    },
    {
      "title": "Perayaan Mati Rasa",
      "rating": 3,
      "poster": null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text(
          "Movie Apps",
          style: TextStyle(
              color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // Memberikan jarak antar search bar dengan CarouselSlider
          SizedBox(height: 25),

          // membuat movie auto play dengan CarouselSlider
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              height: 250,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            items: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[500]),
              )
            ],
          ),
          // memberikan jarak antar CarouselSlider dengan TabBar genre
          SizedBox(height: 30),

          // Genre TabBar
          GenresTabBar(
            genres: genres,
            selectedGenre: selectedGenre,
            onGenreSelected: (genre) {
              setState(() {
                selectedGenre = genre;
              });
            },
          ),

          // memberikan jarak antar konten genre TabBar dengan konten card movie
          SizedBox(height: 30),

          // card movie per-genre
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              height: 650,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: movies.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 22,
                  childAspectRatio: 0.6,
                ),
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsPage(
                            title: movie["title"],
                            rating: (movie["rating"] as num).toDouble(),
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[500],
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          movie["title"],
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              movie["rating"].toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.star,
                                color: Color(0xFFFFC700), size: 16),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
