class Game {
  id: number;
  name: string;
  date: string;
  bg: string;
  platforms: string;
  rating: number;
  description: string;
  website: string;
  screenshots: string[];

  constructor(
    id = 0,
    name = "",
    date = "",
    bg = "",
    platforms = "",
    rating = 0,
    description = "",
    website = "",
    screenshots: string[] = []
  ) {
    this.id = id;
    this.name = name;
    this.date = date;
    this.bg = bg;
    this.platforms = platforms;
    this.rating = rating;
    this.description = description;
    this.website = website;
    this.screenshots = screenshots;
  }
}

export = Game;
