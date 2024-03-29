/**
 * A sample Express server.
 */
"use strict";

// Enable sever to run on port selected by the user selected
// environment variable DBWEBB_PORT
const port = process.env.DBWEBB_PORT || 1337;

// Set up Express server
const express = require("express");
const app = express();

const routeIndex = require("./route/index.js");
const middleware = require("./middleware/index.js");
const routeToday = require("./route/today.js");
const routeBank = require("./route/bank.js");
const path = require("path");


app.set("view engine", "ejs");

app.use(middleware.logIncomingToConsole);
app.use(express.static(path.join(__dirname, "public")));
app.use("/", routeIndex);
app.use("/today", routeToday);
app.use("/bank", routeBank);
app.listen(port, logStartUpDetaulsToConsole);

/**
 * Log app details to console when starting up.
 *
 * @return {void}
 */
function logStartUpDetaulsToConsole() {
    let routes = [];

    // Find what routes are supported
    app._router.stack.forEach((middleware) => {
        if (middleware.route) {
            // Routes registered directly on the app
            routes.push(middleware.route);
        } else if (middleware.name === "router") {
            // Routes added as router middleware
            middleware.handle.stack.forEach((handler) => {
                let route;

                route = handler.route;
                //route && routes.push(route); // got warning
                if (route) {
                    routes.push(route);
                }
            });
        }
    });

    console.info(`Server is listening on port ${port}.`);
    console.info("Available routes are:");
    console.info(routes);
}
