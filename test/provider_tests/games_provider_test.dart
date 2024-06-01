import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:upcoming_games/models/minimal_game.dart';
import 'package:upcoming_games/provider/games_provider.dart';

import 'games_provider_test.mocks.dart';

@GenerateMocks([
  FirebaseFunctions,
  HttpsCallable,
  HttpsCallableResult,
])
void main() {
  late MockFirebaseFunctions mockFunctions;
  late MockHttpsCallable mockCallableFetchGames;
  late MockHttpsCallable mockCallableFetchGameDetails;
  late GamesNotifier gamesNotifier;

  setUp(() {
    mockFunctions = MockFirebaseFunctions();
    mockCallableFetchGames = MockHttpsCallable();
    mockCallableFetchGameDetails = MockHttpsCallable();

    when(
      mockFunctions.httpsCallableFromUrl(
        "https://europe-west1-upcominggamesapp.cloudfunctions.net/fetchGames",
      ),
    ).thenReturn(mockCallableFetchGames);

    when(
      mockFunctions.httpsCallableFromUrl(
        "https://europe-west1-upcominggamesapp.cloudfunctions.net/fetchGameDetails",
      ),
    ).thenReturn(mockCallableFetchGameDetails);

    gamesNotifier = GamesNotifier(firebaseFunctions: mockFunctions);
  });

  group('GamesNotifier', () {
    test('initial state should be correct', () {
      expect(gamesNotifier.state.games, isEmpty);
      expect(gamesNotifier.state.isLoading, false);
    });

    test('loadGames updates state with fetched games', () async {
      const gamesData = [
        {
          'id': 1,
          'name': 'Game 1',
          'date': '2022-01-01',
          'cover': 'cover',
          'platforms': 'platforms',
        },
        {
          'id': 2,
          'name': 'Game 2',
          'date': '2022-01-02',
          'cover': 'cover',
          'platforms': 'platforms',
        },
      ];

      final mockResult = MockHttpsCallableResult();
      when(mockResult.data).thenReturn(gamesData);
      when(mockCallableFetchGames.call(any))
          .thenAnswer((_) async => mockResult);

      await gamesNotifier.loadGames();

      verify(mockCallableFetchGames.call(any)).called(1);
      verify(mockResult.data).called(1);

      expect(
        gamesNotifier.state.games[0].name,
        MinimalGame.fromJson(gamesData[0]).name,
      );
      expect(
        gamesNotifier.state.games[1].name,
        MinimalGame.fromJson(gamesData[1]).name,
      );
      expect(gamesNotifier.state.games.length, 2);
    });

    test('loadGameById updates state with fetched game details', () async {
      const gameData = {
        'id': 1,
        'name': 'Detailed Game 1',
        'date': '2022-01-01',
        'cover': 'cover',
        'platforms': 'platforms',
        'description': 'description',
        'website': 'website',
        'screenshots': ['screenshot1', 'screenshot2'],
      };
      final mockResult = MockHttpsCallableResult();
      when(mockResult.data).thenReturn(gameData);
      when(mockCallableFetchGameDetails.call(any))
          .thenAnswer((_) async => mockResult);

      await gamesNotifier.loadGameById(1);

      expect(gamesNotifier.state.selectedGame?.name, gameData['name']);
      expect(gamesNotifier.state.loadedGames[0].name, gameData['name']);
    });
  });
}
