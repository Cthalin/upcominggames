import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:upcoming_games/app_router.dart';
import 'package:upcoming_games/models/game.dart';
import 'package:upcoming_games/theme.dart';

@RoutePage()
class DetailsPage extends StatelessWidget {
  final Game game;

  const DetailsPage({required this.game}) : super(key: null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Image.network(game.bg),
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
                                style: Theme.of(context).textTheme.bodyMedium,
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
                                "Website: ${game.website}",
                                style: Theme.of(context).textTheme.bodySmall,
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
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      AutoRouter.of(context).push(
                                        ImageViewerRoute(
                                          image: game.screenshots[index],
                                        ),
                                      );
                                    },
                                    child: Hero(
                                      tag: "screenshot",
                                      child: Image.network(
                                        game.screenshots[index],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Text("Swipe for more"),
                            ],
                          ),
                        ),
                      ),
                    TextButton(
                      onPressed: () =>
                          // Get.toNamed('/image',
                          //     arguments: _.game.value.screenshots[0]),
                          {},
                      child: const Text("Show Screenshot"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
