var express = require("express");
var router = express.Router();

var ocorrenciaController = require("../controllers/ocorrenciaController");

router.get("/listar", function (req, res) {
    ocorrenciaController.listar(req, res);
});

router.post("/publicar/:idUsuario", function (req, res) {
    ocorrenciaController.publicar(req, res);
});

router.put("/editar/:idOcorrencia", function (req, res) {
    ocorrenciaController.editar(req, res);
});

router.delete("/deletar/:idOcorrencia", function (req, res) {
    ocorrenciaController.deletar(req, res);
});

module.exports = router;
