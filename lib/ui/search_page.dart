import "package:flutter/material.dart";
import '../widgets/search_bar.dart';

class SearchPage extends StatelessWidget {
  final List<Map<String, dynamic>> searchResults = [
    {
      "title": "Hitman's Wife's Bodyguard",
      "rating": 3.5,
      "genres": "Comedy",
      "description":
          "The world's most lethal odd couple bodyguard Michael Bryce and hitman Darius Kincaid are back on another mission."
    },
    {
      "title": "Hitman's Wife's Bodyguard",
      "rating": 4,
      "genres": "Action",
      "description":
          "The world's most lethal odd couple bodyguard Michael Bryce and hitman Darius Kincaid are back on another mission."
    },
  ];

  SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 20),
            const SearchWidget(),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Search results (${searchResults.length})",
                style: const TextStyle(color: Colors.black87),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
                child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final movie = searchResults[index];
                return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 130,
                          height: 180,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                )
                              ]),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie["title"],
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: List.generate(5, (i) {
                                return Icon(
                                  i < movie["rating"].floor()
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.yellow,
                                  size: 16,
                                );
                              }),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              movie["genres"],
                              style: const TextStyle(color: Colors.black54),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              movie["description"],
                              style: const TextStyle(color: Colors.black45),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ))
                      ],
                    ));
              },
            ))
          ],
        ),
      ),
    );
  }
}
