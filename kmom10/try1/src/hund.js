/**
 * @author Khalid Safi
 *
 * Call functions for medlem
 */
"use strict";

const mysql = require("promise-mysql");
const config = require("../config/db/exam.json");
let db;

module.exports = {
    VisaHunden: VisaHunden
};

(async function() {
    db = await mysql.createConnection(config);

    process.on("exit", () => {
        db.end();
    });
})();

async function VisaHunden(hundNamn) {
    let sql;
    let res;

    sql = `CALL visa_hunden(?);`;

    res = await db.query(sql, [hundNamn]);

    return res[0][0];
}
