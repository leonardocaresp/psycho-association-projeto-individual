var database = require("../database/config")


function enviar(idUsuario,
        paranormal,
        investigacao,
        contencao,
        estrategia) {
    console.log("ACESSEI O EXAMES MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function enviar():", idUsuario,
        paranormal,
        investigacao,
        contencao,
        estrategia);
    
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucaoSql = `
        INSERT INTO resultado_exame (fk_usuario, paranormal, investigacao, contencao, estrategia) VALUES ('${idUsuario}', '${paranormal}', '${investigacao}', '${contencao}', '${estrategia}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarInfosUsuario(idUsuario) {

    var instrucaoSql = `SELECT 
                        * FROM vw_resumo_tentativas_individual WHERE id_usuario = ${idUsuario} LIMIT 1`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarResumoIndividual(idUsuario) {
    var instrucaoSql = `
        SELECT * FROM vw_resumo_tentativas_individual
        WHERE id_usuario = ${idUsuario};
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarUltimaTentativa(idUsuario) {
    var instrucaoSql = `
        SELECT * FROM vw_resumo_tentativa
        WHERE id_usuario = ${idUsuario}
        ORDER BY dt_tentativa DESC, id_tentativa DESC
        LIMIT 1;
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarRanking() {
    var instrucaoSql = `
        SELECT * FROM ranking
        ORDER BY ranking ASC, nome_usuario ASC;
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarResumoGeral() {
    var instrucaoSql = `
        SELECT * FROM vw_resumo_tentativas_geral;
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    enviar,
    buscarInfosUsuario,
    buscarResumoIndividual,
    buscarUltimaTentativa,
    buscarRanking,
    buscarResumoGeral
};
