/**
 * @author Khalid Safi
 *
 * Call functions for spelning
 */
"use strict";

const mysql = require("promise-mysql");
const config = require("../config/db/exam.json");
let db;

module.exports = {
    showArtistsInfo: showArtistsInfo
};

(async function() {
    db = await mysql.createConnection(config);

    process.on("exit", () => {
        db.end();
    });
})();

async function showArtistsInfo() {
    let sql;
    let res;

    sql = `CALL show_artists_info();`;

    res = await db.query(sql);

    return res[0];
}
