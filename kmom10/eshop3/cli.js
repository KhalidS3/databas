"use strict";

const readline = require("readline");
const eshop = require("./src/es.js");
const order = require("./src/order.js");
const table = require("console.table"); //eslint-disable-line no-unused-vars

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

(function() {
    rl.on("close", process.exit);
    rl.on("line", handleInput);

    rl.setPrompt("Eshop: ");
    eshop.showMenu();
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
            eshop.showMenu();
            break;
        case "log":
            console.table(await eshop.showRowsInLog(lineArray[1]));
            break;
        case "shelf":
            console.table(await eshop.showShelfs());
            break;
        case "inventory":
            console.table(await eshop.showInventory(lineArray[1]));
            break;
        case "invadd":
            await eshop.addProductToShelf(lineArray[1], lineArray[2], lineArray[3]);
            console.info(
                `\nYou have added ${lineArray[3]} products with id` +
                ` ${lineArray[1]} to shelf ${lineArray[2]}\n`
            );
            console.table(await eshop.showInventory());
            break;
        case "invdel":
            await eshop.deleteProductFromShelf(lineArray[1], lineArray[2], lineArray[3]);
            console.info(
                `\nYou have removed ${lineArray[3]} products of type` +
                ` ${lineArray[1]} from shelf ${lineArray[2]},\n` +
                `if there were enough.\n`
            );
            console.table(await eshop.showInventory());
            break;
        case "order":
            console.table(await eshop.showOrder(lineArray[1]));
            break;
        case "picklist":
            console.table(await eshop.pickList(lineArray[1]));
            break;
        case "ship":
            await order.setStatus(lineArray[1], "Skickad");
            console.info(
                `\nProduct(s) shipped successfully with id: ${lineArray[1]}.\n` +
                `Here are all orders:\n`
            );
            console.table(await eshop.showOrder());
            break;
        case "delete":
            await order.setStatus(lineArray[1], "Raderad");
            console.info(
                `\nYou have deleted the order via method soft delete with id: ${lineArray[1]}.\n` +
                `Here are all orders:\n`
            );
            console.table(await eshop.showOrder());
            break;
        case "undodel":
            await order.undoDelete(lineArray[1]);
            console.table(await eshop.showOrder());
            break;
        case "about":
            console.info(`\nKhalid Safi\n`);
            break;
        default:
            console.info("I don't know that command, enter 'menu' for a list of known commands.");
            break;
    }
    rl.prompt();
}
