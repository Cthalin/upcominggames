import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upcoming_games/models/minimal_game.dart';

final searchProvider = StateNotifierProvider<SearchProvider, SearchState>(
  (ref) => SearchProvider(),
);

class SearchProvider extends StateNotifier<SearchState> {
  SearchProvider() : super(SearchState.initial());

  Future<void> search(String query) async {
    List<MinimalGame> results = await Future.delayed(
      const Duration(seconds: 2),
      () => List<MinimalGame>.generate(
        10,
        (index) => MinimalGame(
          id: index,
          name: 'Game $index',
          cover: 'https://via.placeholder.com/150',
          platforms: 'PC',
        ),
      ),
    );
    try {
      state = state.copyWith(isLoading: true);
      FirebaseFunctions functions = FirebaseFunctions.instance;
      final callable = functions.httpsCallableFromUrl(
        "https://europe-west1-upcominggamesapp.cloudfunctions.net/searchGames",
      );
      await callable.call(<String, dynamic>{'searchTerm': query}).then(
        (result) => {
          state = state.copyWith(
            games: [
              ...state.games,
              ...(result.data as List)
                  .map((game) => MinimalGame.fromJson(game)),
            ],
            isLoading: false,
          ),
        },
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

class SearchState {
  final List<MinimalGame> games;
  final bool isLoading;
  final String? error;

  SearchState({
    required this.games,
    required this.isLoading,
    this.error,
  });

  factory SearchState.initial() {
    return SearchState(
      games: [],
      isLoading: false,
      error: null,
    );
  }

  SearchState copyWith({
    List<MinimalGame>? games,
    bool? isLoading,
    String? error,
  }) {
    return SearchState(
      games: games ?? this.games,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
