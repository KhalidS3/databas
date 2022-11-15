/**
 * @author Khalid Safi
 * Call functions for customer
 */
"use strict";

module.exports = {
    showCustomers: showCustomers
};

const mysql = require("promise-mysql");
const config = require("../config/db/eshop.json");
let db;

// Main function.
(async function() {
    db = await mysql.createConnection(config);

    process.on("exit", () => {
        db.end();
    });
})();

async function showCustomers() {
    let sql = `CALL show_all_customers();`;
    let res;

    res = await db.query(sql);
    return res[0];
}
