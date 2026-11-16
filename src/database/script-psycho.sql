CREATE DATABASE psycho_association;

USE psycho_association;

CREATE TABLE `ocorrencia` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `titulo` VARCHAR(55) DEFAULT NULL,
    `classificacao` VARCHAR(55) DEFAULT NULL,
    `status` VARCHAR(55) DEFAULT NULL,
    `local` VARCHAR(100) DEFAULT NULL,
    `descricao` VARCHAR(500) DEFAULT NULL,
    `fk_usuario` INT DEFAULT NULL,
    `dt_ocorrencia` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `fk_usuario` (`fk_usuario`),
    CONSTRAINT `ocorrencia_ibfk_1` FOREIGN KEY (`fk_usuario`)
        REFERENCES `usuario` (`id`)
);

CREATE TABLE `resultado_exame` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `paranormal` TINYINT DEFAULT NULL,
    `investigacao` TINYINT DEFAULT NULL,
    `contencao` TINYINT DEFAULT NULL,
    `estrategia` TINYINT DEFAULT NULL,
    `fk_usuario` INT NOT NULL,
    `dt_exame` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id` , `fk_usuario`),
    KEY `fk_usuario` (`fk_usuario`),
    CONSTRAINT `resultado_exame_ibfk_1` FOREIGN KEY (`fk_usuario`)
        REFERENCES `usuario` (`id`)
);

CREATE TABLE `usuario` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(55) DEFAULT NULL,
    `email` VARCHAR(200) DEFAULT NULL,
    `senha` VARCHAR(55) DEFAULT NULL,
    PRIMARY KEY (`id`)
);

CREATE VIEW `vw_resumo_tentativa` AS
    SELECT 
        `r`.`id` AS `id_tentativa`,
        `u`.`id` AS `id_usuario`,
        `u`.`nome` AS `nome_usuario`,
        `r`.`paranormal` AS `acertos_paranormal`,
        `r`.`investigacao` AS `acertos_investigacao`,
        `r`.`contencao` AS `acertos_contencao`,
        `r`.`estrategia` AS `acertos_estrategia`,
        SUM((((`r`.`paranormal` + `r`.`investigacao`) + `r`.`contencao`) + `r`.`estrategia`)) AS `acertos_totais`,
        ROUND(((SUM((((`r`.`paranormal` + `r`.`investigacao`) + `r`.`contencao`) + `r`.`estrategia`)) / 20) * 100),
                2) AS `perc_acerto`,
        `r`.`dt_exame` AS `dt_tentativa`
    FROM
        (`psycho_association`.`resultado_exame` `r`
        JOIN `psycho_association`.`usuario` `u` ON ((`u`.`id` = `r`.`fk_usuario`)))
    GROUP BY `r`.`id` , `u`.`nome` , `r`.`paranormal` , `r`.`investigacao` , `r`.`estrategia` , `r`.`contencao` , `r`.`dt_exame` , `u`.`id`;

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `psycho_association`.`vw_resumo_tentativa` AS
    SELECT 
        `r`.`id` AS `id_tentativa`,
        `u`.`id` AS `id_usuario`,
        `u`.`nome` AS `nome_usuario`,
        `r`.`paranormal` AS `acertos_paranormal`,
        `r`.`investigacao` AS `acertos_investigacao`,
        `r`.`contencao` AS `acertos_contencao`,
        `r`.`estrategia` AS `acertos_estrategia`,
        SUM((((`r`.`paranormal` + `r`.`investigacao`) + `r`.`contencao`) + `r`.`estrategia`)) AS `acertos_totais`,
        ROUND(((SUM((((`r`.`paranormal` + `r`.`investigacao`) + `r`.`contencao`) + `r`.`estrategia`)) / 20) * 100),
                2) AS `perc_acerto`,
        `r`.`dt_exame` AS `dt_tentativa`
    FROM
        (`psycho_association`.`resultado_exame` `r`
        JOIN `psycho_association`.`usuario` `u` ON ((`u`.`id` = `r`.`fk_usuario`)))
    GROUP BY `r`.`id` , `u`.`nome` , `r`.`paranormal` , `r`.`investigacao` , `r`.`estrategia` , `r`.`contencao` , `r`.`dt_exame` , `u`.`id`;

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `psycho_association`.`vw_resumo_tentativas_geral` AS
    SELECT 
        ROUND(AVG(`psycho_association`.`vw_resumo_tentativas_individual`.`media_acerto_paranormal`),
                2) AS `media_acerto_paranormal`,
        ROUND(AVG(`psycho_association`.`vw_resumo_tentativas_individual`.`media_acerto_investigacao`),
                2) AS `media_acerto_investigacao`,
        ROUND(AVG(`psycho_association`.`vw_resumo_tentativas_individual`.`media_acerto_estrategia`),
                2) AS `media_acerto_estrategia`,
        ROUND(AVG(`psycho_association`.`vw_resumo_tentativas_individual`.`media_acerto_contencao`),
                2) AS `media_acerto_contencao`,
        ROUND(AVG(`psycho_association`.`vw_resumo_tentativas_individual`.`media_perc_acerto`),
                2) AS `media_perc_acerto`,
        SUM(`psycho_association`.`vw_resumo_tentativas_individual`.`tentativas`) AS `tentativas`
    FROM
        `psycho_association`.`vw_resumo_tentativas_individual`;

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `psycho_association`.`vw_resumo_tentativas_individual` AS
    SELECT 
        `psycho_association`.`vw_resumo_tentativa`.`id_usuario` AS `id_usuario`,
        `psycho_association`.`vw_resumo_tentativa`.`nome_usuario` AS `nome_usuario`,
        COUNT(`psycho_association`.`vw_resumo_tentativa`.`id_tentativa`) AS `tentativas`,
        ROUND(AVG(`psycho_association`.`vw_resumo_tentativa`.`acertos_paranormal`),
                2) AS `media_acerto_paranormal`,
        ROUND(AVG(`psycho_association`.`vw_resumo_tentativa`.`acertos_investigacao`),
                2) AS `media_acerto_investigacao`,
        ROUND(AVG(`psycho_association`.`vw_resumo_tentativa`.`acertos_estrategia`),
                2) AS `media_acerto_estrategia`,
        ROUND(AVG(`psycho_association`.`vw_resumo_tentativa`.`acertos_contencao`),
                2) AS `media_acerto_contencao`,
        ROUND(AVG(`psycho_association`.`vw_resumo_tentativa`.`perc_acerto`),
                2) AS `media_perc_acerto`,
        MAX(`psycho_association`.`vw_resumo_tentativa`.`acertos_totais`) AS `melhor_tentativa`
    FROM
        `psycho_association`.`vw_resumo_tentativa`
    GROUP BY `psycho_association`.`vw_resumo_tentativa`.`nome_usuario` , `psycho_association`.`vw_resumo_tentativa`.`id_usuario`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `psycho_association`.`ranking` AS select dense_rank() OVER (ORDER BY `psycho_association`.`vw_resumo_tentativas_individual`.`melhor_tentativa` desc,`psycho_association`.`vw_resumo_tentativas_individual`.`tentativas` )  AS `ranking`,`psycho_association`.`vw_resumo_tentativas_individual`.`id_usuario` AS `id_usuario`,`psycho_association`.`vw_resumo_tentativas_individual`.`nome_usuario` AS `nome_usuario`,`psycho_association`.`vw_resumo_tentativas_individual`.`melhor_tentativa` AS `acertos`,`psycho_association`.`vw_resumo_tentativas_individual`.`tentativas` AS `tentativas` from `psycho_association`.`vw_resumo_tentativas_individual`;

SELECT * FROM ocorrencia;

CREATE VIEW vw_ocorrencias_geral AS
SELECT COUNT(CASE WHEN classificacao = 'Poderes psíquicos' THEN 1 END) poderes_psiquicos,
COUNT(CASE WHEN classificacao = 'Entidades espirituais' THEN 1 END) entidades_espirituais,
COUNT(CASE WHEN classificacao = 'Locais assombrados' THEN 1 END) locais_assombrados,
COUNT(CASE WHEN classificacao = 'Seitas paranormais' THEN 1 END) seitas_paranormais,
COUNT(CASE WHEN status = 'Em investigação' THEN 1 END) em_investigacao,
COUNT(CASE WHEN status = 'Resolvido' THEN 1 END) resolvido,
COUNT(CASE WHEN status = 'Sem explicação' THEN 1 END) sem_explicacao,
COUNT(id) total
FROM ocorrencia;

SELECT * FROM vw_ocorrencias_geral;

CREATE VIEW vw_perc_status_geral AS
SELECT ROUND(resolvido / total * 100, 2) resolvidos, 
ROUND(em_investigacao / total * 100, 2) em_investigacao, 
ROUND(sem_explicacao / total * 100, 2) sem_explicacao  
FROM vw_ocorrencias_geral;

SELECT * FROM vw_perc_status_geral;

CREATE VIEW vw_ocorrencias_individual AS
SELECT usuario.id id_usuario, usuario.nome nome_usuario,
COUNT(CASE WHEN classificacao = 'Poderes psíquicos' THEN 1 END) poderes_psiquicos,
COUNT(CASE WHEN classificacao = 'Entidades espirituais' THEN 1 END) entidades_espirituais,
COUNT(CASE WHEN classificacao = 'Locais assombrados' THEN 1 END) locais_assombrados,
COUNT(CASE WHEN classificacao = 'Seitas paranormais' THEN 1 END) seitas_paranormais,
COUNT(CASE WHEN status = 'Em investigação' THEN 1 END) em_investigacao,
COUNT(CASE WHEN status = 'Resolvido' THEN 1 END) resolvido,
COUNT(CASE WHEN status = 'Sem explicação' THEN 1 END) sem_explicacao,
COUNT(ocorrencia.id) total
FROM ocorrencia JOIN usuario
ON ocorrencia.fk_usuario = usuario.id
GROUP BY usuario.id;

SELECT * FROM vw_ocorrencias_individual;

CREATE VIEW vw_perc_status_individual AS
SELECT id_usuario, nome_usuario, ROUND(resolvido / total * 100, 2) resolvidos, 
ROUND(em_investigacao / total * 100, 2) em_investigacao, 
ROUND(sem_explicacao / total * 100, 2) sem_explicacao  
FROM vw_ocorrencias_individual;

SELECT * FROM vw_perc_status_individual;

SELECT * FROM usuario;


