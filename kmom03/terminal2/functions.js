/**
 * A collection of functions
 *
 * @author Khalid Safi
 */
"use strict";

module.exports = {
    "showTeachers": showTeachers,
    "showTeachersChangedComp": showTeachersChangedComp,
    "showTeachersDiffSalary": showTeachersDiffSalary,
    "searchForTeachersInfo": searchForTeachersInfo,
    "setNewSalary": setNewSalary
};

/**
 * Getting a report with teacher details, formatted as a text table.
 *
 * @async
 * @param {connection} db Database connection
 *
 * @returns {string} Formatted table to print out
 */
async function showTeachers(db) {
    let sql;
    let res;

    sql = `
        SELECT
            akronym,
            fornamn,
            efternamn,
            avdelning,
            kon,
            lon,
            DATE_FORMAT(fodd, "%Y-%m-%d") AS Fodd,
            kompetens,
            Ålder
        FROM v_larare
        ORDER BY
            akronym;
    `;
    res = await db.query(sql);

    return res;
}

/**
 * Get a teachers changed kompetens
 *
 * @async
 * @param {connection} db Databas connection
 *
 * @returns {string} Formatted table to print out
 */
async function showTeachersChangedComp(db) {
    let sql;
    let res;

    sql = `
        SELECT
        *
        FROM v_lonerevision
        ORDER BY
            akronym;
    `;
    res = await db.query(sql);

    return res;
}

/**
 * Get a teachers changed kompetens
 *
 * @async
 * @param {connection} db Databas connection
 *
 * @returns {string} Formatted table to print out
 */
async function showTeachersDiffSalary(db) {
    let sql;
    let res;

    sql = `
        SELECT
            akronym,
            fornamn,
            efternamn,
            pre,
            nu,
            diff,
            proc,
            mini
        FROM v_lonerevision
        ORDER BY
            fornamn;
    `;
    res = await db.query(sql);

    return res;
}

/**
 * Get a teachers changed kompetens
 *
 * @async
 * @param {connection} db     Databas connection
 * @param {string}     search String to search for
 *
 * @returns {string} Formatted table to print out
 */
async function searchForTeachersInfo(db, search) {
    let sql;
    let res;
    let like = `%${search}%`;

    sql = `
        SELECT
            akronym,
            fornamn,
            efternamn
        FROM larare
        WHERE
            akronym LIKE ?
            OR fornamn LIKE ?
            OR efternamn LIKE ?
        ORDER BY
            fornamn;
    `;
    res = await db.query(sql, [like, like, like]);

    return res;
}

function setNewSalary(db, acronym, search) {
    let sql;

    sql = `
        UPDATE larare
        SET
            lon = ${search}
        WHERE
            akronym = "${acronym}";
    `;
    db.query(sql);
}
