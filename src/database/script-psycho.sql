CREATE DATABASE IF NOT EXISTS psycho_association;

USE psycho_association;

CREATE TABLE usuario (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(55) DEFAULT NULL,
    email VARCHAR(200) DEFAULT NULL,
    senha VARCHAR(55) DEFAULT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE ocorrencia (
    id INT NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(55) DEFAULT NULL,
    classificacao VARCHAR(55) DEFAULT NULL,
    status VARCHAR(55) DEFAULT NULL,
    local VARCHAR(100) DEFAULT NULL,
    descricao VARCHAR(500) DEFAULT NULL,
    fk_usuario INT DEFAULT NULL,
    dt_ocorrencia DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY fk_usuario (fk_usuario),
    CONSTRAINT ocorrencia_ibfk_1 FOREIGN KEY (fk_usuario)
        REFERENCES usuario (id)
);

CREATE TABLE resultado_exame (
    id INT NOT NULL AUTO_INCREMENT,
    poderes_psiquicos TINYINT DEFAULT NULL,
    espiritos TINYINT DEFAULT NULL,
    organizacoes TINYINT DEFAULT NULL,
    personagens TINYINT DEFAULT NULL,
    fk_usuario INT NOT NULL,
    dt_exame DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id, fk_usuario),
    KEY fk_usuario (fk_usuario),
    CONSTRAINT resultado_exame_ibfk_1 FOREIGN KEY (fk_usuario)
        REFERENCES usuario (id)
);

CREATE VIEW vw_resumo_tentativa AS
SELECT
    r.id AS id_tentativa,
    u.id AS id_usuario,
    u.nome AS nome_usuario,
    r.poderes_psiquicos AS acertos_poderes_psiquicos,
    r.espiritos AS acertos_espiritos,
    r.organizacoes AS acertos_organizacoes,
    r.personagens AS acertos_personagens,
    (r.poderes_psiquicos + r.espiritos + r.organizacoes + r.personagens) AS acertos_totais,
    ROUND(((r.poderes_psiquicos + r.espiritos + r.organizacoes + r.personagens) / 20) * 100, 2) AS perc_acerto,
    r.dt_exame AS dt_tentativa
FROM resultado_exame r
JOIN usuario u
    ON u.id = r.fk_usuario;

CREATE VIEW vw_resumo_tentativas_individual AS
SELECT
    id_usuario,
    nome_usuario,
    COUNT(id_tentativa) AS tentativas,
    ROUND(AVG(acertos_poderes_psiquicos), 2) AS media_acerto_poderes_psiquicos,
    ROUND(AVG(acertos_espiritos), 2) AS media_acerto_espiritos,
    ROUND(AVG(acertos_organizacoes), 2) AS media_acerto_organizacoes,
    ROUND(AVG(acertos_personagens), 2) AS media_acerto_personagens,
    ROUND(AVG(perc_acerto), 2) AS media_perc_acerto,
    MAX(acertos_totais) AS melhor_tentativa
FROM vw_resumo_tentativa
GROUP BY id_usuario, nome_usuario;

CREATE VIEW vw_resumo_tentativas_geral AS
SELECT
    ROUND(AVG(media_acerto_poderes_psiquicos), 2) AS media_acerto_poderes_psiquicos,
    ROUND(AVG(media_acerto_espiritos), 2) AS media_acerto_espiritos,
    ROUND(AVG(media_acerto_organizacoes), 2) AS media_acerto_organizacoes,
    ROUND(AVG(media_acerto_personagens), 2) AS media_acerto_personagens,
    ROUND(AVG(media_perc_acerto), 2) AS media_perc_acerto,
    SUM(tentativas) AS tentativas
FROM vw_resumo_tentativas_individual;

CREATE VIEW ranking AS
SELECT
    DENSE_RANK() OVER (ORDER BY melhor_tentativa DESC, tentativas) AS ranking,
    id_usuario,
    nome_usuario,
    melhor_tentativa AS acertos,
    tentativas
FROM vw_resumo_tentativas_individual;

SELECT * FROM ocorrencia;

CREATE VIEW vw_ocorrencias_geral AS
SELECT
    COUNT(CASE WHEN classificacao = 'poderes-psiquicos' THEN 1 END) AS poderes_psiquicos,
    COUNT(CASE WHEN classificacao = 'espiritos-possessoes' THEN 1 END) AS espiritos_possessoes,
    COUNT(CASE WHEN classificacao = 'organizacoes-psiquicas' THEN 1 END) AS organizacoes_psiquicas,
    COUNT(CASE WHEN classificacao = 'fenomenos-anomalos' THEN 1 END) AS fenomenos_anomalos,
    COUNT(CASE WHEN status = 'Em investigação' THEN 1 END) AS em_investigacao,
    COUNT(CASE WHEN status = 'Resolvido' THEN 1 END) AS resolvido,
    COUNT(CASE WHEN status = 'Sem explicação' THEN 1 END) AS sem_explicacao,
    COUNT(id) AS total
FROM ocorrencia;

SELECT * FROM vw_ocorrencias_geral;

CREATE VIEW vw_perc_status_geral AS
SELECT
    IF(total = 0, 0, ROUND(resolvido / total * 100, 2)) AS resolvidos,
    IF(total = 0, 0, ROUND(em_investigacao / total * 100, 2)) AS em_investigacao,
    IF(total = 0, 0, ROUND(sem_explicacao / total * 100, 2)) AS sem_explicacao
FROM vw_ocorrencias_geral;

SELECT * FROM vw_perc_status_geral;

CREATE VIEW vw_ocorrencias_individual AS
SELECT
    usuario.id AS id_usuario,
    usuario.nome AS nome_usuario,
    COUNT(CASE WHEN classificacao = 'poderes-psiquicos' THEN 1 END) AS poderes_psiquicos,
    COUNT(CASE WHEN classificacao = 'espiritos-possessoes' THEN 1 END) AS espiritos_possessoes,
    COUNT(CASE WHEN classificacao = 'organizacoes-psiquicas' THEN 1 END) AS organizacoes_psiquicas,
    COUNT(CASE WHEN classificacao = 'fenomenos-anomalos' THEN 1 END) AS fenomenos_anomalos,
    COUNT(CASE WHEN status = 'Em investigação' THEN 1 END) AS em_investigacao,
    COUNT(CASE WHEN status = 'Resolvido' THEN 1 END) AS resolvido,
    COUNT(CASE WHEN status = 'Sem explicação' THEN 1 END) AS sem_explicacao,
    COUNT(ocorrencia.id) AS total
FROM ocorrencia
JOIN usuario
    ON ocorrencia.fk_usuario = usuario.id
GROUP BY usuario.id, usuario.nome;

SELECT * FROM vw_ocorrencias_individual;

CREATE VIEW vw_perc_status_individual AS
SELECT
    id_usuario,
    nome_usuario,
    IF(total = 0, 0, ROUND(resolvido / total * 100, 2)) AS resolvidos,
    IF(total = 0, 0, ROUND(em_investigacao / total * 100, 2)) AS em_investigacao,
    IF(total = 0, 0, ROUND(sem_explicacao / total * 100, 2)) AS sem_explicacao
FROM vw_ocorrencias_individual;

SELECT * FROM vw_perc_status_individual;

SELECT * FROM usuario;
