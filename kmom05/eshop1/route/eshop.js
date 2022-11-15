"use strict";

const bodyParser = require("body-parser");
const urlencodedParser = bodyParser.urlencoded({ extended: false });

const express = require("express");
const router = express.Router();
const siteName = "| E-shop";

// Imports an eshop module.
const eshop = require("../src/eshop.js");

// 1.
router.get("/index", (req, res) => {
    let data = {
        title: `Welcome to ${siteName}`
    };

    res.render("eshop/index", data);
});

// 2.
router.get("/category", async (req, res) => {
    let data = {
        title: `Category ${siteName}`
    };

    data.res = await eshop.showCategory();

    res.render("eshop/category", data);
});

router.get("/category/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Category ${id} ${siteName}`,
        product: id,
        category: id
    };

    data.res = await eshop.showCategory2Products(id, id);
    res.render("eshop/category-view", data);
});

// 3.
router.get("/products", async (req, res) => {
    let data = {
        title: `Products ${siteName}`
    };

    data.res = await eshop.showProducts();

    res.render("eshop/products", data);
});

// 4.
router.get("/product/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `specific product ${id} ${siteName}`,
        product: id
    };

    data.res = await eshop.showProduct(id);
    res.render("eshop/product-view", data);
});

// 5.
router.get("/create", async (req, res) => {
    let data = {
        title: `Create ${siteName}`
    };

    res.render("eshop/product-create", data);
});

// 6.
router.post("/create", urlencodedParser, async (req, res) => {
    await eshop.createProduct(
        req.body.produktid,
        req.body.pris,
        req.body.namn,
        req.body.bildlank,
        req.body.beskrivning
    );

    res.redirect("/eshop/products");
});

// 7.
router.get("/edit/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Edit product ${id} ${siteName}`,
        product: id
    };

    data.res = await eshop.showProduct(id);

    res.render("eshop/product-edit", data);
});

// 8.
router.post("/edit", urlencodedParser, async (req, res) => {
    await eshop.editProduct(
        req.body.produktid,
        req.body.pris,
        req.body.namn,
        req.body.bildlank,
        req.body.beskrivning
    );

    res.redirect("/eshop/products");
});

// 9.
router.get("/delete/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Delete product ${id} ${siteName}`,
        product: id
    };

    data.res = await eshop.showProduct(id);

    res.render("eshop/product-delete", data);
});

// 10.
router.post("/delete", urlencodedParser, async (req, res) => {
    await eshop.deleteProduct(req.body.produktid);

    res.redirect(`/eshop/products`);
});

module.exports = router;
