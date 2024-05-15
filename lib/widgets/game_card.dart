import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:upcoming_games/models/game.dart';
import 'package:upcoming_games/theme.dart';

import '../app_router.dart';

class GameCard extends StatelessWidget {
  final Game game;

  const GameCard(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.m, Spacing.m, 0),
      width: double.maxFinite,
      child: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          splashColor: Colors.teal,
          focusColor: Colors.teal,
          highlightColor: Colors.teal,
          hoverColor: Colors.teal,
          onTap: () {
            router.push(DetailsRoute(game: game));
          },
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: game.bg,
                imageBuilder: (context, imageProvider) => Container(
                  height: 160,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
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
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              ListTile(
                title: Text(
                  game.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  game.platforms,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
