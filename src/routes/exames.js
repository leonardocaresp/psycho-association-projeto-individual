var express = require("express");
var router = express.Router();

var examesController = require("../controllers/examesController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/enviar", function (req, res) {
    examesController.enviar(req, res);
})

router.get("/resumo-individual/:idUsuario", function (req, res) {
     examesController.buscarResumoIndividual(req, res);
});

router.get("/ultima-tentativa/:idUsuario", function (req, res) {
     examesController.buscarUltimaTentativa(req, res);
});

router.get("/ranking", function (req, res) {
     examesController.buscarRanking(req, res);
});

router.get("/resumo-geral", function (req, res) {
     examesController.buscarResumoGeral(req, res);
});

router.get("/:idUsuario", function (req, res) {
     examesController.buscarInfosUsuario(req, res);
});


module.exports = router;
