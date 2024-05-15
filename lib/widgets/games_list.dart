import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/games_provider.dart';
import 'game_card.dart';

class GamesList extends ConsumerWidget {
  final ScrollController controller = ScrollController();

  GamesList({super.key});

  void toTop() {
    controller.animateTo(
      100,
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final games = ref.watch(gamesProvider);
    return Expanded(
      child: games.isEmpty
          ? const Center(
              child: CupertinoActivityIndicator(
                radius: 20,
              ),
            )
          : ListView.builder(
              controller: controller,
              itemCount: games.length,
              itemBuilder: (context, index) {
                return GameCard(games[index]);
              },
            ),
    );
  }
}
