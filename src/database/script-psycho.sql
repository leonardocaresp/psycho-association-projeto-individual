CREATE DATABASE IF NOT EXISTS psycho_association;

USE psycho_association;

CREATE USER 'psycho_user'@'%' IDENTIFIED BY 'Urubu@100';

GRANT ALL PRIVILEGES ON psycho_association.* TO  'psycho_user'@'%';

FLUSH PRIVILEGES;

CREATE TABLE usuario (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(55) NOT NULL,
    email VARCHAR(200) NOT NULL UNIQUE,
    senha VARCHAR(55) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE ocorrencia (
    id INT NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(55) NOT NULL,
    classificacao VARCHAR(55) NOT NULL,
    CONSTRAINT chClassificacao CHECK (classificacao IN('organizacoes-psiquicas', 'espiritos-possessoes', 'fenomenos-anomalos', 'poderes-psiquicos')),
    status VARCHAR(55) NOT NULL,
    CONSTRAINT chStatus CHECK (status IN('Sem explicação', 'Resolvido', 'Em investigação')),
    local VARCHAR(100) NOT NULL,
    descricao VARCHAR(500) NOT NULL,
    fk_usuario INT NOT NULL,
    dt_ocorrencia DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY fk_usuario (fk_usuario),
    CONSTRAINT ocorrencia_ibfk_1 FOREIGN KEY (fk_usuario)
        REFERENCES usuario (id)
);

CREATE TABLE resultado_exame (
    id INT NOT NULL AUTO_INCREMENT,
    poderes_psiquicos TINYINT DEFAULT 0,
    espiritos TINYINT DEFAULT 0,
    organizacoes TINYINT DEFAULT 0,
    personagens TINYINT DEFAULT 0,
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
    
CREATE VIEW vw_ocorrencias_mensais_usuario AS
SELECT
    fk_usuario AS id_usuario,
    YEAR(dt_ocorrencia) AS ano,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 1 THEN 1 END) AS janeiro,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 2 THEN 1 END) AS fevereiro,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 3 THEN 1 END) AS marco,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 4 THEN 1 END) AS abril,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 5 THEN 1 END) AS maio,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 6 THEN 1 END) AS junho,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 7 THEN 1 END) AS julho,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 8 THEN 1 END) AS agosto,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 9 THEN 1 END) AS setembro,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 10 THEN 1 END) AS outubro,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 11 THEN 1 END) AS novembro,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 12 THEN 1 END) AS dezembro
FROM ocorrencia
GROUP BY id_usuario, ano;

SELECT * FROM vw_ocorrencias_mensais_usuario;

CREATE VIEW vw_ocorrencias_mensais AS
SELECT
    YEAR(dt_ocorrencia) AS ano,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 1 THEN 1 END) AS janeiro,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 2 THEN 1 END) AS fevereiro,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 3 THEN 1 END) AS marco,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 4 THEN 1 END) AS abril,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 5 THEN 1 END) AS maio,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 6 THEN 1 END) AS junho,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 7 THEN 1 END) AS julho,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 8 THEN 1 END) AS agosto,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 9 THEN 1 END) AS setembro,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 10 THEN 1 END) AS outubro,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 11 THEN 1 END) AS novembro,
    COUNT(CASE WHEN MONTH(dt_ocorrencia) = 12 THEN 1 END) AS dezembro
FROM ocorrencia
GROUP BY ano;

SELECT * FROM vw_ocorrencias_mensais;



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

INSERT INTO usuario (id, nome, email, senha) VALUES
(1, 'Akira Santos', 'akira@email.com', 'teste123'),
(2, 'Marina Costa', 'marina@email.com', 'teste123'),
(3, 'Lucas Tanaka', 'lucas@email.com', 'teste123'),
(4, 'Beatriz Mori', 'beatriz@email.com', 'teste123'),
(5, 'Rafael Sato', 'rafael@email.com', 'teste123'),
(6, 'Julia Nakamura', 'julia@email.com', 'teste123'),
(7, 'Gabriel Lima', 'gabriel@email.com', 'teste123'),
(8, 'Camila Aoki', 'camila@email.com', 'teste123'),
(9, 'Henrique Rocha', 'henrique@email.com', 'teste123'),
(10, 'Sofia Matsuda', 'sofia@email.com', 'teste123');

INSERT INTO ocorrencia
    (titulo, classificacao, status, local, descricao, fk_usuario, dt_ocorrencia)
VALUES
('Recrutamento suspeito', 'organizacoes-psiquicas', 'Em investigação', 'Praça central', 'Um grupo abordava jovens oferecendo treinamento paranormal.', 4, '2026-06-15 16:40:00'),
('Sombra na biblioteca', 'espiritos-possessoes', 'Resolvido', 'Biblioteca municipal', 'Uma presença seguia leitores entre as estantes. O local foi purificado.', 5, '2026-06-18 18:10:00'),
('Pulso telecinético', 'poderes-psiquicos', 'Resolvido', 'Ginásio escolar', 'Um estudante deslocou involuntariamente equipamentos durante um treino.', 6, '2026-06-23 14:05:00'),
('Relógio fora do tempo', 'fenomenos-anomalos', 'Sem explicação', 'Estação de trem', 'O relógio da plataforma atrasava sempre no mesmo horário.', 7, '2026-06-28 19:30:00'),

-- Julho (10)
('Espírito no espelho', 'espiritos-possessoes', 'Resolvido', 'Salão de beleza', 'Reflexos apresentavam movimentos diferentes dos clientes. Entidade removida.', 8, '2026-07-02 10:15:00'),
('Reunião clandestina', 'organizacoes-psiquicas', 'Em investigação', 'Galpão industrial', 'Foram observadas reuniões de pessoas com habilidades psíquicas.', 9, '2026-07-04 22:10:00'),
('Barulho no telhado', 'fenomenos-anomalos', 'Sem explicação', 'Residência no bairro norte', 'Passos foram ouvidos no telhado sem sinais de entrada.', 10, '2026-07-07 02:45:00'),
('Aura descontrolada', 'poderes-psiquicos', 'Resolvido', 'Parque municipal', 'Um paranormal perdeu o controle da aura. A situação foi estabilizada.', 1, '2026-07-09 15:40:00'),
('Possessão em comércio', 'espiritos-possessoes', 'Resolvido', 'Loja de conveniência', 'Um funcionário apresentou comportamento incomum associado a uma entidade.', 2, '2026-07-12 20:00:00'),
('Símbolos repetidos', 'organizacoes-psiquicas', 'Em investigação', 'Muros do bairro oeste', 'Símbolos idênticos surgiram em pontos próximos de relatos paranormais.', 3, '2026-07-16 09:20:00'),
('Vento em sala fechada', 'fenomenos-anomalos', 'Resolvido', 'Consultório abandonado', 'Correntes de ar anormais cessaram após inspeção energética.', 4, '2026-07-19 13:30:00'),
('Telepatia involuntária', 'poderes-psiquicos', 'Em investigação', 'Sala de aula', 'Estudante afirma ouvir pensamentos de colegas durante períodos de cansaço.', 5, '2026-07-22 12:10:00'),
('Entidade na ponte', 'espiritos-possessoes', 'Resolvido', 'Ponte sobre o rio', 'Uma figura translúcida aparecia ao anoitecer e foi encaminhada.', 6, '2026-07-26 19:15:00'),
('Interferência nos rádios', 'fenomenos-anomalos', 'Sem explicação', 'Estação de rádio local', 'Transmissões foram interrompidas por ruídos de origem desconhecida.', 7, '2026-07-30 23:00:00'),

-- Agosto (13)
('Quadro que se move', 'espiritos-possessoes', 'Resolvido', 'Galeria de arte', 'Uma pintura mudava de posição durante o fechamento da galeria.', 1, '2026-08-01 18:30:00'),
('Campo de energia', 'poderes-psiquicos', 'Em investigação', 'Terreno próximo à escola', 'Uma área apresenta resistência incomum à aproximação de objetos.', 2, '2026-08-03 14:00:00'),
('Culto da árvore gigante', 'organizacoes-psiquicas', 'Em investigação', 'Centro da Cidade do Tempero', 'Moradores passaram a participar de encontros em torno de uma árvore.', 3, '2026-08-05 17:45:00'),
('Elevador sem comando', 'fenomenos-anomalos', 'Resolvido', 'Edifício residencial', 'O elevador parava no andar desocupado. A anomalia cessou após vistoria.', 4, '2026-08-07 08:15:00'),
('Chamado no depósito', 'espiritos-possessoes', 'Resolvido', 'Depósito de materiais', 'Uma entidade ligada a objetos antigos foi identificada e removida.', 5, '2026-08-09 16:10:00'),
('Projeção astral', 'poderes-psiquicos', 'Em investigação', 'Clínica do bairro leste', 'Paciente relata perceber o ambiente mesmo durante o sono.', 6, '2026-08-11 10:30:00'),
('Recrutadores paranormais', 'organizacoes-psiquicas', 'Resolvido', 'Centro comercial', 'O grupo foi identificado e suas atividades foram interrompidas.', 7, '2026-08-14 18:40:00'),
('Eco impossível', 'fenomenos-anomalos', 'Sem explicação', 'Passagem subterrânea', 'O eco repete palavras diferentes das pronunciadas.', 8, '2026-08-16 20:20:00'),
('Espírito na sala de música', 'espiritos-possessoes', 'Resolvido', 'Escola Salt', 'Instrumentos tocavam sozinhos após o término das aulas.', 9, '2026-08-19 17:00:00'),
('Leitura de pensamentos', 'poderes-psiquicos', 'Resolvido', 'Cafeteria central', 'Uma habilidade telepática recém-descoberta causava desconforto. O usuário recebeu orientação.', 10, '2026-08-21 15:15:00'),
('Portal de luz verde', 'fenomenos-anomalos', 'Sem explicação', 'Beco próximo à estação', 'Uma abertura luminosa apareceu por poucos segundos.', 1, '2026-08-24 22:25:00'),
('Clube de médiuns', 'organizacoes-psiquicas', 'Resolvido', 'Centro comunitário', 'A investigação confirmou um grupo de estudos sem atividade hostil.', 2, '2026-08-27 18:00:00'),
('Boneca com aura', 'espiritos-possessoes', 'Resolvido', 'Antiquário', 'Uma boneca antiga acumulava energia espiritual residual.', 3, '2026-08-30 11:35:00'),

-- Setembro (9)
('Distorção no reflexo', 'fenomenos-anomalos', 'Sem explicação', 'Espelho de praça pública', 'O reflexo de pedestres parecia desaparecer por alguns instantes.', 4, '2026-09-02 20:15:00'),
('Barreira psíquica', 'poderes-psiquicos', 'Resolvido', 'Academia local', 'Uma barreira involuntária foi desativada com ajuda de um paranormal.', 5, '2026-09-05 19:30:00'),
('Espírito no cinema', 'espiritos-possessoes', 'Resolvido', 'Cinema desativado', 'Uma entidade permanecia próxima à antiga sala de projeção.', 6, '2026-09-08 21:00:00'),
('Símbolos de uma seita', 'organizacoes-psiquicas', 'Em investigação', 'Parque do bairro sul', 'Marcas encontradas nas árvores podem indicar reuniões clandestinas.', 7, '2026-09-11 09:45:00'),
('Objetos desaparecidos', 'fenomenos-anomalos', 'Sem explicação', 'Vestiário esportivo', 'Equipamentos desaparecem e reaparecem sem testemunhas.', 8, '2026-09-14 16:40:00'),
('Surto de energia', 'poderes-psiquicos', 'Resolvido', 'Quadra escolar', 'Um jovem gerou forte descarga psíquica durante um momento de ansiedade.', 9, '2026-09-17 12:20:00'),
('Presença no elevador', 'espiritos-possessoes', 'Em investigação', 'Hospital desativado', 'Sensores indicaram atividade espiritual recorrente no elevador.', 10, '2026-09-21 22:00:00'),
('Residência de paranormais', 'organizacoes-psiquicas', 'Em investigação', 'Condomínio periférico', 'Relatos de encontros frequentes motivaram uma investigação.', 1, '2026-09-25 19:10:00'),
('Temperatura incomum', 'fenomenos-anomalos', 'Resolvido', 'Casa de chá', 'Uma mudança de temperatura localizada cessou após a remoção de um objeto.', 2, '2026-09-28 14:50:00'),

-- Outubro (17)
('Aparição na escadaria', 'espiritos-possessoes', 'Resolvido', 'Prédio comercial', 'Uma presença foi percebida por funcionários no final do expediente.', 3, '2026-10-01 18:35:00'),
('Grupo de treinamento', 'organizacoes-psiquicas', 'Em investigação', 'Centro esportivo', 'Foi detectado um grupo que treina habilidades paranormais.', 4, '2026-10-03 16:20:00'),
('Telecinese no mercado', 'poderes-psiquicos', 'Resolvido', 'Mercado municipal', 'Produtos se moveram durante a manifestação de uma habilidade latente.', 5, '2026-10-05 11:10:00'),
('Sinal no céu', 'fenomenos-anomalos', 'Sem explicação', 'Observatório da cidade', 'Uma formação luminosa surgiu e desapareceu rapidamente.', 6, '2026-10-07 23:15:00'),
('Entidade no parquinho', 'espiritos-possessoes', 'Resolvido', 'Parque infantil', 'Balanços se moviam sem vento. A presença foi dispersada.', 7, '2026-10-09 19:25:00'),
('Visões compartilhadas', 'poderes-psiquicos', 'Em investigação', 'Escola Salt', 'Dois estudantes relataram a mesma visão simultaneamente.', 8, '2026-10-10 13:45:00'),
('Sede da Garra', 'organizacoes-psiquicas', 'Em investigação', 'Edifício industrial', 'Moradores relataram uma possível atividade ligada à organização Garra.', 9, '2026-10-12 20:00:00'),
('Porta que reaparece', 'fenomenos-anomalos', 'Sem explicação', 'Casa abandonada', 'Uma porta surge em uma parede que deveria estar vazia.', 10, '2026-10-14 18:20:00'),
('Espírito no trampolim', 'espiritos-possessoes', 'Resolvido', 'Centro recreativo', 'Sensação de presença persistente foi confirmada por inspeção.', 1, '2026-10-16 15:40:00'),
('Aura no dormitório', 'poderes-psiquicos', 'Resolvido', 'Alojamento estudantil', 'A manifestação energética de um jovem foi controlada.', 2, '2026-10-17 22:10:00'),
('Reunião da PSL', 'organizacoes-psiquicas', 'Resolvido', 'Centro comunitário', 'O encontro foi identificado como reunião pacífica de paranormais.', 3, '2026-10-19 14:00:00'),
('Passagem congelada', 'fenomenos-anomalos', 'Sem explicação', 'Passarela urbana', 'Apenas uma área da passarela apresentou temperatura abaixo do normal.', 4, '2026-10-21 06:50:00'),
('Fantasma no escritório', 'espiritos-possessoes', 'Resolvido', 'Edifício administrativo', 'Funcionários relatavam sombras perto de uma mesa vazia.', 5, '2026-10-23 19:30:00'),
('Empatia psíquica', 'poderes-psiquicos', 'Em investigação', 'Consultoria de Reigen', 'Cliente relata sentir emoções de pessoas que estão próximas.', 6, '2026-10-25 10:00:00'),
('Grupo de videntes', 'organizacoes-psiquicas', 'Em investigação', 'Galeria comercial', 'Um grupo oferece previsões relacionadas a manifestações paranormais.', 7, '2026-10-27 17:30:00'),
('Brilho no lago', 'fenomenos-anomalos', 'Sem explicação', 'Lago municipal', 'Um brilho esverdeado foi registrado sobre a superfície da água.', 8, '2026-10-29 21:20:00'),
('Possessão de objeto', 'espiritos-possessoes', 'Resolvido', 'Feira de antiguidades', 'Um relógio de bolso apresentava atividade espiritual.', 9, '2026-10-31 11:45:00'),

-- Novembro (14)
('Presença no metrô', 'espiritos-possessoes', 'Resolvido', 'Estação central', 'Passageiros relataram uma silhueta no último vagão.', 10, '2026-11-01 22:30:00'),
('Levitação no pátio', 'poderes-psiquicos', 'Resolvido', 'Escola Salt', 'Um estudante levitou durante uma manifestação espontânea.', 1, '2026-11-03 12:15:00'),
('Sinais de recrutamento', 'organizacoes-psiquicas', 'Em investigação', 'Praça do bairro leste', 'Panfletos anunciavam um treinamento de habilidades psíquicas.', 2, '2026-11-05 17:55:00'),
('Ruídos na antena', 'fenomenos-anomalos', 'Sem explicação', 'Torre de comunicação', 'Ruídos incomuns foram detectados em horários específicos.', 3, '2026-11-07 03:20:00'),
('Entidade no parque', 'espiritos-possessoes', 'Resolvido', 'Parque central', 'Uma entidade de baixa intensidade foi identificada e dispersada.', 4, '2026-11-09 18:10:00'),
('Manifestação telepática', 'poderes-psiquicos', 'Em investigação', 'Residência familiar', 'Membros de uma família relatam sonhos semelhantes.', 5, '2026-11-11 08:10:00'),
('Encontro de paranormais', 'organizacoes-psiquicas', 'Resolvido', 'Salão de eventos', 'A atividade observada consistia em uma reunião social.', 6, '2026-11-13 20:00:00'),
('Sombra em movimento', 'fenomenos-anomalos', 'Sem explicação', 'Beco comercial', 'Uma sombra foi registrada em vídeos sem pessoa correspondente.', 7, '2026-11-15 23:10:00'),
('Espírito no arquivo', 'espiritos-possessoes', 'Em investigação', 'Arquivo municipal', 'Uma presença parece vinculada a documentos antigos.', 8, '2026-11-17 16:30:00'),
('Campo de força', 'poderes-psiquicos', 'Resolvido', 'Centro de treinamento', 'Uma barreira psíquica inesperada foi desativada.', 9, '2026-11-18 15:45:00'),
('Grupo de investigação', 'organizacoes-psiquicas', 'Em investigação', 'Biblioteca pública', 'Pesquisadores foram vistos reunindo relatos de fenômenos paranormais.', 10, '2026-11-20 14:20:00'),
('Chuva localizada', 'fenomenos-anomalos', 'Sem explicação', 'Rua residencial', 'Uma chuva breve atingiu apenas um trecho de poucos metros.', 1, '2026-11-21 13:15:00'),
('Entidade na escola', 'espiritos-possessoes', 'Resolvido', 'Escola Salt - laboratório', 'Uma presença associada a objetos antigos foi neutralizada.', 2, '2026-11-23 17:10:00'),
('Pulso energético noturno', 'poderes-psiquicos', 'Em investigação', 'Bairro norte', 'Moradores sentiram um breve pulso de energia durante a noite.', 3, '2026-11-24 21:25:00');

-- 3. RESULTADOS DO EXAME
-- Quatro categorias de acertos, totalizando no máximo 12 por tentativa.
-- As views calculam automaticamente a nota e a porcentagem sobre 20 questões.
INSERT INTO resultado_exame
    (poderes_psiquicos, espiritos, organizacoes, personagens, fk_usuario, dt_exame)
VALUES
(2, 1, 2, 2, 1, '2026-06-04 19:00:00'),
(3, 2, 2, 3, 1, '2026-07-10 18:20:00'),
(4, 3, 2, 3, 1, '2026-11-14 17:30:00'),
(1, 2, 1, 2, 2, '2026-06-10 12:30:00'),
(2, 3, 2, 2, 2, '2026-08-05 15:00:00'),
(3, 3, 2, 3, 2, '2026-11-12 09:40:00'),
(3, 2, 1, 2, 3, '2026-06-13 16:15:00'),
(3, 3, 2, 3, 3, '2026-09-07 18:30:00'),
(3, 4, 2, 3, 3, '2026-11-22 11:00:00'),
(1, 1, 2, 1, 4, '2026-06-21 10:30:00'),
(2, 2, 3, 2, 4, '2026-08-14 15:10:00'),
(2, 3, 4, 2, 4, '2026-10-27 19:30:00'),
(2, 1, 1, 1, 5, '2026-07-04 14:20:00'),
(3, 2, 1, 2, 5, '2026-09-18 20:00:00'),
(4, 2, 2, 2, 5, '2026-11-19 18:00:00'),
(2, 2, 1, 3, 6, '2026-06-22 18:50:00'),
(2, 3, 1, 4, 6, '2026-08-26 13:20:00'),
(3, 3, 2, 4, 6, '2026-11-21 10:30:00'),
(1, 0, 1, 2, 7, '2026-07-13 09:10:00'),
(2, 1, 2, 2, 7, '2026-09-23 15:30:00'),
(2, 2, 3, 2, 7, '2026-11-15 19:50:00'),
(2, 3, 1, 1, 8, '2026-07-11 11:10:00'),
(3, 4, 2, 2, 8, '2026-10-11 12:45:00'),
(1, 1, 3, 2, 9, '2026-08-08 18:00:00'),
(2, 2, 4, 2, 9, '2026-11-09 16:30:00'),
(1, 1, 1, 1, 10, '2026-07-18 14:00:00'),
(2, 1, 2, 2, 10, '2026-08-18 18:00:00'),
(1, 2, 2, 3, 10, '2026-10-18 15:00:00'),
(3, 2, 2, 3, 10, '2026-11-23 19:00:00');

