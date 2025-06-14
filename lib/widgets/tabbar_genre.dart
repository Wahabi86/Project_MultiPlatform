import 'package:flutter/material.dart';

class GenresTabBar extends StatelessWidget {
  final List<String> genres;
  final String selectedGenre;
  final ValueChanged<String> onGenreSelected;

  const GenresTabBar({
    super.key,
    required this.genres,
    required this.selectedGenre,
    required this.onGenreSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        separatorBuilder: (context, index) => SizedBox(width: 10),
        itemCount: genres.length,
        itemBuilder: (context, index) {
          final genre = genres[index];
          final isSelected = genre == selectedGenre;

          return GestureDetector(
            onTap: () => onGenreSelected(genre),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF00425A) : Colors.white,
                border: Border.all(
                  color: isSelected ? Color(0xFF00425A) : Color(0xFFCCCCCC),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  genre,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Color(0xFF0F172A),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
