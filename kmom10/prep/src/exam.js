/**
 * @author Khalid Safi (khsa16)
 * 2021-03-23
 *
 * A module exporting function
 */
"use strict";

module.exports = {
    showMenu: showMenu,
    showArtistsInfo: showArtistsInfo,
    searchSpelning: searchSpelning
};

const mysql = require("promise-mysql");
const config = require("../config/db/exam.json");
let db;

(async function() {
    db = await mysql.createConnection(config);

    process.on("exit", () => {
        db.end();
    });
})();

function showMenu() {
    console.info(
        `\nVälja nåtgot av följande från listan:\n` +
        `--> exit, quit: Stänger programmet.\n` +
        `--> menu: Visar meny.\n` +
        `--> visa: Visa spelningstable.\n` +
        `--> search <str>: Visar filterade logglistan\n` +
        `--> person: Visar chefens special tabell.`
    );
}

async function showArtistsInfo() {
    let sql;
    let res;

    sql = `CALL show_artists_info();`;

    res = await db.query(sql);

    return res[0];
}

async function searchSpelning(search) {
    let sql;
    let res;

    sql = `CALL search_spelning(?);`;

    res = await db.query(sql, [search]);

    return res[0];
}
