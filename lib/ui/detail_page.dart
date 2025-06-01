import 'package:flutter/material.dart';

class MovieDetailsPage extends StatelessWidget {
  final String title;
  final double rating;
  final String poster;

  const MovieDetailsPage({
    super.key,
    required this.title,
    required this.rating,
    required this.poster,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                poster,
                height: 500,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  rating % 1 == 0
                      ? rating.toInt().toString()
                      : rating.toString(),
                  style: TextStyle(
                    color: Color(0xFFFFC700),
                    fontSize: 18,
                  ),
                ),
                SizedBox(width: 8),
                Row(
                  children: List.generate(rating.floor(), (index) {
                    return Icon(
                      Icons.star,
                      color: Color(0xFFFFC700),
                      size: 18,
                    );
                  }),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Alur Cerita',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Deskripsi cerita disesuaikan dengan data film masing-masing...",
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
