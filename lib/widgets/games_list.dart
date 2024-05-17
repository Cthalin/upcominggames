import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upcoming_games/provider/games_provider.dart';

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
    final games = ref.watch(gamesProvider).games;
    final isLoading = ref.watch(gamesProvider).isLoading;
    return Expanded(
      child: isLoading
          ? const Center(
              child: CupertinoActivityIndicator(
                radius: 20,
              ),
            )
          : GridView.builder(
              controller: widget.controller,
              itemCount: games.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  child: GameCard(games[index]),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3 / 4,
                crossAxisCount:
                    2, // This specifies the number of items in a row
              ),
            ),
    );
  }
}
