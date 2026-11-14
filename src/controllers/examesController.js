var examesModel = require("../models/examesModel");
// var aquarioModel = require("../models/aquarioModel");

// function autenticar(req, res) {
//     var idUsuario = req.body.emailServer;
//     var paranormal = req.body.senhaServer;
//     var investigacao = req.body.senhaServer;
//     var contencao = req.body.senhaServer;
//     var estrategia = req.body.senhaServer;

//     if (email == undefined) {
//         res.status(400).send("Seu email está undefined!");
//     } else if (senha == undefined) {
//         res.status(400).send("Sua senha está indefinida!");
//     } else {

//         usuarioModel.autenticar(email, senha)
//             .then(
//                 function (resultadoAutenticar) {
//                     console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
//                     console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String

//                     if (resultadoAutenticar.length == 1) {
//                         console.log(resultadoAutenticar);


//                         res.json({
//                             id: resultadoAutenticar[0].id,
//                             email: resultadoAutenticar[0].email,
//                             nome: resultadoAutenticar[0].nome,
//                             senha: resultadoAutenticar[0].senha,


//                         })

//                     } else if (resultadoAutenticar.length == 0) {
//                         res.status(403).send("Email e/ou senha inválido(s)");
//                     } else {
//                         res.status(403).send("Mais de um usuário com o mesmo login e senha!");
//                     }
//                 }
//             ).catch(
//                 function (erro) {
//                     console.log(erro);
//                     console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
//                     res.status(500).json(erro.sqlMessage);
//                 }
//             );
//     }

// }

function enviar(req, res) {

    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var idUsuario = req.body.idUsuarioServer;
    var paranormal = req.body.paranormalServer;
    var investigacao = req.body.investigacaoServer;
    var contencao = req.body.contencaoServer;
    var estrategia = req.body.estrategiaServer;

    // Faça as validações dos valores
    // if (nome == undefined) {
    //     res.status(400).send("Seu nome está undefined!");


    // } else if (email == undefined) {

    //     res.status(400).send("Seu email está undefined!");

    // } else if (senha == undefined) {

    //     res.status(400).send("Sua senha está undefined!");

    // } else {

    // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
    examesModel.enviar(idUsuario,
        paranormal,
        investigacao,
        contencao,
        estrategia)
        .then(
            function (resultado) {
                res.json(resultado);
            }
        ).catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "\nHouve um erro ao enviar o resultado! Erro: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
    // }
}

module.exports = {
    enviar
}