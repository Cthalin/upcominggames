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
import {fetchGameDetails, fetchGamesAfterMs, searchGames} from "./igdb";

/**
 * Fetches a list of games from the IGDB API.
 *
 * This function is triggered by an HTTPS call and fetches a list of games from the IGDB API.
 * The games are fetched based on the current timestamp.
 *
 * Returns a Promise that completes when the games are fetched.
 */
exports.fetchGames = functions.region("europe-west1").https
  .onCall(async (data) => {
    const offset = data.offset ?? 0;
    logger.info("Fetching games");
    return await fetchGamesAfterMs(Math.floor(new Date().getTime() / 1000), offset);
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
  .onCall(async (data) => {
    const gameId = data.gameId;
    logger.info("Fetching game details for game ID: " + gameId);
    return await fetchGameDetails(gameId);
  });

/**
 * Searches for games in the IGDB API.
 *
 * This function is triggered by an HTTPS call and searches for games in the IGDB API.
 * The games are searched based on the search term provided in the data parameter.
 *
 * Returns a Promise that completes when the search is done and the results are fetched.
 */
exports.searchGames = functions.region("europe-west1").https
  .onCall(async (data) => {
    const searchTerm = data.searchTerm;
    logger.info("Searching for: " + searchTerm);
    return await searchGames(searchTerm);
  });
