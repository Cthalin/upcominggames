import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upcoming_games/models/game.dart';
import 'package:upcoming_games/models/minimal_game.dart';

final gamesProvider = StateNotifierProvider<GamesNotifier, GamesState>((ref) {
  return GamesNotifier();
});

class GamesNotifier extends StateNotifier<GamesState> {
  GamesNotifier() : super(GamesState.initial());

  Future<void> loadGames({String? startDate, String? endDate}) async {
    state = state.copyWith(isLoading: true);
    FirebaseFunctions functions = FirebaseFunctions.instance;
    final callable = functions.httpsCallableFromUrl(
      "https://europe-west1-upcominggamesapp.cloudfunctions.net/fetchGames",
    );
    await callable().then(
      (result) => {
        state = state.copyWith(
          games: (result.data as List)
              .map((game) => MinimalGame.fromJson(game))
              .toList(),
          isLoading: false,
        ),
      },
    );
  }

  Future<void> getGameById(int id) async {
    FirebaseFunctions functions = FirebaseFunctions.instance;
    final callable = functions.httpsCallableFromUrl(
      "https://europe-west1-upcominggamesapp.cloudfunctions.net/fetchGameDetails",
    );
    await callable().then(
      (value) => state = state.copyWith(
        selectedGame: Game.fromJson(value.data),
      ),
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
