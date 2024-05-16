class MinimalGame {
  name: string;
  date: string;
  cover: string;
  platforms: string;

  constructor(
    name = "",
    date = "",
    cover = "",
    platforms = "",
  ) {
    this.name = name;
    this.date = date;
    this.cover = cover;
    this.platforms = platforms;
  }
}

export = MinimalGame;
