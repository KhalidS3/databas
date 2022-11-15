/**
 * Show teachers and their departements.
 *
 * @author Khalid Safi
 */
"use strict";

const mysql = require("promise-mysql");
const config = require("./config.json");
const utils = require("./functions.js");

/**
 * Main function
 *
 * @async
 *
 * @returns void
 */
(async function() {
    const db = await mysql.createConnection(config);
    let str;

    str = await utils.viewTeachers(db);
    console.info(str);

    db.end();
})();
