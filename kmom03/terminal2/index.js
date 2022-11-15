"use strict";

const readline = require("readline");
const teachers = require("./teachers.js");

(function() {
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout
    });

    showMenu();
    rl.setPrompt("choose from menu: ");
    rl.prompt();

    rl.on("close", process.exit);
    rl.on("line", async (line) => {
        line = line.trim();
        let lineArray = line.split(" ");

        switch (lineArray[0]) {
            case "exit":
            case "quit":
                teachers.dbclose();
                process.exit();
                break;
            case "menu":
            case "help":
                showMenu();
                break;
            case "larare":
                await teachers.larare();
                break;
            case "kompetens":
                await teachers.kompetens();
                break;
            case "lon":
                await teachers.lon();
                break;
            case "sok":
                await teachers.sok(lineArray[1]);
                break;
            case "nylon":
                await teachers.nylon(lineArray[1], lineArray[2]);
                break;
            default:
                break;
        }
    });
})();

function showMenu() {
    console.info(
        `Choose one of the following commands: \n` +
        `exit, quit: Exits the program.\n` +
        `help, menu: Show the menu.\n` +
        `larare: Shows info about teachers.\n` +
        `kompetens: Shows info about competens after its change.\n` +
        `lon: Shows teachers salary atfer the diff.\n` +
        `sok <search string>: Search function.\n` +
        `nylon <akronym> <lon>: Search after teachers new salary.\n\n`
    );
}
