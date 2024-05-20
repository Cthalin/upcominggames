import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:upcoming_games/provider/games_provider.dart';
import 'package:upcoming_games/provider/wishlist_provider.dart';

import 'game_card.dart';

class Wishlist extends ConsumerStatefulWidget {
  final ScrollController controller;

  const Wishlist({required this.controller, super.key});

  @override
  ConsumerState<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends ConsumerState<Wishlist> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(wishlistProvider.notifier).loadWishlist().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final wishlistIds = ref.watch(wishlistProvider);
    final games = wishlistIds
        .map(
          (e) => ref.watch(gamesProvider.notifier).getGameById(e),
        )
        .toList();
    return Expanded(
      child: isLoading
          ? Center(
              child: Lottie.asset('assets/animations/loading.json'),
            )
          : GridView.builder(
              controller: widget.controller,
              itemCount: games.length,
              itemBuilder: (context, index) {
                return games[index] != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 6,
                        ),
                        child: GameCard(games[index]!),
                      )
                    : const SizedBox();
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3 / 4,
                crossAxisCount: 2,
              ),
            ),
    );
  }
}
