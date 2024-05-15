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
}
