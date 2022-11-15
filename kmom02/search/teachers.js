/**
 * Create a connection to the database and execute
 * a query without actually using the database.
 * Use a config.json for the connection details.
 */
"use strict";

const mysql = require("promise-mysql");
const config = require("./config.json");

/**
 * Show teachers and their departments.
 * @async
 * @returns void
 */
(async function() {
    const db = await mysql.createConnection(config);
    let sql;
    let res;

    sql = `
        SELECT
            akronym,
            fornamn,
            efternamn,
            avdelning
        FROM larare
        ORDER BY akronym;
    `;
    res = await db.query(sql);

    console.info(res);

    db.end();
})();
