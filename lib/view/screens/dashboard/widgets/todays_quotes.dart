// 💭 Today's Quote Section
import 'package:flutter/material.dart';

class BuildTodaysQuotesSection extends StatelessWidget {
  BuildTodaysQuotesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final todayQuote = quotes[DateTime.now().day % quotes.length];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromARGB(255, 66, 88, 214),
            Colors.purple.shade400,
            Colors.pink.shade300,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  todayQuote["icon"] as IconData,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                "💭 Today's Quote",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Text(
            '"${todayQuote["quote"]}"',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "— ${todayQuote["author"]}",
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final quotes = [
    {
      "quote": "A journey of a thousand miles begins with a single step.",
      "author": "Lao Tzu",
      "icon": Icons.airplanemode_active_rounded,
    },
    {
      "quote":
          "The world is a book and those who do not travel read only one page.",
      "author": "Saint Augustine",
      "icon": Icons.public_rounded,
    },
    {
      "quote": "Immigration is the sincerest form of flattery.",
      "author": "Jack Paar",
      "icon": Icons.favorite_rounded,
    },
    {
      "quote": "Every dream begins with a dreamer who dares to cross borders.",
      "author": "Migration Wisdom",
      "icon": Icons.star_rounded,
    },
    {
      "quote":
          "Travel makes one modest. You see what a tiny place you occupy in the world.",
      "author": "Gustave Flaubert",
      "icon": Icons.travel_explore_rounded,
    },
    {
      "quote": "To travel is to live.",
      "author": "Hans Christian Andersen",
      "icon": Icons.flight_rounded,
    },
    {
      "quote":
          "Borders are not just lines on a map, but bridges to new opportunities.",
      "author": "",
      "icon": Icons.map_rounded,
    },
    {
      "quote": "The best view comes after the hardest climb.",
      "author": "",
      "icon": Icons.terrain_rounded,
    },
    {
      "quote":
          "Success is not the key to happiness. Happiness is the key to success.",
      "author": "Albert Schweitzer",
      "icon": Icons.emoji_emotions_rounded,
    },
    {
      "quote": "Great things never came from comfort zones.",
      "author": "",
      "icon": Icons.directions_run_rounded,
    },
    {
      "quote": "The only impossible journey is the one you never begin.",
      "author": "Tony Robbins",
      "icon": Icons.flag_rounded,
    },
    {
      "quote":
          "Opportunities are like sunrises. If you wait too long, you miss them.",
      "author": "William Arthur Ward",
      "icon": Icons.wb_sunny_rounded,
    },
    {
      "quote":
          "Your life does not get better by chance, it gets better by change.",
      "author": "Jim Rohn",
      "icon": Icons.change_circle_rounded,
    },
    {
      "quote": "Wherever you go becomes a part of you somehow.",
      "author": "Anita Desai",
      "icon": Icons.location_on_rounded,
    },
  ];
}
