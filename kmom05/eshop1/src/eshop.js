"use strict";

const mysql = require("promise-mysql");
const config = require("../config/db/eshop.json");
let db;

module.exports = {
    showCategory: showCategory,
    showProducts: showProducts,
    showProduct: showProduct,
    createProduct: createProduct,
    editProduct: editProduct,
    deleteProduct: deleteProduct,
    showlog: showlog,
    showShelf: showShelf,
    showInventory: showInventory,
    addAProductToShelf: addAProductToShelf,
    deleteAProductFromShelf: deleteAProductFromShelf,
    showCategory2Products: showCategory2Products,
};

(async function() {
    db = await mysql.createConnection(config);

    process.on("exit", () => {
        db.end();
    });
})();

async function showCategory() {
    let sql;
    let res;

    sql = `CALL show_category();`;

    res = await db.query(sql);
    //console.log(res);

    return res;
}

async function showProducts() {
    let sql;
    let res;

    sql = `CALL show_products();`;

    res = await db.query(sql);
    //console.log(res);

    return res;
}

async function showProduct(produktId) {
    let sql;
    let res;

    sql = `CALL show_product(?);`;

    res = await db.query(sql, [produktId]);
    //console.log(res);

    return res;
}

async function createProduct(produktid, pris, namn, bildlank, beskrivning) {
    let sql;
    let res;

    sql = `CALL create_product(?, ?, ?, ?, ?);`;

    res = await db.query(sql, [produktid, pris, namn, bildlank, beskrivning]);
    //console.log(res);

    console.info(`SQL: ${sql} got ${res.length} rows.`);
}

async function editProduct(produktid, pris, namn, bildlank, beskrivning) {
    let sql;
    let res;

    sql = `CALL edit_product(?, ?, ?, ?, ?);`;

    res = await db.query(sql, [produktid, pris, namn, bildlank, beskrivning]);
    //console.log(res);

    console.info(`SQL: ${sql} got ${res.length} rows.`);
}

async function deleteProduct(produktid) {
    let sql;
    let res;

    sql = `CALL delete_product(?);`;

    res = await db.query(sql, [produktid]);
    //console.log(res);
    console.info(`SQL: ${sql} got ${res.length} rows.`);
}

async function showlog(number) {
    let sql;
    let res;

    sql = `CALL show_logg(?);`;

    res = await db.query(sql, [number]);

    return res[0];
}

async function showShelf() {
    let sql;
    let res;

    sql = `CALL show_shelfs();`;

    res = await db.query(sql);

    return res[0];
}

async function showInventory(str) {
    let sql;
    let res;

    if (str) {
        sql = `CALL show_a_selected_inventory(?);`;

        res = await db.query(sql, [str]);
    } else {
        sql = `CALL show_inventory();`;

        res = await db.query(sql);
    }

    return res[0];
}

async function addAProductToShelf(produkid, shelf, number) {
    let sql;

    sql = `CALL add_a_product_to_shelf(?, ?, ?);`;

    await db.query(sql, [produkid, shelf, number]);
}

async function deleteAProductFromShelf(produktid, shelf, number) {
    let sql;

    sql = `CALL delete_a_product_from_shelf(?, ?, ?);`;

    await db.query(sql, [produktid, shelf, number]);
}

async function showCategory2Products(produktid, kategori) {
    let sql;
    let res;

    sql = `CALL show_kategori_products(?, ?);`;

    res = await db.query(sql, [produktid, kategori]);
    console.log(res);

    return res;
}
