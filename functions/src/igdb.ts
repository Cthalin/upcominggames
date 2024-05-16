import {logger} from "firebase-functions";

import axios from "axios";

import qs = require("qs");
import MinimalGame = require("./models/minimal_game");

// TODO cache token
let _getToken = async () => {
  require('dotenv').config();

  const data = qs.stringify({
    'client_id': "ivuffcyw4acdktkmf86716ylhlevs3",
    'client_secret': process.env.CLIENT_SECRET,
    'grant_type': "client_credentials"
  });

  const config = {
    method: "post",
    url: "https://id.twitch.tv/oauth2/token",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    },
    data: data
  };

  return axios(config)
    .then(function (response: { data: any; }) {
      return response.data["access_token"];
    })
    .catch(function (error: any) {
      console.log(error);
    });
}

let _fetchMinGameDetails = async (gameId: number) => {
  let token = await _getToken();
  const data = "fields name,platforms,cover,first_release_date; where id = " + gameId + ";";

  const config = {
    method: "post",
    url: "https://api.igdb.com/v4/games",
    headers: {
      "Content-Type": "text/plain",
      "Client-ID": "ivuffcyw4acdktkmf86716ylhlevs3",
      "Authorization": "Bearer " + token,
    },
    data: data
  };

  return axios(config)
    .then(async function (response: { data: any; }) {
      return new MinimalGame(
        response.data[0].name,
        response.data[0].first_release_date,
        await _fetchCoverUrl(response.data[0].cover),
        _formatPlatform(response.data[0].platforms),
      );
    })
    .catch(function (error: any) {
      console.log(error);
      throw error;
    });

}

function _mapMinimalGame(game: any, date: any) {
  return new MinimalGame(game.name, game.release_dates[0].human, `https:${game.cover.url}`, _formatPlatform(game.platforms));
}

export let fetchGamesAfterMs = async (seconds: number) => {
  logger.info("Fetching games after " + seconds + " seconds");
  let token = await _getToken();
  const data = `fields date,game.name,game.platforms,game.cover.url,game.release_dates.human; where date > ${seconds} & game.platforms = 6; sort date asc;`;

  const config = {
    method: "post",
    url: "https://api.igdb.com/v4/release_dates",
    headers: {
      "Content-Type": "text/plain",
      "Client-ID": "ivuffcyw4acdktkmf86716ylhlevs3",
      "Authorization": "Bearer " + token,
    },
    data: data
  };

  return axios(config)
    .then(async function (response: { data: any; }) {
      let games: MinimalGame[] = [];
      for (const element of response.data) {
        games.push(_mapMinimalGame(element.game, element.date));
      }
      return games;
    })
    .catch(function (error: any) {
      console.log(error);
    });
};

export let fetchGameDetails = async (gameId: number) => {
  logger.info("Fetching game details for " + gameId);
  // TODO add details
  return _fetchMinGameDetails(gameId);
};

let _fetchCoverUrl = async (coverId: number) => {
  let token = await _getToken();
  const data = "fields url; where id = " + coverId + ";";

  const config = {
    method: "post",
    url: "https://api.igdb.com/v4/covers",
    headers: {
      "Content-Type": "text/plain",
      "Client-ID": "ivuffcyw4acdktkmf86716ylhlevs3",
      "Authorization": "Bearer " + token,
    },
    data: data
  };

  return axios(config)
    .then(function (response: { data: any; }) {
      return response.data[0].url;
    })
    .catch(function (error: any) {
      console.log(error);
    });
}

let _formatPlatform = (platforms: number[]) => {
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
}
