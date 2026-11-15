var express = require("express");
var router = express.Router();

var painelController = require("../controllers/painelController");

router.get("/geral", function (req, res) {
    painelController.buscarDadosGerais(req, res);
});

router.get("/individual/:idUsuario", function (req, res) {
    painelController.buscarDadosIndividuais(req, res);
});

module.exports = router;
