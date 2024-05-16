import {logger} from "firebase-functions";

import axios from "axios";

import qs = require("qs");

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
      console.log(JSON.stringify(response.data));
      logger.info(JSON.stringify(response.data));
      return response.data["access_token"];
    })
    .catch(function (error: any) {
      console.log(error);
    });
}

let _fetchMinGameDetails = async (gameId: number) => {
  let token = await _getToken();
  console.log("TOKEN: " + token);
  const data = "fields *; where id = " + gameId + ";";

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
    .then(function (response: { data: any; }) {
      console.log(JSON.stringify(response.data));
      return response.data;
    })
    .catch(function (error: any) {
      console.log(error);
    });

}

export let fetchGamesAfterMs = async (milliseconds: number) => {
  logger.info("Fetching games after " + milliseconds + " milliseconds");
  let token = await _getToken();
  const data = "fields id; where date > 1715804265675; sort date asc;";

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
    .then(function (response: { data: any; }) {
      console.log(JSON.stringify(response.data));
      return _fetchMinGameDetails(response.data[0].id);
      return response.data;
    })
    .catch(function (error: any) {
      console.log(error);
    });
};

export let fetchGameDetails = async (gameId: number) => {
  logger.info("Fetching game details");
  return _fetchMinGameDetails(gameId);
};
