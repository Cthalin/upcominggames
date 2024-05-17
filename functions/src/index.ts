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

/**
 * Fetches a list of games from the IGDB API.
 *
 * This function is triggered by an HTTPS call and fetches a list of games from the IGDB API.
 * The games are fetched based on the current timestamp.
 *
 * Returns a Promise that completes when the games are fetched.
 */
exports.fetchGames = functions.region("europe-west1").https
  .onCall(async () => {
    logger.info("Fetching games");
    return await fetchGamesAfterMs(Math.floor(new Date().getTime() / 1000));
  });

/**
 * Fetches the details of a specific game from the IGDB API.
 *
 * This function is triggered by an HTTPS call and fetches the details of a specific game from the IGDB API.
 * The game details are fetched based on the game ID provided in the data parameter.
 *
 * Returns a Promise that completes when the game details are fetched.
 */
exports.fetchGameDetails = functions.region("europe-west1").https
  .onCall(async (data, context) => {
    const gameId = data.gameId;
    logger.info("Fetching game details for game ID: " + gameId);
    logger.warn("This is a warning message. " + data);
    return await fetchGameDetails(gameId);
  });
