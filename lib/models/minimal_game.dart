import 'game.dart';

class MinimalGame {
  int id;
  String name;
  String date;
  String cover;
  String platforms;

  MinimalGame({
    this.id = 0,
    this.name = "",
    this.date = "",
    this.cover = "",
    this.platforms = "",
  });

  MinimalGame.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        name = json['name'],
        date = json['date'],
        cover = json['cover'],
        platforms = json['platforms'];

  MinimalGame.fromGame(Game game)
      : id = game.id,
        name = game.name,
        date = game.date,
        cover = game.cover,
        platforms = game.platforms;
}
