import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upcoming_games/models/minimal_game.dart';
import 'package:upcoming_games/provider/wishlist_provider.dart';

import '../app_router.dart';

class GameCard extends ConsumerWidget {
  final MinimalGame game;

  const GameCard(this.game, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = AutoRouter.of(context);
    final isWishlisted = ref.watch(wishlistProvider).contains(game.id);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        splashColor: Colors.teal,
        focusColor: Colors.teal,
        highlightColor: Colors.teal,
        hoverColor: Colors.teal,
        onTap: () {
          router.push(DetailsRoute(minimalGame: game));
        },
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 3 / 4,
              child: CachedNetworkImage(
                imageUrl: game.cover,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                icon:
                    Icon(isWishlisted ? Icons.favorite : Icons.favorite_border),
                color: Colors.white,
                onPressed: () {
                  isWishlisted
                      ? ref
                          .read(wishlistProvider.notifier)
                          .removeFromWishlist(game.id)
                      : ref
                          .read(wishlistProvider.notifier)
                          .addToWishlist(game.id);
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                  ),
                ),
                child: Text(
                  game.date,
                  style: const TextStyle(
                    backgroundColor: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
