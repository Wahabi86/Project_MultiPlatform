import "package:flutter/material.dart";
import "package:carousel_slider/carousel_slider.dart";
import "package:project_uts/ui/detail_page.dart";
import "package:project_uts/widgets/tabbar_genre.dart";
// import "package:project_uts/widgets/bottom_nav.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<Map<String, dynamic>> banners = [
  {
    "title": "Gundala",
    "rating": 5,
    "poster": "assets/images/BannerGundala.jpg",
    "genre": "Action, Drama",
    "duration": "2hr 3 min",
    "status": "XXI, Cinepolis",
    "actors": [
      {
        "name": "Abimana Arya",
        "photo": "assets/images/actors/AbimanaAryasatya.jpg"
      },
      {"name": "Ario Bayu", "photo": "assets/images/actors/Ario Bayu.jpg"},
      {
        "name": "Bront Palarae",
        "photo": "assets/images/actors/Bront Palarae.jpg"
      },
      {"name": "Tara Basro", "photo": "assets/images/actors/tarabasro.jpg"},
    ]
  },
  {
    "title": "Malam Pencabut Nyawa",
    "rating": 3.5,
    "poster": "assets/images/BannerMalam.jpg",
    "genre": "Horor"
  },
  {
    "title": "Mencuri Raden Saleh",
    "rating": 5,
    "poster": "assets/images/BannerMencuri.jpg",
    "genre": "Action, Drama"
  },
];

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

  List<Map<String, dynamic>> movies = [
    {
      "title": "Sumala",
      "rating": 4,
      "poster": "assets/images/Sumala.jpg",
      "genre": "Horor",
      "duration": "1hr 25 min",
      "status": "XXI, Cinepolis",
      "actors": [
        {
          "name": "Achmad Megantara",
          "photo": "assets/images/actors/achmad.jpg"
        },
        {"name": "Luna Maya", "photo": "assets/images/actors/luna.jpg"},
        {"name": "Sally Marcelina", "photo": "assets/images/actors/sally.jpg"},
        {"name": "Tio Pakusadewo", "photo": "assets/images/actors/tio.jpg"},
      ]
    },
    {
      "title": "Komang",
      "rating": 4,
      "poster": "assets/images/Komang.jpg",
      "genre": "Romance",
      "duration": "1hr 47 min",
      "status": "XXI, Cinepolis",
      "actors": [
        {"name": "Aurora Ribero", "photo": "assets/images/actors/aurora.jpg"},
        {"name": "Kiesha Alvaro ", "photo": "assets/images/actors/alvaro.jpg"},
        {"name": "Cut Mini Theo", "photo": "assets/images/actors/cutmini.jpg"},
        {"name": "Ayu Laksmi", "photo": "assets/images/actors/laksmi.jpg"},
      ]
    },
    {
      "title": "Yowis Ben",
      "rating": 2.5,
      "poster": "assets/images/YowisBen.jpg",
      "genre": "Comedy, Romance"
    },
    {
      "title": "Perayaan Mati Rasa",
      "rating": 3,
      "poster": "assets/images/Perayaan.jpg",
      "genre": "Drama, Action",
      "duration": "1hr 2 min",
      "status": "XXI, Cinepolis, Imax",
      "actors": [
        {"name": "Iqbaal Ramadhan", "photo": "assets/images/actors/iqbaal.jpg"},
        {"name": "Umay Shahab", "photo": "assets/images/actors/umay.jpg"},
        {"name": "Devano Danendra", "photo": "assets/images/actors/devano.jpg"},
        {"name": "Dul Jaelani", "photo": "assets/images/actors/dul.jpg"},
      ]
    },
    {
      "title": "Warkop DKI Kartun",
      "rating": 5,
      "poster": "assets/images/DkiKartun.jpg",
      "genre": "Comedy",
      "duration": "1hr 2 min",
      "status": "XXI, Cinepolis, Imax",
      "actors": [
        {"name": "Iqbaal Ramadhan", "photo": "assets/images/actors/iqbaal.jpg"},
        {"name": "Umay Shahab", "photo": "assets/images/actors/umay.jpg"},
        {"name": "Devano Danendra", "photo": "assets/images/actors/devano.jpg"},
        {"name": "Dul Jaelani", "photo": "assets/images/actors/dul.jpg"},
      ]
    },
    {
      "title": "Tinggal Meninggal",
      "rating": 4.5,
      "poster": "assets/images/TinggalMeninggal.jpg",
      "genre": "Comedy, Drama"
    }
  ];

  List<Map<String, dynamic>> recommendations = [
    {
      "title": "Agak Laen",
      "rating": 4,
      "poster": "assets/images/RcdAgakLaen.jpg",
      "genre": "Comedy"
    },
    {
      "title": "Anak Kolong",
      "rating": 4.5,
      "poster": "assets/images/RcdAnakKolong.jpg",
      "genre": "Drama, Romance"
    },
    {
      "title": "Love Therapy",
      "rating": 5,
      "poster": "assets/images/RcdTherapy.jpg",
      "genre": "Drama, Romance"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
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
          SizedBox(height: 20),

          // COMING SOON TITLE
          Padding(
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
          SizedBox(height: 16),

          // BANNER
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              height: 230,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
            ),
            items: banners.map((banner) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsPage(
                        title: banner["title"],
                        rating: (banner["rating"] as num).toDouble(),
                        poster: banner["poster"],
                        genre: banner["genre"],
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
          SizedBox(height: 25),

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
          SizedBox(height: 20),

          // NOW SHOWING TITLE
          Padding(
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
          SizedBox(height: 16),

          // GRID MOVIES
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: movies.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 20,
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
                          poster: movie["poster"],
                          genre: movie["genre"],
                          actors: movie["actors"] != null
                              ? List<Map<String, String>>.from(movie["actors"])
                              : null,
                          status: movie["status"],
                          duration: movie["duration"],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                            child: Image.asset(
                              movie["poster"],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie["title"],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F172A),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    movie["rating"].toString(),
                                    style: TextStyle(color: Colors.grey[800]),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.star,
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
              },
            ),
          ),
          SizedBox(height: 30),

          // RECOMMENDATION SECTION
          Padding(
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
          SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: recommendations.length,
              separatorBuilder: (context, index) => SizedBox(width: 16),
              itemBuilder: (context, index) {
                final movie = recommendations[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsPage(
                          title: movie["title"],
                          rating: (movie["rating"] as num).toDouble(),
                          poster: movie["poster"],
                          genre: movie["genre"],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 135,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(14)),
                          child: Image.asset(
                            movie["poster"],
                            height: 210,
                            width: 135,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie["title"],
                                style: TextStyle(
                                  color: Color(0xFF0F172A),
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    movie["rating"].toString(),
                                    style: TextStyle(color: Colors.grey[800]),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.star,
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
              },
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
