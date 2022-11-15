/**
 * @author Khhalid Safi (khsa16)
 * 2021-03-23
 */
"use strict";

const express = require("express");
const router = express.Router();

const bodyParser = require("body-parser");
const urlencodedParser = bodyParser.urlencoded({ extended: false });

const searchSpelning = require("../src/search.js");
const spelning = require("../src/spelning.js");
const siteNme = "| Rock Festival";

router.get("/", async (req, res) => {
    let data = {
        title: `Search ${siteNme}`
    };

    if (req.query.search == null) {
        data.searches = await spelning.showArtistsInfo();
    } else {
        data.searches = await searchSpelning.searchSpelning(req.query.search);
    }

    res.render("search/show-search", data);
});

router.post("/", urlencodedParser, async (req, res) => {
    await searchSpelning.searchSpelning(req.body.search);

    res.redirect("/exam/search/show-search" + req.body.search);
});

module.exports = router;
