/**
 * @author Khalid Safi
 * Module for exporting fucntions to access eshop database
 */
"use strict";

module.exports = {
    showRowsInLog: showRowsInLog,
    showShelfs: showShelfs,
    showInventory: showInventory,
    showOrder: showOrder,
    addProductToShelf: addProductToShelf,
    deleteProductFromShelf: deleteProductFromShelf,
    pickList: pickList,
    showMenu: showMenu
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

async function showRowsInLog(number) {
    let sql = `CALL show_logg(?);`;
    let res;

    res = await db.query(sql, [number]);
    return res[0];
}

async function showShelfs() {
    let sql = `CALL show_shelfs();`;
    let res;

    res = await db.query(sql);
    return res[0];
}

async function showInventory(str) {
    let sql;
    let res;

    if (str) {
        sql = `CALL show_selected_inventory(?);`;

        res = await db.query(sql, [str]);
    } else {
        sql = `CALL show_inventory();`;

        res = await db.query(sql);
    }

    return res[0];
}

async function showOrder(str) {
    let sql;
    let res;

    if (str) {
        sql = `CALL show_selected_orders(?);`;

        res = await db.query(sql, [str]);
    } else {
        sql = `CALL show_orders();`;

        res = await db.query(sql);
    }

    return res[0];
}

async function addProductToShelf(productid, shelf, number) {
    let sql = `CALL add_product_to_shelf(?, ?, ?);`;

    await db.query(sql, [productid, shelf, number]);
}

async function deleteProductFromShelf(productid, shelf, number) {
    let sql = `CALL delete_product_from_shelf(?, ?, ?);`;

    await db.query(sql, [productid, shelf, number]);
}

async function pickList(orderid) {
    let sql = `CALL picklist(?);`;
    let res = await db.query(sql, [orderid]);

    return res[0];
}

function showMenu() {
    console.info(
        `\nPlease choose one of the following commands:.\n` +
        `- exit, quit: Exits the program.\n` +
        `- help, menu: Shows menu.\n` +
        `- log <number>: Shows the number of latest rows in logg.\n` +
        `- shelf: Lists the shelfs.\n` +
        `- inventory: Shows a table of which products are in stock and their info & location\n` +
        `- inventory <str>: Shows list of selected products (enter id, name or shelf)\n` +
        `- invadd <productid> <shelf> <number>: To add products to shelf.\n` +
        `- invdel <productid> <shelf> <number>: TO delete products from shelf.\n` +
        `- order: Shows all orders.\n` +
        `- order <search>: Shows orders with matching customer_id or order_id.\n` +
        `- picklist <orderid>: Picklist for chosen order.\n` +
        `- ship <orderid>: Changes status to "Skickad".\n` +
        `- delete <orderid>: Soft delete on spec order (changes status to "Raderad".).\n` +
        `- undodel <orderid>: Reverse deleted status to previous state.\n` +
        `- about: Who made this?`
    );
}
