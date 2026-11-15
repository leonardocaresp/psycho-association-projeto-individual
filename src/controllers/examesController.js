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


function buscarInfosUsuario(req, res) {

    var idUsuario = Number(req.params.idUsuario);

    console.log(`Recuperando medidas em tempo real`);

    examesModel.buscarInfosUsuario(idUsuario).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as informações do exame.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function buscarResumoIndividual(req, res) {
    var idUsuario = Number(req.params.idUsuario);

    examesModel.buscarResumoIndividual(idUsuario).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar o resumo individual do exame.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function buscarUltimaTentativa(req, res) {
    var idUsuario = Number(req.params.idUsuario);

    examesModel.buscarUltimaTentativa(idUsuario).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar a última tentativa do exame.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function buscarRanking(req, res) {
    examesModel.buscarRanking().then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar o ranking do exame.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function buscarResumoGeral(req, res) {
    examesModel.buscarResumoGeral().then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar o resumo geral do exame.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
  enviar,
  buscarInfosUsuario,
  buscarResumoIndividual,
  buscarUltimaTentativa,
  buscarRanking,
  buscarResumoGeral
};
