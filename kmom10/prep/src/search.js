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
    searchSpelning: searchSpelning
};

(async function() {
    db = await mysql.createConnection(config);

    process.on("exit", () => {
        db.end();
    });
})();

async function searchSpelning(search) {
    let sql;
    let res;

    sql = `CALL search_spelning(?);`;

    res = await db.query(sql, [search]);

    return res[0];
}
