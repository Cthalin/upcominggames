import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upcoming_games/models/game.dart';
import 'package:upcoming_games/models/minimal_game.dart';

final gamesProvider = StateNotifierProvider<GamesNotifier, GamesState>((ref) {
  return GamesNotifier();
});

class GamesNotifier extends StateNotifier<GamesState> {
  GamesNotifier() : super(GamesState.initial());

  void loadGames({String? startDate, String? endDate}) async {
    state = state.copyWith(isLoading: true);
    FirebaseFunctions functions = FirebaseFunctions.instance;
    final callable = functions.httpsCallableFromUrl(
      "https://europe-west1-upcominggamesapp.cloudfunctions.net/fetchGames",
    );
    final results = await callable();
    List games = results.data['games'] as List;
    state = state.copyWith(
      games: games.map((game) => MinimalGame.fromJson(game)).toList(),
      isLoading: false,
    );
  }

  void getGameById(int id) async {
    FirebaseFunctions functions = FirebaseFunctions.instance;
    final callable = functions.httpsCallableFromUrl(
      "https://europe-west1-upcominggamesapp.cloudfunctions.net/fetchGameDetails",
    );
    final result = await callable();
    state = state.copyWith(
      selectedGame: Game.fromJson(result.data),
    );
  }

  void loadNextMonth() {
    /* TODO implement */
  }

  void loadPreviousMonth() {
    /* TODO implement*/
  }
}

class GamesState {
  final List<MinimalGame> games;
  final Game? selectedGame;
  final bool isLoading;
  final String? error;

  GamesState({
    required this.games,
    this.selectedGame,
    required this.isLoading,
    this.error,
  });

  factory GamesState.initial() {
    return GamesState(
      games: [],
      isLoading: false,
      error: null,
    );
  }

  GamesState copyWith({
    List<MinimalGame>? games,
    Game? selectedGame,
    bool? isLoading,
    String? error,
  }) {
    return GamesState(
      games: games ?? this.games,
      selectedGame: selectedGame ?? this.selectedGame,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
