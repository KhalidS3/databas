/**
 * @author Khalid Safi
 * Call functions for logs
 */
"use strict";

module.exports = {
    showLogs: showLogs,
    searchLog: searchLog
};

const mysql = require("promise-mysql");
const config = require("../config/db/eshop.json");
let db;

/**
 * Main function
 */
(async function functionName() {
    db = await mysql.createConnection(config);

    process.on("exit", () => {
        db.end();
    });
})();

async function showLogs() {
    let sql;
    let res;

    sql = `CALL show_logg(20);`;

    res = await db.query(sql);
    return res[0];
}

async function searchLog(search) {
    let sql;
    let res;

    sql = `CALL search_log(?);`;

    res = await db.query(sql, [search]);

    console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}
