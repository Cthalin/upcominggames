import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:upcoming_games/app_router.dart';
import 'package:upcoming_games/models/minimal_game.dart';
import 'package:upcoming_games/provider/games_provider.dart';
import 'package:upcoming_games/provider/wishlist_provider.dart';
import 'package:upcoming_games/theme.dart';

@RoutePage()
class DetailsPage extends ConsumerStatefulWidget {
  final MinimalGame minimalGame;

  const DetailsPage({required this.minimalGame}) : super(key: null);

  @override
  ConsumerState<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends ConsumerState<DetailsPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isLoading = true;
      });
      ref.read(gamesProvider.notifier).loadGameById(widget.minimalGame.id).then(
            (value) => setState(() {
              isLoading = false;
            }),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final game = ref.watch(gamesProvider).selectedGame;
    final wishlist = ref.watch(wishlistProvider);
    return game != null && !isLoading
        ? Scaffold(
            appBar: AppBar(
              title: Text(game.name),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(Spacing.m),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 300,
                                width: double.maxFinite,
                                child: CachedNetworkImage(imageUrl: game.cover),
                              ),
                              Positioned(
                                right: 0,
                                child: IconButton(
                                  icon: Icon(
                                    wishlist.contains(game.id)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                  ),
                                  onPressed: () {
                                    if (wishlist.contains(game.id)) {
                                      ref
                                          .read(wishlistProvider.notifier)
                                          .removeFromWishlist(game.id);
                                    } else {
                                      ref
                                          .read(wishlistProvider.notifier)
                                          .addToWishlist(game.id);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          Text(game.name),
                          Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(Spacing.m),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: Spacing.m,
                                    ),
                                    child: Text(
                                      game.description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                  HtmlWidget(
                                    game.description,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 5,
                            child: SizedBox(
                              // height: 100,
                              width: double.maxFinite,
                              child: Padding(
                                padding: const EdgeInsets.all(Spacing.m),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Website:",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(game.website),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (game.screenshots.isNotEmpty)
                            Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Screenshots",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 250,
                                      child: PageView.builder(
                                        scrollDirection: Axis.horizontal,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: game.screenshots.length,
                                        itemBuilder: (context, index) =>
                                            InkWell(
                                          onTap: () {
                                            AutoRouter.of(context).push(
                                              ImageViewerRoute(
                                                image: game.screenshots[index],
                                              ),
                                            );
                                          },
                                          child: Hero(
                                            tag: "screenshot",
                                            child: CachedNetworkImage(
                                              imageUrl: game.screenshots[index],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      "Swipe for more / Tap to enlarge",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Loading...'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
