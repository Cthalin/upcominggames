import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

class Game {
  num id;
  String name;
  String date;
  String bg;
  String platforms;
  double rating;
  String description;
  String website;
  List<String> screenshots;

  Game({
    this.id = 0,
    this.name = "",
    this.date = "",
    this.bg = "",
    this.platforms = "",
    this.rating = 0,
    this.description = "",
    this.website = "",
    List<String>? screenshots,
  }) : screenshots = screenshots ?? <String>[];
}

@riverpod
List<Game> getGames(GetGamesRef ref) {
  return <Game>[
    Game(
      id: 0,
      name: "Dummy Game",
      date: "2024-01-01",
      bg: "",
      platforms: "PC, PS5, Xbox Series X",
      rating: 0,
      description: "Some description",
      website: "https://example.com",
      screenshots: [],
    )
  ];
}

class GetGamesRef {}

final gamesProvider = Provider<List<Game>>((ref) {
  Timer(const Duration(seconds: 2), () {});
  return <Game>[
    Game(
      id: 0,
      name: "Dummy Game",
      date: "2024-01-01",
      bg: "",
      platforms: "PC, PS5, Xbox Series X",
      rating: 0,
      description: "Some description",
      website: "https://example.com",
      screenshots: [],
    )
  ];
});
