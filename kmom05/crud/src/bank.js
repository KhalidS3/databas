/**
 * A module exporting functions to access the bank database.
 */
"use strict";

module.exports = {
    showBalance: showBalance,
    transferMoney: transferMoney,
    createAccount: createAccount,
    showAccount: showAccount,
    editAccount: editAccount,
    deleteAccount: deleteAccount,
};

const mysql = require("promise-mysql");
const config = require("../config/db/bank.json");
let db;



/**
 * Main function.
 * @async
 * @returns void
 */
(async function() {
    db = await mysql.createConnection(config);

    process.on("exit", () => {
        db.end();
    });
})();



async function showBalance() {
    let sql;
    let res;

    sql = `CALL show_balance;`;

    res = await db.query(sql);

    console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
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

/**
 * Create a new account
 *
 * @async
 * @param {string} id       A id of the account.
 * @param {string} name     The name of the account holder.
 * @param {string} balance  Initial amount in the account.
 *
 * @returns {void}
 */
async function createAccount(id, name, balance) {
    let sql;
    let res;

    sql = `CALL create_account(?, ?, ?);`;

    res = await db.query(sql, [id, name, balance]);
    // console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);
}

/**
 * Show details for an account.
 *
 * @async
 * @param {string} id A id of the account.
 *
 * @returns {RowDataPacket} Resultset from the query.
 */
async function showAccount(id) {
    let sql;
    let res;

    sql = `CALL show_account(?);`;

    res = await db.query(sql, [id]);
    //console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);

    return res[0];
}

/**
 * Edit details on an account.
 *
 * @async
 * @param {string} id      The id of the account to be updated.
 * @param {string} name    The updated name fo the account holder.
 * @param {string} balance The upated amount in the account.
 *
 * @returns {void}
 */
async function editAccount(id, name, balance) {
    let sql;
    let res;

    sql = `CALL edit_account(?, ?, ?);`;

    res = await db.query(sql, [id, name, balance]);
    // console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);
}

/**
 * Delete an account.
 *
 * @async
 * @param {string} id The id of the account
 *
 * @returns {void}
 */
async function deleteAccount(id) {
    let sql;
    let res;

    sql = `CALL delete_account(?);`;

    res = await db.query(sql, [id]);
    console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);
}
