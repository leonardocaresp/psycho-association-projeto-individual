var express = require("express");
var router = express.Router();

var examesController = require("../controllers/examesController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/enviar", function (req, res) {
    examesController.enviar(req, res);
})

// router.get("/listar", function (req, res) {
//     examesController.listar(req, res);
// });

module.exports = router;