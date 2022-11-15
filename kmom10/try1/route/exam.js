/**
 * @author Khalid Safi
 * 2021-03-24
 */
"use strict";

const express = require("express");
const router = express.Router();

const siteName = "| Hundklubben";

const routeMedlem = require("./medlem.js");
const routeSearch = require("./search.js");

router.use("/medlem", routeMedlem);
router.use("/search", routeSearch);

router.get("/index", (req, res) => {
    let data = {
        title: `Index ${siteName}`
    };

    res.render("index", data);
});

module.exports = router;
