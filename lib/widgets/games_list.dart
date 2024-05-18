import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upcoming_games/provider/games_provider.dart';

import 'game_card.dart';

class GamesList extends ConsumerStatefulWidget {
  final ScrollController controller;

  const GamesList({required this.controller, super.key});

  @override
  ConsumerState<GamesList> createState() => _GamesListState();
}

class _GamesListState extends ConsumerState<GamesList> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gamesProvider.notifier).loadGames().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  _scrollListener() {
    if (widget.controller.position.pixels ==
        widget.controller.position.maxScrollExtent - 200) {
      ref.read(gamesProvider.notifier).loadMoreGames();
    }
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
                crossAxisCount: 2,
              ),
            ),
    );
  }
}
