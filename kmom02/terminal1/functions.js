/**
 * A collection of usefull functions
 *
 * @author Khalid Safi
 */
"use strict";

module.exports = {
    "viewTeachers": viewTeachers,
    // "teacherAsTable": teacherAsTable,
    "searchTeachers": searchTeachers,
    "searchBetweenTeachersValue": searchBetweenTeachersValue
};

/**
 * Get a report with teacher details, formatted as a text table.
 *
 * @async
 * @param {connection} db Database connection.
 *
 * @returns {string} Formatted table to print out.
 */
async function viewTeachers(db) {
    let sql;
    let res;
    let str;

    sql = `
        SELECT
            akronym,
            fornamn,
            efternamn,
            avdelning,
            lon,
            kompetens,
            fodd
        FROM larare
        ORDER BY akronym;
    `;
    res = await db.query(sql);
    str = teacherAsTable(res);
    return str;
}


/**
 * Output resultset as formatted table with details on a teacher.
 *
 * @async
 * @param {connection} db     Database connection.
 * @param {string}     search String to search for.
 *
 * @returns {string} Formatted table to print out.
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
            lon,
            kompetens,
            fodd
        FROM larare
        WHERE
            akronym LIKE ?
            OR fornamn LIKE ?
            OR efternamn LIKE ?
            OR avdelning LIKE ?
            OR lon = ?
            OR kompetens = ?
        ORDER BY akronym;
    `;
    res = await db.query(sql, [like, like, like, like, search, search]);
    str = teacherAsTable(res);
    return str;
}


/**
 * Output resultset as formatted table with details on a teacher.
 *
 * @async
 * @param {connection} db     Database connection.
 * @param {string}     search String to search for.
 *
 * @returns {string} Formatted table to print out.
 */
async function searchBetweenTeachersValue(db, searchOne, searchTwo) {
    let sql;
    let res;
    let str;

    console.info(`Searching for values between : ${searchOne} - ${searchTwo}`);

    sql = `
        SELECT
            akronym,
            fornamn,
            efternamn,
            avdelning,
            lon,
            kompetens,
            fodd
        FROM larare
        WHERE
            lon >= ?
            AND lon <= ?
            OR kompetens >= ?
            AND kompetens <= ?
            ORDER BY akronym;
    `;
    res = await db.query(sql, [searchOne, searchTwo, searchOne, searchTwo]);
    str = teacherAsTable(res);
    return str;
}



/**
 * Output resultset as formatted table with details on teachers.
 *
 * @param {Array} res Resultset with details on from database query.
 *
 * @returns {string} Formatted table to print out.
 */
function teacherAsTable(res) {
    let str;

    str = "+-----------+---------------------+-----------+---------+---------+------------+\n";
    str += "| Akronym   | Namn                | Avd       |   Lön   | Komp    | Född       |\n";
    str += "|-----------|---------------------|-----------|---------+---------+------------+\n";
    for (const row of res) {
        str += "| ";
        str += row.akronym.padEnd(10);
        str += "| ";
        str += (row.fornamn + " " + row.efternamn).padEnd(20);
        str += "| ";
        str += row.avdelning.padEnd(10);
        str += "| ";
        str += row.lon.toString().padStart(8);
        str += "| ";
        str += row.kompetens.toString().padStart(8);
        str += "| ";
        str += row.fodd.toISOString().substring(0, 10);
        str += " |\n";
    }
    str += "+-----------+---------------------+-----------+----------+---------+-----------+\n";

    return str;
}
