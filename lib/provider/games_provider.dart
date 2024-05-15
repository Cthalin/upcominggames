import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upcoming_games/models/game.dart';

final dummyGame = Game(
  id: 0,
  name: "Dummy Game",
  date: "2024-01-01",
  bg: "https://miro.medium.com/fit/c/176/176/1*8oa-e4oHBmsthYpHy5DzJw.png",
  platforms: "PC, PS5, Xbox Series X",
  rating: 0,
  description: "Some description",
  website: "https://example.com",
  screenshots: [
    "https://miro.medium.com/fit/c/176/176/1*8oa-e4oHBmsthYpHy5DzJw.png",
  ],
);

final gamesProvider = StateNotifierProvider<GamesNotifier, List<Game>>((ref) {
  return GamesNotifier();
});

class GamesNotifier extends StateNotifier<List<Game>> {
  GamesNotifier() : super([]);

  void loadGames({String? startDate, String? endDate}) async {
    FirebaseFunctions functions = FirebaseFunctions.instance;
    final callable = functions.httpsCallableFromUrl(
      "https://europe-west1-upcominggamesapp.cloudfunctions.net/fetchGames",
    );
    final results = await callable();
    List games = results.data['games'] as List;
    state = games.map((game) => Game.fromJson(game)).toList();
  }

  Game getGameById(int id) {
    return state.firstWhere((game) => game.id == id);
  }

  void loadNextMonth() {}

  void loadPreviousMonth() {}
}
