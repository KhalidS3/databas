/**
 * General routes.
 */
"use strict";

let express = require('express');
let router = express.Router();

// Add a route for the path /
router.get('/', (req, res) => {
    res.send("Hello World!!!");
});

// Add a route for the path /about
router.get("/about", (req, res) => {
    res.send("About something ...");
});

module.exports = router;
