/**
 * Search after
 *
 * @author Khalid Safi
 */
"use strict";

const mysql = require("promise-mysql");
const config = require("./config.json");
const utils = require("./functions.js");

// Read from commandline
const readline = require("readline");
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});


/**
 * Main function.
 *
 * @async
 * @returns void
 */
(async function() {
    const db = await mysql.createConnection(config);
    let str;

    // Ask question and handle answer in async arrow function callback.
    rl.question("Enter minimum value? ", async (searchOne) => {
        rl.question("Enter maximum value?", async (searchTwo) => {
            str = await utils.searchBetweenTeachersValue(db, searchOne, searchTwo);
            console.info(str);

            rl.close();
            db.end();
        });
    });
})();
