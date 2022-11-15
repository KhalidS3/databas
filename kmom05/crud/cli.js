"use strict";

const bank = require("./src/transaction.js");
const banks = require("./src/bank.js");
const Ttable = require("console.table"); // eslint-disable-line no-unused-vars
const readline = require("readline");

(function() {
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout
    });

    showMenu();
    rl.setPrompt("MegaBank: ");
    rl.prompt();

    rl.on("close", process.exit);
    rl.on("line", async (line) => {
        line = line.trim();
        let lineArray = line.split(" ");
        let str;

        switch (lineArray[0]) {
            case "quit":
            case "exit":
                bank.dbclose();
                process.exit();
                break;
            case "menu":
            case "help":
                showMenu();
                break;
            case "transfer":
                await banks.transferMoney("2222", "1111", 1.5);
                console.info("Transfer completed!!!");
                break;
            case "balance":
                str = await banks.showBalance("account");
                console.table(str);
                break;
            case "move":
                await banks.transferMoney(lineArray[1], lineArray[2], lineArray[3]);
                console.info("Transfer completed:-)");
                break;
            default:
                console.info("I don't know this command try againg!!!");
                break;
        }
        rl.prompt();
    });
})();

function showMenu() {
    console.info(
        `Please choose from the following commands: \n` +
        `exit, quit - to exit the program.\n` +
        `help, menu: Show the menu.\n` +
        `transfer: transfers 1.5 peng from Adam to Eva.\n` +
        `move: move <from> <to> <amount>
        Choose between Eva(2222) or Adam(1111) and amount 1.5 peng\n` +
        `balance: Shows the balance of accounts.\n\n`
    );
}
