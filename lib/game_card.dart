import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'games_provider.dart';

class GameCard extends StatelessWidget {
  final Game game;

  GameCard(this.game);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        height: 250,
        width: double.maxFinite,
        child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
                splashColor: Colors.teal,
                focusColor: Colors.teal,
                highlightColor: Colors.teal,
                hoverColor: Colors.teal,
                onTap: () =>
                    Get.toNamed("/details", arguments: [game.name, game.id]),
                child: Column(children: [
                  game.bg != null
                      ? CachedNetworkImage(
                          imageUrl: game.bg,
                          imageBuilder: (context, imageProvider) => Container(
                            height: 160,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                            child: Align(
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10))),
                                  child: Text(
                                    '${game.date}',
                                    style: TextStyle(
                                        backgroundColor: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                              alignment: Alignment.topRight,
                            ),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        )
                      : Container(
                          height: 160,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/placeholder.jpeg'),
                                  fit: BoxFit.cover)),
                          child: Align(
                            child: Container(
                                padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10))),
                                child: Text(
                                  '${game.date}',
                                  style: TextStyle(
                                      backgroundColor: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                            alignment: Alignment.topRight,
                          ),
                        ),
                  Container(
                      child: ListTile(
                    title: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          '${game.name}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    subtitle: Text(
                      "${game.platforms}",
                    ),
                  )),
                ]))));
  }
}
