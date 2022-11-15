"use strict";

module.exports = {
    showProducts: showProducts,
    showProduct: showProduct,
    createProduct: createProduct,
    deleteProduct: deleteProduct,
    editProduct: editProduct
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

async function showProducts() {
    let sql = `CALL show_products();`;
    let res;

    res = await db.query(sql);

    return res[0];
}

async function showProduct(produktid) {
    let sql = `CALL show_product(?);`;
    let res;

    res = await db.query(sql, [produktid]);

    return res[0][0];
}

async function createProduct(produktid, pris, namn, bildlank, beskrivning) {
    let sql = `CALL create_product(?, ?, ?, ?, ?);`;

    await db.query(sql, [produktid, pris, namn, bildlank, beskrivning]);
}

async function deleteProduct(produktid) {
    let sql = `CALL delete_product(?);`;

    await db.query(sql, [produktid]);
}

async function editProduct(produktid, pris, namn, bildlank, beskrivning) {
    let sql = `CALL edit_product(?, ?, ?, ?, ?);`;

    await db.query(sql, [produktid, pris, namn, bildlank, beskrivning]);
}
