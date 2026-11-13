var database = require("../database/config");

function listar() {
    console.log("ACESSEI O OCORRENCIA MODEL \n\n function listar()");
    var instrucaoSql = `
        SELECT
            o.id AS idOcorrencia,
            o.titulo,
            o.classificacao,
            o.status,
            o.local,
            o.descricao,
            o.fk_usuario,
            u.nome AS nomeUsuario,
            u.email AS emailUsuario
        FROM ocorrencia o
            INNER JOIN usuario u
                ON o.fk_usuario = u.id
        ORDER BY o.id DESC;
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function publicar(titulo, classificacao, status, local, descricao, idUsuario) {
    console.log("ACESSEI O OCORRENCIA MODEL \n\n function publicar(): ", titulo, classificacao, status, local, descricao, idUsuario);
    var instrucaoSql = `
        INSERT INTO ocorrencia (titulo, classificacao, status, local, descricao, fk_usuario)
        VALUES ('${titulo}', '${classificacao}', '${status}', '${local}', '${descricao}', ${idUsuario});
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function editar(idOcorrencia, titulo, classificacao, status, local, descricao) {
    console.log("ACESSEI O OCORRENCIA MODEL \n\n function editar(): ", idOcorrencia, titulo, classificacao, status, local, descricao);
    var instrucaoSql = `
        UPDATE ocorrencia
            SET titulo = '${titulo}',
                classificacao = '${classificacao}',
                status = '${status}',
                local = '${local}',
                descricao = '${descricao}'
        WHERE id = ${idOcorrencia};
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function deletar(idOcorrencia) {
    console.log("ACESSEI O OCORRENCIA MODEL \n\n function deletar():", idOcorrencia);
    var instrucaoSql = `
        DELETE FROM ocorrencia WHERE id = ${idOcorrencia};
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    listar,
    publicar,
    editar,
    deletar
};
