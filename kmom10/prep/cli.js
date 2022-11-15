"use strict";

const readline = require("readline");
const exam = require("./src/exam.js");
const table = require("console.table"); //eslint-disable-line no-unused-vars

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

(function() {
    rl.on("close", process.exit);
    rl.on("line", handleInput);

    rl.setPrompt("Rock Festival: ");
    exam.showMenu();
    rl.prompt();
})();

async function handleInput(line) {
    line = line.trim();
    let lineArray = line.split(" ");

    switch (lineArray[0]) {
        case "exit":
        case "quit":
            process.exit();
            break;
        case "help":
        case "menu":
            exam.showMenu();
            break;
        case "visa":
            console.table(await exam.showArtistsInfo());
            break;
        case "search":
            console.table(await exam.searchSpelning(lineArray[1]));
            break;
        default:
            console.info("I don't know that command, enter 'menu' for a list of known commands.");
            break;
    }
    rl.prompt();
}
