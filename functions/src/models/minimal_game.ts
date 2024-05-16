class MinimalGame {
  id: number;
  name: string;
  date: string;
  cover: string;
  platforms: string;

  constructor(
    id = 0,
    name = "",
    date = "",
    cover = "",
    platforms = "",
  ) {
    this.id = id;
    this.name = name;
    this.date = date;
    this.cover = cover;
    this.platforms = platforms;
  }
}

export = MinimalGame;
