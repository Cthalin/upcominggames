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
    id: number = 0,
    name: string = "",
    date: string = "",
    bg: string = "",
    platforms: string = "",
    rating: number = 0,
    description: string = "",
    website: string = "",
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