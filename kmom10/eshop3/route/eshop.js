/**
 * @author Khalid Safi
 *
 * route for eshop
 */

"use strict";

const express = require("express");
const router = express.Router();

const routeCategory = require("./category.js");
const routeProduct = require("./product.js");
const routeCustomer = require("./customer.js");
const routeOrder = require("./order.js");
const routeOrderRow = require("./order_row.js");
const routeLogs = require("./log.js");

router.use("/category", routeCategory);
router.use("/product", routeProduct);
router.use("/customer", routeCustomer);
router.use("/order", routeOrder);
router.use("/order_row", routeOrderRow);
router.use("/log", routeLogs);

router.get("/index", (req, res) => {
    let data = {
        title: "Hem | E-shop"
    };

    res.render("index", data);
});

router.get("/about", (req, res) => {
    let data = {
        title: "Om | E-shop"
    };

    res.render("about", data);
});

module.exports = router;
