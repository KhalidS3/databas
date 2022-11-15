/**
 * @author Khhalid Safi (khsa16)
 * 2021-03-24
 */
"use strict";

const express = require("express");
const router = express.Router();

const bodyParser = require("body-parser");
const urlencodedParser = bodyParser.urlencoded({ extended: false });

const searchInfo = require("../src/search.js");
const medlem = require("../src/medlem.js");
const siteNme = "| Hundklubben";

router.get("/", async (req, res) => {
    let data = {
        title: `Search ${siteNme}`
    };

    if (req.query.search == null) {
        data.searches = await medlem.VisaMedlemsAllaInfo();
    } else {
        data.searches = await searchInfo.searchInfo(req.query.search);
    }

    res.render("search/show-search", data);
});

router.post("/", urlencodedParser, async (req, res) => {
    await searchInfo.searchSpelning(req.body.search);

    res.redirect("/exam/search/show-search" + req.body.search);
});

module.exports = router;
