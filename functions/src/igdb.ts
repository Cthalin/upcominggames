import {logger} from "firebase-functions";

import axios from "axios";

import qs = require("qs");
import dotenv = require("dotenv");
import MinimalGame = require("./models/minimal_game");
import Game = require("./models/game");

// TODO cache token
const _getToken = async () => {
  dotenv.config();

  const data = qs.stringify({
    "client_id": process.env.CLIENT_ID,
    "client_secret": process.env.CLIENT_SECRET,
    "grant_type": "client_credentials",
  });

  const config = {
    method: "post",
    url: "https://id.twitch.tv/oauth2/token",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    data: data,
  };

  return axios(config)
    .then(function (response: { data: any; }) {
      return response.data["access_token"];
    })
    .catch(function (error: any) {
      console.log(error);
    });
};

function _mapMinimalGame(game: any) {
  return new MinimalGame(
    game.id,
    game.name,
    game.release_dates[0]?.human != null ? game.release_dates[0]?.human : "unknown",
    game.cover?.url != null ? `https:${game.cover.url}`.replace("thumb", "cover_big") : "",
    _formatPlatform(game.platforms),
  );
}

function _mapGame(game: any) {
  return new Game(
    game.id,
    game.name,
    game.release_dates[0].human,
    `https:${game.cover.url}`.replace("thumb", "cover_big"),
    _formatPlatform(game.platforms),
    game.summary,
    game.url,
    game.screenshots?.map((screenshot: any) =>
      `https:${screenshot.url}`.replace("thumb", "screenshot_big")) || [],
  );
}

export const fetchGamesAfterMs = async (seconds: number, offset: number) => {
  logger.info("Fetching games after " + seconds + " seconds");
  const token = await _getToken();
  const data = `fields date,game.name,game.platforms,
  game.cover.url,game.release_dates.human; where date > ${seconds} 
  & game.platforms = 6; sort date asc; limit 20; offset ${offset};`;

  const config = {
    method: "post",
    url: "https://api.igdb.com/v4/release_dates",
    headers: {
      "Content-Type": "text/plain",
      "Client-ID": "ivuffcyw4acdktkmf86716ylhlevs3",
      "Authorization": "Bearer " + token,
    },
    data: data,
  };

  return axios(config)
    .then(async function (response: { data: any; }) {
      const games: MinimalGame[] = [];
      for (const element of response.data) {
        games.push(_mapMinimalGame(element.game));
      }
      return games;
    })
    .catch(function (error: any) {
      console.log(error);
    });
};

export const fetchGameDetails = async (gameId: number) => {
  logger.info("Fetching game details for " + gameId);
  const token = await _getToken();
  const data = "fields name,platforms,cover.url,release_dates.human,summary,url," +
    "screenshots.url; where id = " + gameId + ";";

  const config = {
    method: "post",
    url: "https://api.igdb.com/v4/games",
    headers: {
      "Content-Type": "text/plain",
      "Client-ID": "ivuffcyw4acdktkmf86716ylhlevs3",
      "Authorization": "Bearer " + token,
    },
    data: data,
  };

  return axios(config)
    .then(async function (response: { data: any; }) {
      return _mapGame(response.data[0]);
    })
    .catch(function (error: any) {
      console.log(error);
      throw error;
    });
};

const _formatPlatform = (platforms: number[]) => {
  let platformString = "";
  platforms.forEach((platform) => {
    switch (platform) {
      case 6:
        platformString = platformString.concat(platformString ? ", PC" : "PC");
        break;
      case 167:
        platformString = platformString.concat(platformString ? ", PS5" : "PS5");
        break;
      case 169:
        platformString = platformString.concat(platformString ? ", Xbox Series X" : "Xbox Series X");
        break;
      default:
        break;
    }
  });
  return platformString;
};

export const searchGames = async (query: string) => {
  logger.info("Searching for games with query " + query);
  const token = await _getToken();
  const data = `fields game.name,game.platforms,game.cover.url,game.release_dates.human; search "${query}"; limit 50;`;

  const config = {
    method: "post",
    url: "https://api.igdb.com/v4/search",
    headers: {
      "Content-Type": "text/plain",
      "Client-ID": "ivuffcyw4acdktkmf86716ylhlevs3",
      "Authorization": "Bearer " + token,
    },
    data: data,
  };

  return axios(config)
    .then(async function (response: { data: any; }) {
      const games: MinimalGame[] = [];
      for (const element of response.data) {
        if (element.game != null &&
          element.game.platforms != null &&
          element.game.cover != null &&
          element.game.release_dates != null) {
          games.push(_mapMinimalGame(element.game));
        }
      }
      return games;
    })
    .catch(function (error: any) {
      console.log(error);
    });
};
