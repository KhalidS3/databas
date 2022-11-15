/**
 * @author Khhalid Safi (khsa16)
 * 2021-03-23
 */
"use strict";

const express = require("express");
const router = express.Router();

const spelning = require("../src/spelning.js");
const siteName = "| Rock Festival";

router.get("/", async (req, res) => {
    let data = {
        title: `Visa Spelning ${siteName}`
    };

    data.infos = await spelning.showArtistsInfo();

    res.render("spelning/show-spelning", data);
});

module.exports = router;
