"use strict";

const readline = require("readline");
const eshop = require("./src/eshop.js");
const table = require("console.table"); //eslint-disable-line no-unused-vars


(function() {
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout
    });

    showMenu();
    rl.setPrompt("Eshop: ");
    rl.prompt();

    rl.on("close", process.exit);
    rl.on("line", async (line) => {
        line = line.trim();
        let lineArray = line.split(" ");

        switch (lineArray[0]) {
            case "quit":
            case "exit":
                eshop.dbclose();
                process.exit();
                break;
            case "menu":
            case "help":
                showMenu();
                break;
            case "log":
                console.table(await eshop.showlog(lineArray[1]));
                break;
            case "shelf":
                console.table(await eshop.showShelf());
                break;
            case "inventory":
                console.table(await eshop.showInventory(lineArray[1]));
                break;
            case "invadd":
                await eshop.addAProductToShelf(lineArray[1], lineArray[2], lineArray[3]);
                console.info(
                    `\nYou have added ${lineArray[3]} products with id` +
                    ` ${lineArray[1]} to shelf ${lineArray[2]}\n` +
                    `(tpye "inventory" to check).`
                );
                break;
            case "invdel":
                await eshop.deleteAProductFromShelf(lineArray[1], lineArray[2], lineArray[3]);
                console.info(
                    `\nYou have removed ${lineArray[3]} products of type ` +
                    `${lineArray[1]} from shelf ${lineArray[2]}.\n` +
                    `(type "inventory" to check).`
                );
                break;
            default:
                console.info("I don't know that command, enter menu or help");
                break;
        }
        rl.prompt();
    });
})();

function showMenu() {
    console.info(
        `\nChoose one of the following commands: \n` +
        `-> exit, quit: Exits the program.\n` +
        `-> help, menu: Show menu.\n` +
        `-> log <number>: Shows the number of latest rows in logg.\n` +
        `-> shelf: Shows which storgae shelves are in the warehouse.\n` +
        `-> inventory: Shows a table of which products are in stock and their info & location.\n` +
        `-> inventory <str>: Shows list of selected products (enter id, name or shelf).\n` +
        `-> invadd <productid> <shelf> <number>:Add products to shelf.\n` +
        `-> invdel <productid> <shelf> <number>: Delete a product from shelf.\n\n`
    );
}
