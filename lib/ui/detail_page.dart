import "package:flutter/material.dart";
import "package:project_uts/widgets/forum_chat.dart";
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsPage extends StatelessWidget {
  final String title;
  final double? rating;
  final String poster;
  final String genre;
  final List<Map<String, String>>? actors;
  final String? status;
  final String? duration;
  final String? synopsis;

  const MovieDetailsPage({
    super.key,
    required this.title,
    this.rating,
    required this.poster,
    required this.genre,
    this.actors,
    this.status,
    this.duration,
    this.synopsis,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = Colors.black;
    final accentColor = const Color(0xFFFFC700);
    final tagBackground = Colors.grey.shade200;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: themeColor),
        elevation: 1,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: themeColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Poster
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        poster,
                        height: 450,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Judul
                    Text(
                      title,
                      style: TextStyle(
                        color: themeColor,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Duration + Genre
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        if (duration != null)
                          _buildTag(duration!, tagBackground, themeColor),
                        ...genre
                            .split(",")
                            .map((item) => _buildTag(
                                item.trim(), tagBackground, themeColor))
                            .toList(),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Rating
                    if (rating != null) ...[
                      Row(
                        children: [
                          Text(
                            rating! % 1 == 0
                                ? rating!.toInt().toString()
                                : rating!.toStringAsFixed(1),
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            children: List.generate(5, (index) {
                              if (index < rating!.floor()) {
                                return Icon(Icons.star,
                                    color: accentColor, size: 20);
                              } else if (index < rating! &&
                                  rating! - index >= 0.5) {
                                return Icon(Icons.star_half,
                                    color: accentColor, size: 20);
                              } else {
                                return Icon(Icons.star_border,
                                    color: accentColor, size: 20);
                              }
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                    Divider(color: Colors.grey.shade300, thickness: 1),

                    // Actors
                    if (actors != null && actors!.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        "Actors",
                        style: TextStyle(
                          color: themeColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 120,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: actors!.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 16),
                          itemBuilder: (context, index) {
                            final actor = actors![index];
                            return Column(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    actor["photo"]!,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                SizedBox(
                                  width: 80,
                                  child: Text(
                                    actor["name"]!,
                                    style: TextStyle(
                                      color: themeColor,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Synopsis
                    Text(
                      "Synopsis",
                      style: TextStyle(
                        color: themeColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ExpandableSynopsis(
                      text: synopsis ?? "Synopsis tidak tersedia.",
                    ),

                    // Status
                    if (status != null) ...[
                      const SizedBox(height: 24),
                      Text(
                        "Broadcast Status",
                        style: TextStyle(
                          color: themeColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // LINK URL BROADCAST
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: status!.split(",").map((item) {
                          final label = item.trim().toLowerCase();
                          String? url;

                          switch (label) {
                            case "xxi":
                              url = "https://m.21cineplex.com/id";
                              break;
                            case "netflix":
                              url = "https://www.netflix.com/";
                              break;
                            case "cinepolis":
                              url = "https://cinepolis.co.id/";
                              break;
                          }

                          return GestureDetector(
                            onTap: url != null ? () => _launchURL(url!) : null,
                            child: _buildTag(
                              item.trim(),
                              tagBackground,
                              themeColor,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          // Forum untuk Chat Button
          const ForumChatButton(),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}

// Widget untuk ringkas/expand sinopsis
class ExpandableSynopsis extends StatefulWidget {
  final String text;

  const ExpandableSynopsis({super.key, required this.text});

  @override
  State<ExpandableSynopsis> createState() => _ExpandableSynopsisState();
}

class _ExpandableSynopsisState extends State<ExpandableSynopsis> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final sentences = widget.text.split(RegExp(r'(?<=[.!?])\s+'));
    final shortText = sentences.take(2).join(' ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isExpanded ? widget.text : shortText,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 16,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 8),
        if (sentences.length > 3)
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded ? 'Show Less' : 'Show All',
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
