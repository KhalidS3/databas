"use strict";

//Set port for server to run on
const port = process.env.DBWEBB_PORT || 1337;

const path = require("path");
const express = require("express");
const app = express();

const routeExam = require("./route/exam.js");
const middleware = require("./middleware/index.js");

app.set("view engine", "ejs");

app.use(middleware.logIncomingToConsole);

app.use(express.static(path.join(__dirname, "public")));

app.use("/exam", routeExam);
app.listen(port, logStartUpDetailsToConsole);

// Log app details to console when starting up.
function logStartUpDetailsToConsole() {
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
                if (route) {
                    routes.push(route);
                }
                // route && routes.push(route);
            });
        }
    });

    console.info(`Server is listening on port ${port}.`);
    console.info("Available routes are:");
    console.info(routes);
}