var painelModel = require("../models/painelModel");

function buscarDadosGerais(req, res) {
    painelModel.buscarOcorrenciasGerais().then(function (resultadoOcorrencias) {
        painelModel.buscarPercentuaisGerais().then(function (resultadoPercentuais) {
            if (resultadoOcorrencias.length > 0) {
                var percentuais = {
                    resolvidos: 0,
                    em_investigacao: 0,
                    sem_explicacao: 0
                };

                if (resultadoPercentuais.length > 0) {
                    percentuais = resultadoPercentuais[0];
                }

                res.status(200).json({
                    ocorrencias: resultadoOcorrencias[0],
                    percentuais: percentuais
                });
            } else {
                res.status(204).send("Nenhum resultado encontrado!");
            }
        }).catch(function (erro) {
            console.log(erro);
            console.log("Houve um erro ao buscar os percentuais gerais do painel.", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar os dados gerais do painel.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function buscarDadosIndividuais(req, res) {
    var idUsuario = Number(req.params.idUsuario);

    painelModel.buscarOcorrenciasIndividuais(idUsuario).then(function (resultadoOcorrencias) {
        painelModel.buscarPercentuaisIndividuais(idUsuario).then(function (resultadoPercentuais) {
            if (resultadoOcorrencias.length > 0) {
                var percentuais = {
                    resolvidos: 0,
                    em_investigacao: 0,
                    sem_explicacao: 0
                };

                if (resultadoPercentuais.length > 0) {
                    percentuais = resultadoPercentuais[0];
                }

                res.status(200).json({
                    ocorrencias: resultadoOcorrencias[0],
                    percentuais: percentuais
                });
            } else {
                res.status(204).send("Nenhum resultado encontrado!");
            }
        }).catch(function (erro) {
            console.log(erro);
            console.log("Houve um erro ao buscar os percentuais individuais do painel.", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar os dados individuais do painel.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
    buscarDadosGerais,
    buscarDadosIndividuais
};
