import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/games_provider.dart';
import 'game_card.dart';

class GamesList extends ConsumerStatefulWidget {
  final ScrollController controller = ScrollController();

  GamesList({super.key});

  @override
  ConsumerState<GamesList> createState() => _GamesListState();
}

class _GamesListState extends ConsumerState<GamesList> {
  @override
  void initState() {
    super.initState();
    // ref.read(gamesProvider.notifier).loadGames();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gamesProvider.notifier).loadGames();
    });
  }

  void toTop() {
    widget.controller.animateTo(
      100,
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    // ref.read(gamesProvider.notifier).loadGames();
    final games = ref.watch(gamesProvider).games;
    final isLoading = ref.watch(gamesProvider).isLoading;
    return Expanded(
      child: isLoading
          ? const Center(
              child: CupertinoActivityIndicator(
                radius: 20,
              ),
            )
          : ListView.builder(
              controller: widget.controller,
              itemCount: games.length,
              itemBuilder: (context, index) {
                return GameCard(games[index]);
              },
            ),
    );
  }
}
