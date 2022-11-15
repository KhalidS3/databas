/**
 * @author Khalid Safi
 *
 * route for custormer
 */
"use strict";

const express = require("express");
const router = express.Router();

//const customer = require("../src/customer.js");
const customer = require("../src/custormer.js");

router.get("/", async (req, res) => {
    let data = {
        title: `Kunder | E-shop`
    };

    data.customers = await customer.showCustomers();
    res.render("customer/all-customers", data);
});

module.exports = router;
