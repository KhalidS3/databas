/**
 * @author Khalid Safi
 * Call functions for category
 */
"use strict";

module.exports = {
    showCategory: showCategory,
    showCategory2Products: showCategory2Products
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

async function showCategory() {
    let sql = `CALL show_category();`;
    let res;

    res = await db.query(sql);
    return res[0];
}

async function showCategory2Products(produktid, kategori) {
    let sql;
    let res;

    sql = `CALL show_kategori_products(?, ?);`;

    res = await db.query(sql, [produktid, kategori]);
    console.log(res);

    return res[0];
}
