var examesModel = require("../models/examesModel");

function enviar(req, res) {
  var idUsuario = req.body.idUsuarioServer;
  var paranormal = req.body.paranormalServer;
  var investigacao = req.body.investigacaoServer;
  var contencao = req.body.contencaoServer;
  var estrategia = req.body.estrategiaServer;

  examesModel
    .enviar(idUsuario, paranormal, investigacao, contencao, estrategia)
    .then(function (resultado) {
      res.json(resultado);
    })
    .catch(function (erro) {
      console.log(erro);
      console.log(
        "\nHouve um erro ao enviar o resultado! Erro: ",
        erro.sqlMessage,
      );
      res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
  enviar
};
