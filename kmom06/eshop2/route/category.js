/**
 * @author Khalid Safi
 *
 * route for category
 */

"use strict";

const express = require("express");
const router = express.Router();

const siteName = "| E-shop";

const category = require("../src/category.js");

router.get("/", async (req, res) => {
    let data = {
        title: `Category ${siteName}`
    };

    data.categories = await category.showCategory();
    res.render("category/all-categories", data);
});

router.get("/show/:id", async (req, res) => {
    let id = req.params.id;
    let data = {
        title: `Category ${id} ${siteName}`,
        product: id,
        category: id
    };

    data.res = await category.showCategory2Products(id, id);
    res.render("category/show", data);
});

module.exports = router;
