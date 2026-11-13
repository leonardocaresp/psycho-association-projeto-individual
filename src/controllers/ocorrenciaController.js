var ocorrenciaModel = require("../models/ocorrenciaModel");

function listar(req, res) {
    ocorrenciaModel.listar()
        .then(function (resultado) {
            if (resultado.length > 0) {
                res.status(200).json(resultado);
            } else {
                res.status(204).send("Nenhum resultado encontrado!");
            }
        })
        .catch(function (erro) {
            console.log(erro);
            console.log("Houve um erro ao buscar as ocorrências: ", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

function publicar(req, res) {
    var titulo = req.body.titulo;
    var classificacao = req.body.classificacao;
    var status = req.body.status;
    var local = req.body.local;
    var descricao = req.body.descricao;
    var idUsuario = req.params.idUsuario;

    if (titulo == undefined) {
        res.status(400).send("O título está indefinido!");
    } else if (classificacao == undefined) {
        res.status(400).send("A classificação está indefinida!");
    } else if (status == undefined) {
        res.status(400).send("O status está indefinido!");
    } else if (local == undefined) {
        res.status(400).send("O local está indefinido!");
    } else if (descricao == undefined) {
        res.status(400).send("A descrição está indefinida!");
    } else if (idUsuario == undefined) {
        res.status(403).send("O id do usuário está indefinido!");
    } else {
        ocorrenciaModel.publicar(titulo, classificacao, status, local, descricao, idUsuario)
            .then(function (resultado) {
                res.json(resultado);
            })
            .catch(function (erro) {
                console.log(erro);
                console.log("Houve um erro ao realizar o post: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            });
    }
}

function editar(req, res) {
    var idOcorrencia = req.params.idOcorrencia;
    var titulo = req.body.titulo;
    var classificacao = req.body.classificacao;
    var status = req.body.status;
    var local = req.body.local;
    var descricao = req.body.descricao;

    if (idOcorrencia == undefined) {
        res.status(403).send("O id da ocorrência está indefinido!");
    } else if (titulo == undefined) {
        res.status(400).send("O título está indefinido!");
    } else if (classificacao == undefined) {
        res.status(400).send("A classificação está indefinida!");
    } else if (status == undefined) {
        res.status(400).send("O status está indefinido!");
    } else if (local == undefined) {
        res.status(400).send("O local está indefinido!");
    } else if (descricao == undefined) {
        res.status(400).send("A descrição está indefinida!");
    } else {
        ocorrenciaModel.editar(idOcorrencia, titulo, classificacao, status, local, descricao)
            .then(function (resultado) {
                res.json(resultado);
            })
            .catch(function (erro) {
                console.log(erro);
                console.log("Houve um erro ao editar a ocorrência: ", erro.sqlMessage);
                res.status(500).json(erro.sqlMessage);
            });
    }
}

function deletar(req, res) {
    var idOcorrencia = req.params.idOcorrencia;

    ocorrenciaModel.deletar(idOcorrencia)
        .then(function (resultado) {
            res.json(resultado);
        })
        .catch(function (erro) {
            console.log(erro);
            console.log("Houve um erro ao deletar a ocorrência: ", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

module.exports = {
    listar,
    publicar,
    editar,
    deletar
};
