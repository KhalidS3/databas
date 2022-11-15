/**
 * @author Khalid Safi
 *
 * route for order
 */

"use strict";

const bodyParser = require("body-parser");
const urlencodedParser = bodyParser.urlencoded({ extended: false });

const express = require("express");
const router = express.Router();

// const customer = require("../src/customer.js");
// const order = require("../src/order.js");
// const orderRow = require("../src/order_row.js");
const customer = require("../src/custormer.js");
const order = require("../src/order.js");
const orderRow = require("../src/order_row.js");
const pick = require("../src/es.js");

const siteName = "| E-shop";

router.get("/", async (req, res) => {
    let data = {
        title: `Ordrar ${siteName}`
    };

    data.orders = await order.showOrders();
    res.render("order/all-orders", data);
});

router.get("/create", async (req, res) => {
    let data = {
        title: `Skapa order ${siteName}`
    };

    data.customers = await customer.showCustomers();
    res.render("order/create", data);
});

router.post("/create", urlencodedParser, async (req, res) => {
    await order.createOrder(req.body.customer_id);
    res.redirect("/eshop/order");
});

router.get("/show/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Visa order ${siteName}`
    };

    data.orderRows = await orderRow.showOrderRows(id);
    data.order = await order.showOrder(id);
    res.render("order/show", data);
});

router.post("/ordered", urlencodedParser, async (req, res) => {
    await order.setStatus(req.body.order_id, "Beställd");
    res.redirect("/eshop/order/");
});

router.get("/picklist/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Picklist ${id} ${siteName}`,
        product: id
    };

    data.picklists = await pick.pickList(id);

    res.render("order/show_picklist", data);
});

module.exports = router;
