/**
 * @author Khalid Safi
 *
 * route for custormer
 */
"use strict";

const bodyParser = require("body-parser");
const express = require("express");
const router = express.Router();
const urlencodedParser = bodyParser.urlencoded({ extended: false });

const log = require("../src/log.js");

const siteName = "| E-shop";

router.get("/", async (req, res) => {
    let data = {
        title: `Logs ${siteName}`
    };

    if (req.query.search == null) {
        data.logs = await log.showLogs();
    } else {
        data.logs = await log.searchLog(req.query.search);
    }

    res.render("log/show", data);
});

router.post("/log", urlencodedParser, async (req, res) => {
    await log.searchLog(req.body.search);

    res.redirect("/eshop/log/show/" + req.body.search);
});

module.exports = router;
