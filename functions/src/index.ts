/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import * as functions from "firebase-functions";
import Game = require("./models/game");

export const fetchGames = functions.region("europe-west1").https
  .onRequest((request, response) => {
    const games: Game[] = [dummyGame, dummyGame, dummyGame];
    response.json(games);
  });

const dummyGame: Game = new Game(0, "Dummy Game",
  "2024-01-01",
  "https://miro.medium.com/fit/c/176/176/1*8oa-e4oHBmsthYpHy5DzJw.png",
  "PC, PS5, Xbox Series X",
  0,
  "Some description",
  "https://example.com",
  [
    "https://miro.medium.com/fit/c/176/176/1*8oa-e4oHBmsthYpHy5DzJw.png",
  ]);
