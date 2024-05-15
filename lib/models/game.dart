class Game {
  num id;
  String name;
  String date;
  String bg;
  String platforms;
  double rating;
  String description;
  String website;
  List<String> screenshots;

  Game({
    this.id = 0,
    this.name = "",
    this.date = "",
    this.bg = "",
    this.platforms = "",
    this.rating = 0,
    this.description = "",
    this.website = "",
    List<String>? screenshots,
  }) : screenshots = screenshots ?? <String>[];

  Game.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'].toDouble(),
        name = json['name'],
        date = json['date'],
        bg = json['bg'],
        platforms = json['platforms'],
        rating = json['rating'].toDouble(),
        description = json['description'],
        website = json['website'],
        screenshots = List<String>.from(json['screenshots'] ?? []);
}
