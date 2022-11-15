"use strict";

const config = require("../config/db/bank.json");
const mysql = require("promise-mysql");
// const utils = require("./bank.js");

let db;

(async function() {
    db = await mysql.createConnection(config);
})();


const trans = {
    dbclose: function() {
        db.end();
    },
    // move: async function(fromAccount, toAccount, amount) {
    //     let str;

    //     str = await utils.transferMoney(db, fromAccount, toAccount, amount);
    //     console.info(str);
    // }

};

module.exports = trans;
