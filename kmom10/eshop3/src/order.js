"use strict";

module.exports = {
    showOrders: showOrders,
    createOrder: createOrder,
    showOrder: showOrder,
    setStatus: setStatus,
    undoDelete: undoDelete
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


async function showOrders() {
    let sql = `CALL show_orders();`;
    let res;

    res = await db.query(sql);
    return res[0];
}

async function createOrder(id) {
    let sql = `CALL create_an_order(?);`;

    await db.query(sql, [id]);
}

async function showOrder(id) {
    let sql = `CALL show_an_order(?);`;
    let res;

    res = await db.query(sql, [id]);
    return res[0][0];
}

async function setStatus(orderid, status) {
    let sql = `CALL set_order_status(?, ?);`;

    await db.query(sql, [orderid, status]);
}

async function undoDelete(orderid) {
    let sql = `CALL undo_deleted_order(?);`;

    await db.query(sql, [orderid]);
}
