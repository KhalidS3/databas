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
    VisaMedlemsAllaInfo: VisaMedlemsAllaInfo
};

(async function() {
    db = await mysql.createConnection(config);

    process.on("exit", () => {
        db.end();
    });
})();

async function VisaMedlemsAllaInfo() {
    let sql;
    let res;

    sql = `CALL visa_medlems_alla_info();`;

    res = await db.query(sql);

    return res[0];
}
