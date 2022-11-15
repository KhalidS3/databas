/**
 * @author Khalid Safi
 *
 * route for order_row
 */

"use strict";

const bodyParser = require("body-parser");
const urlencodedParser = bodyParser.urlencoded({ extended: false });

const express = require("express");
const router = express.Router();

const product = require("../src/product.js");
const orderRow = require("../src/order_row.js");

router.get("/create/:orderid", async (req, res) => {
    let data = {
        title: `Skapa orderrad | E-shop`
    };

    data.orderid = req.params.orderid;
    data.products = await product.showProducts();
    res.render("order_row/create", data);
});

router.post("/create", urlencodedParser, async (req, res) => {
    await orderRow.createOrderRow(
        req.body.order_id,
        req.body.product_id,
        req.body.amount
    );
    res.redirect("/eshop/order/show/" + req.body.order_id);
});

module.exports = router;
