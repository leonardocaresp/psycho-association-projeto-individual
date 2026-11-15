var database = require("../database/config");

function buscarOcorrenciasGerais() {
    var instrucaoSql = `
        SELECT * FROM vw_ocorrencias_geral;
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarPercentuaisGerais() {
    var instrucaoSql = `
        SELECT * FROM vw_perc_status_geral;
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarOcorrenciasIndividuais(idUsuario) {
    var instrucaoSql = `
        SELECT * FROM vw_ocorrencias_individual
        WHERE id_usuario = ${idUsuario};
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarPercentuaisIndividuais(idUsuario) {
    var instrucaoSql = `
        SELECT * FROM vw_perc_status_individual
        WHERE id_usuario = ${idUsuario};
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarOcorrenciasGerais,
    buscarPercentuaisGerais,
    buscarOcorrenciasIndividuais,
    buscarPercentuaisIndividuais
};
