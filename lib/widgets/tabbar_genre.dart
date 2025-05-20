import 'package:flutter/material.dart';

class GenresTabBar extends StatelessWidget {
  final List<String> genres;
  final String selectedGenre;
  final Function(String) onGenreSelected;

  const GenresTabBar({
    super.key,
    required this.genres,
    required this.selectedGenre,
    required this.onGenreSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // jarak kiri
          SizedBox(width: 15),
          for (String genre in genres)
            GestureDetector(
              onTap: () => onGenreSelected(genre),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                decoration: BoxDecoration(
                  color:
                      selectedGenre == genre ? Colors.white : Color(0xFF2B2B2B),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  genre,
                  style: TextStyle(
                    color: selectedGenre == genre ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          // jarak kanan
          SizedBox(width: 15),
        ],
      ),
    );
  }
}
