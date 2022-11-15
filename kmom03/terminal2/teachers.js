/**
 * Show teachers and their departements.
 *
 * @author Khalid Safi
 */
"use strict";

const config = require("./config.json");
const mysql = require("promise-mysql");
const utils = require("./functions.js");
const Table = require("console.table"); // eslint-disable-line no-unused-vars

let db;

(async function() {
    db = await mysql.createConnection(config);
})();

const teachers = {
    dbclose: function() {
        db.end();
    },

    larare: async function() {
        let str;

        str = await utils.showTeachers(db);
        console.log("Teachers general information");
        console.table(str);
    },

    kompetens: async function() {
        let str;

        str = await utils.showTeachersChangedComp(db);
        console.log("Changed competens");
        console.table(str);
    },

    lon: async function() {
        let res;

        res = await utils.showTeachersDiffSalary(db);
        console.table(res);
    },

    sok: async function(search) {
        let str;

        str = await utils.searchForTeachersInfo(db, search);
        console.table(str);
    },

    nylon: async function(acronym, search) {
        await utils.setNewSalary(db, acronym, search);
    }
};

module.exports = teachers;
