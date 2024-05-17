import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upcoming_games/models/game.dart';
import 'package:upcoming_games/models/minimal_game.dart';

final gamesProvider = StateNotifierProvider<GamesNotifier, GamesState>((ref) {
  return GamesNotifier();
});

class GamesNotifier extends StateNotifier<GamesState> {
  GamesNotifier() : super(GamesState.initial());

  /// Fetches a list of games from the server.
  ///
  /// This function optionally takes [startDate] and [endDate] as arguments and fetches the corresponding
  /// list of games from the server within this date range. If the date range is not provided, it fetches all games.
  ///
  /// Returns a Future that completes when the games are loaded.
  Future<void> loadGames({String? startDate, String? endDate}) async {
    // TODO respect the given date range
    try {
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
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Fetches the game details from the server.
  ///
  /// This function takes a [gameId] as an argument and fetches the corresponding
  /// game details from the server. If the game details are not already loaded,
  /// it makes a call to the Firebase function to fetch the game details.
  ///
  /// Returns a Future that completes with the game details.
  Future<void> getGameById(int id) async {
    final exists = state.loadedGames.any((element) => element.id == id);
    if (exists) {
      state = state.copyWith(
        selectedGame:
            state.loadedGames.firstWhere((element) => element.id == id),
        isLoading: false,
      );
      return;
    }
    try {
      state = state.copyWith(isLoading: true);
      FirebaseFunctions functions = FirebaseFunctions.instance;
      final callable = functions.httpsCallableFromUrl(
        "https://europe-west1-upcominggamesapp.cloudfunctions.net/fetchGameDetails",
      );
      await callable.call(<String, dynamic>{'gameId': id}).then(
        (value) => state = state.copyWith(
          selectedGame: Game.fromJson(value.data),
          isLoading: false,
          loadedGames: [...state.loadedGames, Game.fromJson(value.data)],
        ),
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
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
  final List<Game> loadedGames;

  GamesState({
    required this.games,
    this.selectedGame,
    required this.isLoading,
    this.error,
    required this.loadedGames,
  });

  factory GamesState.initial() {
    return GamesState(
      games: [],
      isLoading: false,
      error: null,
      loadedGames: [],
    );
  }

  GamesState copyWith({
    List<MinimalGame>? games,
    Game? selectedGame,
    bool? isLoading,
    String? error,
    List<Game>? loadedGames,
  }) {
    return GamesState(
      games: games ?? this.games,
      selectedGame: selectedGame ?? this.selectedGame,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      loadedGames: loadedGames ?? this.loadedGames,
    );
  }
}
