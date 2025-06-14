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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "Mebalih Film",
          style: TextStyle(
              color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
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
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    banner["poster"],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            }).toList(),
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
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: movies.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 25,
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
                                ? List<Map<String, String>>.from(
                                    movie["actors"])
                                : null,
                            status: movie["status"],
                            duration: movie["duration"],
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              movie["poster"],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          movie["title"],
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              movie["rating"].toString(),
                              style: TextStyle(color: Colors.black),
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
          // spacing sebelum section Recommendations
          SizedBox(height: 30),

          // Garis Horizontal
          Divider(
            color: Colors.grey,
            thickness: 1,
            height: 1,
          ),
          SizedBox(height: 18),

          // Judul Recomendations
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Recommendations",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 16),

          // Horizontal card movie
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
                  child: SizedBox(
                    width: 135,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            movie["poster"],
                            height: 220,
                            width: 130,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          movie["title"],
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              movie["rating"] % 1 == 0
                                  ? movie["rating"].toInt().toString()
                                  : movie["rating"].toString(),
                              style: TextStyle(color: Color(0xFFFFC700)),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.star,
                                color: Color(0xFFFFC700), size: 16),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
