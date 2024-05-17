class Game {
  int id;
  String name;
  String date;
  String cover;
  String platforms;
  String description;
  String website;
  List<String> screenshots;

  Game({
    this.id = 0,
    this.name = "",
    this.date = "",
    this.cover = "",
    this.platforms = "",
    this.description = "",
    this.website = "",
    List<String>? screenshots,
  }) : screenshots = screenshots ?? <String>[];

  Game.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        name = json['name'],
        date = json['date'],
        cover = json['cover'],
        platforms = json['platforms'],
        description = json['description'],
        website = json['website'],
        screenshots = List<String>.from(json['screenshots'] ?? []);
}
