"use strict";

module.exports = {
    createOrderRow: createOrderRow,
    showOrderRows: showOrderRows
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

async function createOrderRow(orderid, produktid, antal) {
    let sql = `CALL create_an_order_row(?, ?, ?);`;

    await db.query(sql, [orderid, produktid, antal]);
}

async function showOrderRows(orderid) {
    let sql = `CALL show_an_order_row(?);`;
    let res;

    res = await db.query(sql, [orderid]);
    return res[0];
}
