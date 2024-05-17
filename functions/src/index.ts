/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import * as functions from "firebase-functions";
import {logger} from "firebase-functions";
import {fetchGameDetails, fetchGamesAfterMs} from "./igdb";

exports.fetchGames = functions.region("europe-west1").https
  .onCall(async () => {
    logger.info("Fetching games");
    return await fetchGamesAfterMs(Math.floor(new Date().getTime() / 1000));
  });

exports.fetchGameDetails = functions.region("europe-west1").https
  .onCall(async (data, context) => {
    const gameId = data.gameId;
    logger.info("Fetching game details for game ID: " + gameId);
    logger.warn("This is a warning message. " + data);
    return await fetchGameDetails(gameId);
  });
