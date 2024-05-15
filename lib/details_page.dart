import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:upcoming_games/games_controller.dart';
import 'package:upcoming_games/theme.dart';

class DetailsPage extends StatelessWidget {
  Game game;
  DetailsPage({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Get.arguments[0].toString()),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      GetBuilder<GamesController>(
                          builder: (_) => (Column(children: [
                                Image.network(_.game.value.bg),
                                Text(_.game.value.name),
                                Card(
                                  elevation: 5,
                                  child: Padding(
                                      padding: const EdgeInsets.all(Spacing.m),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: Spacing.m),
                                              child: Text(
                                                game.description,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ),
                                            HtmlWidget(
                                                _.game.value.description),
                                          ])),
                                ),
                                Card(
                                    elevation: 5,
                                    child: Container(
                                        // height: 100,
                                        width: double.maxFinite,
                                        child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Website:",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                  Text(_.game.value.website)
                                                ])))),
                                if (_.game.value.screenshots != null &&
                                    _.game.value.screenshots.length > 0)
                                  Card(
                                    elevation: 5,
                                    child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Screenshots",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      decoration: TextDecoration
                                                          .underline)),
                                              Container(
                                                  height: 250,
                                                  child: PageView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      itemCount: _.game.value
                                                          .screenshots?.length,
                                                      itemBuilder: (context, index) => InkWell(
                                                          onTap: () => Get.toNamed('/image',
                                                              arguments: _.game.value.screenshots[
                                                                  index]),
                                                          child: Hero(
                                                              tag: "screenshot",
                                                              child: Image.network(_.game.value.screenshots[index]))))),
                                              Text("Swipe for more")
                                            ])),
                                  ),
                                TextButton(
                                    onPressed: () => Get.toNamed('/image',
                                        arguments: _.game.value.screenshots[0]),
                                    child: Text("Show Screenshot")),
                              ])))
                    ],
                  ))),
        ));
  }
}
