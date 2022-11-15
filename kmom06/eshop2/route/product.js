/**
 * @author Khalid Safi
 *
 * route for product
 */

"use strict";

const bodyParser = require("body-parser");
const urlencodedParser = bodyParser.urlencoded({ extended: false });

const express = require("express");
const router = express.Router();

const product = require("../src/product.js");

router.get("/", async (req, res) => {
    let data = {
        title: "Produkt | E-shop"
    };

    data.products = await product.showProducts();
    res.render("product/all-products", data);
});

router.get("/create", async (req, res) => {
    let data = {
        title: "Skapa produkt | E-shop"
    };

    res.render("product/create", data);
});

router.post("/create", urlencodedParser, async (req, res) => {
    await product.createProduct(
        req.body.produktid,
        req.body.pris,
        req.body.namn,
        req.body.bildlank,
        req.body.beskrivning
    );
    res.redirect("/eshop/product");
});

router.get("/delete/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Radera produkt ${id}`,
    };

    data.product = await product.showProduct(id);
    res.render("product/delete", data);
});

router.post("/delete", urlencodedParser, async (req, res) => {
    await product.deleteProduct(req.body.produktid);
    res.redirect("/eshop/product");
});

router.get("/edit/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Ändra produkt ${id}`,
    };

    data.product = await product.showProduct(id);
    res.render("product/edit", data);
});

router.post("/edit", urlencodedParser, async (req, res) => {
    await product.editProduct(
        req.body.produktid,
        req.body.pris,
        req.body.namn,
        req.body.bildlank,
        req.body.beskrivning
    );
    res.redirect("/eshop/product");
});

router.get("/show/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Produkt | E-shop`,
    };

    data.product = await product.showProduct(id);
    res.render("product/show", data);
});

module.exports = router;
