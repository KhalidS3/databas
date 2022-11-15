/**
 * Create a connection to the database and execute
 * a query without actually using the database.
 * Use a config.json for the connection details.
 */
"use strict";

const mysql = require("promise-mysql");
const config = require("./config.json");

// Read from commandline
const readline = require('readline');
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

// Promisify rl.question to question
const util = require("util");
//const { readFile } = require("fs");

rl.question[util.promisify.custom] = (arg) => {
    return new Promise((resolve) => {
        rl.question(arg, resolve);
    });
};
const question = util.promisify(rl.question);

/**
 * Main function
 *
 * @async
 * @returns void
 */
(async function() {
    const db = await mysql.createConnection(config);
    let str;
    let search;

    search = await question("What to search for?");
    str = await searchTeachers(db, search);
    console.info(str);

    rl.close();
    db.end();
})();

/**
 * Output resultset as formatted table with details on a teacher
 *
 * @async
 * @param {connection}  db     Database connection.
 * @param {string}      search String to search for.
 *
 * @returns {string}    Formatted table to print out.
 */
async function searchTeachers(db, search) {
    let sql;
    let res;
    let str;
    let like = `%${search}%`;

    console.info(`Searching for: ${search}`);

    sql = `
        SELECT
            akronym,
            fornamn,
            efternamn,
            avdelning,
            lon
        FROM larare
        WHERE
            akronym LIKE ?
            OR fornamn LIKE ?
            OR efternamn LIKE ?
            OR avdelning LIKE ?
            OR lon = ?
        ORDER BY akronym;
    `;
    res = await db.query(sql, [like, like, like, like, search]);
    str = teacherAsTable(res);
    return str;
}

/**
 * Get a report with teacher details, formated as a text table.
 *
 * @async
 * @param {connection} db   Database connection.
 *
 * @returns {string}   Formatted table to print out.
 */
// async function viewTeachers(db) {
//     let sql;
//     let res;
//     let str;

//     sql = `
//         SELECT
//             akronym,
//             fornamn,
//             efternamn,
//             avdelning,
//             lon
//         FROM larare
//         ORDER BY akronym;
//     `;
//     res = await db.query(sql);
//     str = teacherAsTable(res);
//     return str;
// }

/**
 * Output resultset as formatted table with details on teachers.
 *
 * @param {Array} res  Resultset with details on from database query.
 *
 * @returns {string}   Fromatted table to print out.
 */
function teacherAsTable(res) {
    let str;

    str = "+-----------+---------------------+-----------+----------+\n";
    str += "| Akronym   | Namn                | Avdelning |    Lön   |\n";
    str += "|-----------|---------------------|-----------|----------|\n";
    for (const row of res) {
        str += "| ";
        str += row.akronym.padEnd(10);
        str += "| ";
        str += (row.fornamn + " " + row.efternamn).padEnd(20);
        str += "| ";
        str += row.avdelning.padEnd(10);
        str += "| ";
        str += row.lon.toString().padStart(8);
        str += " |\n";
    }
    str += "+-----------+---------------------+-----------+----------+\n";

    return str;
}
