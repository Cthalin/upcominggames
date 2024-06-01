import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upcoming_games/models/game.dart';
import 'package:upcoming_games/models/minimal_game.dart';

final gamesProvider = StateNotifierProvider<GamesNotifier, GamesState>((ref) {
  return GamesNotifier(firebaseFunctions: FirebaseFunctions.instance);
});

class GamesNotifier extends StateNotifier<GamesState> {
  final FirebaseFunctions firebaseFunctions;

  GamesNotifier({required this.firebaseFunctions})
      : super(GamesState.initial());

  Future<void> loadGames({
    String? startDate,
    String? endDate,
    int? offset,
  }) async {
    try {
      state = state.copyWith(isLoading: true);
      final callable = firebaseFunctions.httpsCallableFromUrl(
        "https://europe-west1-upcominggamesapp.cloudfunctions.net/fetchGames",
      );
      final response = await callable.call(<String, dynamic>{
        'startDate': startDate,
        'endDate': endDate,
        'offset': offset,
      });
      state = state.copyWith(
        games: [
          ...state.games,
          ...(response.data as List).map((game) => MinimalGame.fromJson(game)),
        ],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadGameById(int id) async {
    final exists = state.loadedGames.any((element) => element.id == id);
    if (exists) {
      state = state.copyWith(
        selectedGame:
            state.loadedGames.firstWhere((element) => element.id == id),
        isLoading: false,
      );
    }
    try {
      state = state.copyWith(isLoading: true);
      final callable = firebaseFunctions.httpsCallableFromUrl(
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
    final DateTime firstDayNextMonth =
        DateTime(DateTime.now().year, DateTime.now().month + 1, 1);
    final DateTime lastDayNextMonth =
        DateTime(DateTime.now().year, DateTime.now().month + 2, 0);

    loadGames(
      startDate: firstDayNextMonth.toIso8601String(),
      endDate: lastDayNextMonth.toIso8601String(),
    );
  }

  void loadPreviousMonth() {
    final DateTime firstDayPrevMonth =
        DateTime(DateTime.now().year, DateTime.now().month - 1, 1);
    final DateTime lastDayPrevMonth =
        DateTime(DateTime.now().year, DateTime.now().month, 0);

    loadGames(
      startDate: firstDayPrevMonth.toIso8601String(),
      endDate: lastDayPrevMonth.toIso8601String(),
    );
  }

  Future<void> loadMoreGames() async {
    await loadGames(offset: state.games.length - 1);
  }

  MinimalGame? getGameById(int id) {
    return state.games.firstWhereOrNull((element) => element.id == id);
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
