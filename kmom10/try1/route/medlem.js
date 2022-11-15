/**
 * @author Khhalid Safi (khsa16)
 * 2021-03-23
 */
"use strict";

const express = require("express");
const router = express.Router();

const medlem = require("../src/medlem.js");
const enHund = require("../src/hund.js");
const siteName = "| Hundklubben";

router.get("/", async (req, res) => {
    let data = {
        title: `Visa medlem info ${siteName}`
    };

    data.infos = await medlem.VisaMedlemsAllaInfo();

    res.render("medlem/show", data);
});

router.get("/show/:hundNamn", async (req, res) => {
    let hundNamn = req.params.hundNamn;
    let data = {
        title: `Visa hund ${siteName}`
    };

    data.hund = await enHund.VisaHunden(hundNamn);

    res.render("medlem/show_dog", data);
});

module.exports = router;
