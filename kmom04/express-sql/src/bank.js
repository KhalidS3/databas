/**
 * A module exporting functions to access the bank database.
 */
"use strict";

module.exports = {
    showBalance: showBalance,
    transferMoney: transferMoney,
};

const mysql = require("promise-mysql");
const config = require("../config/db/bank.json");
let db;



/**
 * Main function.
 * @async
 * @returns void
 */
(async function () {
    db = await mysql.createConnection(config);

    process.on("exit", () => {
        db.end();
    });
}) ();



async function showBalance(table) {
    let sql;
    let res;

    sql = `SELECT * FROM ??;`;

    res = await db.query(sql, [table]);
    //console.info(res);

    return res;
}

/**
 * Show all entries in the selected table.
 *
 * @async
 * @param {string} table A valid table name.
 *
 * @returns {RowDataPacket} Resultset from the query,

async function findAllInTable(table) {
    let sql;
    let res;

    sql = `SELECT * FROM ??;`;

    res = await db.query(sql, [table]);
    console.info(`SQL: ${sql} (${table}) got ${res.length} rows.`);

    return res;
}
 */

async function transferMoney(from, to, amount) {
    let res;
    let sql;

    sql = `START TRANSACTION;

                UPDATE account
                SET
                    balance = balance - ?
                WHERE
                    id = ?;

                UPDATE account
                SET
                    balance = balance + ?
                WHERE
                    id = ?;

                COMMIT;

                SELECT * FROM account;
                `;

    res = await db.query(sql, [amount, from, amount, to]);
    //console.info(res);

    return res;
}
