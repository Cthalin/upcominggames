import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:upcoming_games/date_picker_controller.dart';

import 'game_card.dart';
import 'games_provider.dart';

class GamesList extends ConsumerWidget {
  final ScrollController controller = ScrollController();
  final DatePickerController dateController = Get.find();

  void toTop() {
    controller.animateTo(100,
        duration: const Duration(seconds: 1), curve: Curves.easeIn);
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
