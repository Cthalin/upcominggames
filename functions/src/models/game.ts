class Game {
  id: number;
  name: string;
  date: string;
  cover: string;
  platforms: string;
  description: string;
  website: string;
  screenshots: string[];

  constructor(
    id = 0,
    name = "",
    date = "",
    cover = "",
    platforms = "",
    description = "",
    website = "",
    screenshots: string[] = []
  ) {
    this.id = id;
    this.name = name;
    this.date = date;
    this.cover = cover;
    this.platforms = platforms;
    this.description = description;
    this.website = website;
    this.screenshots = screenshots;
  }
}

export = Game;
