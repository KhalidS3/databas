/**
 * Route for today.
 */
"use strict";

let express = require("express");
let router = express.Router();

router.get("/", (req, res) => {
    let data = {};

    data.date = new Date();

    res.render("today", data);
});

module.exports = router;
