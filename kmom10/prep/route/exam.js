/**
 * @author Khalid Safi
 * 2021-03-23
 */
"use strict";

const express = require("express");
const router = express.Router();

const siteName = "| Rock Festival";

const routeSpelning = require("./spelning.js");
const routeSearch = require("./search.js");

router.use("/spelning", routeSpelning);
router.use("/search", routeSearch);

router.get("/index", (req, res) => {
    let data = {
        title: `Index ${siteName}`
    };

    res.render("index", data);
});

module.exports = router;
