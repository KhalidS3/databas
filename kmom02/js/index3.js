/**
 * A test program to show off async and await.
 *
 * @author Khalid Safi
 */
"use strict";

const fs = require("fs");
const path = "file.txt";
let data;

console.info("1) Program is starting up!");

data = fs.readFileSync(path, "utf-8");
console.info(data);

console.info("3) End of the program!");

/**
 * Return the content of the file, synced version which works.
 *
 * @param {string}  The path to the file to read.
 *
 * @returns {string} The content of the file.
 */
// function getFileContentSynce(filename) {
//     let data;

//     data = fs.readFileSync(filename, "utf-8");
//     return data;
// }
