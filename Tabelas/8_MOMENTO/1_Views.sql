
-- Creating VIEWs
CREATE OR REPLACE VIEW `dados_funcionarios` AS
SELECT
  funcionarios.funcionario_id AS funcionario_id,
  CONCAT(funcionarios.primeiro_nome, ' ', funcionarios.sobrenome) AS 'funcionario_nome',
  funcionarios.telefone AS telefone,
  funcionarios.email AS email,
  funcionarios.data_contratacao AS data_contratacao,
  cargos.cargo_nome AS cargo,
  funcionarios.salario AS salario,
  cargos.min_salario AS min_salario,
  cargos.max_salario AS max_salario,
  departamentos.departamento_nome AS departamento,
  escritorios.escritorio_nome AS escritorio,
  escritorios.endereco AS endereco,
  paises.pais_nome AS pais,
  regioes.regiao_nome AS regiao

 FROM funcionarios

INNER JOIN cargos
  ON funcionarios.cargo_id = cargos.cargo_id
INNER JOIN departamentos
  ON funcionarios.departamento_id = departamentos.departamento_id
INNER JOIN escritorios
  ON departamentos.escritorio_id = escritorios.escritorio_id
INNER JOIN paises
  ON escritorios.pais_id = paises.pais_id
INNER JOIN regioes
  ON paises.regiao_id = regioes.regiao_id;

-- Creating VIEW dependentes
CREATE OR REPLACE VIEW `dados_dependentes` AS
SELECT
  CONCAT(dependentes.primeiro_nome, ' ', dependentes.sobrenome) AS 'dependente_nome',
  dependentes.relacionamento AS relacionamento,
  CONCAT(funcionarios.primeiro_nome, ' ', funcionarios.sobrenome) AS 'funcionario_nome'
 FROM dependentes
INNER JOIN funcionarios
  ON dependentes.funcionario_id = funcionarios.funcionario_id;

-- Creating VIEW custo escritorios
CREATE OR REPLACE VIEW `custos_escritorios` AS
SELECT
    suprimentos.suprimento_nome,
    suprimentos.quantidade_comprada AS quantidade,
    suprimentos.custo,
    escritorios.escritorio_nome
	FROM suprimentos
INNER JOIN escritorios
	ON suprimentos.escritorio_id = escritorios.escritorio_id;

-- Creating audit VIEW
CREATE OR REPLACE VIEW `relatorio_auditoria` AS
SELECT
    audit_log.log_acao as `acao`,
    audit_log.log_ts as `timestamp`,
    audit_log.log_id,
    audit_log.funcionario_id,
    audit_log.log_modulo AS modulo,
    audit_log.log_status AS status,
    audit_log.log_origem AS origem,
    audit_log.log_detalhes AS detalhes,
    CONCAT(funcionarios.primeiro_nome, ' ', funcionarios.sobrenome) AS 'funcionario_nome'
	FROM audit_log
INNER JOIN  funcionarios
	ON audit_log.funcionario_id = funcionarios.funcionario_id;

-- Creating vendas_report VIEW
CREATE OR REPLACE VIEW `relatorio_vendas` AS
SELECT
    vendas.venda_id as 'ticket',
    vendas.quantidade_vendida as 'quantidade_vendida',
    produtos.produto_nome as 'produto',
    produtos.produto_id as 'produto_id',
    produtos.produto_price as 'preco_unitario',
    vendas.venda_data,
    funcionarios.funcionario_id,
    CONCAT(funcionarios.primeiro_nome, ' ', funcionarios.sobrenome) AS 'funcionario_nome'
	FROM vendas
INNER JOIN funcionarios
	ON vendas.funcionario_id = funcionarios.funcionario_id
INNER JOIN produtos
	ON vendas.produto_id = produtos.produto_id;

  -- Creating vendas_report VIEW
CREATE OR REPLACE VIEW `vendas_funcionario_performance` AS
SELECT
  CONCAT(funcionarios.primeiro_nome, ' ', funcionarios.sobrenome) AS funcionario_nome,
  SUM(vendas.quantidade_vendida * CAST(produtos.produto_price AS DECIMAL(10, 2))) AS total_vendas
    FROM vendas
  INNER JOIN funcionarios ON vendas.funcionario_id = funcionarios.funcionario_id
  INNER JOIN produtos ON vendas.produto_id = produtos.produto_id
  GROUP BY funcionarios.funcionario_id, funcionarios.primeiro_nome, funcionarios.sobrenome;

-- Quem lidera cada heroi? Inclui funcionarios sem gerente.
CREATE OR REPLACE VIEW equipes_multiverso AS
SELECT
    f.funcionario_id,
    CONCAT(f.primeiro_nome, ' ', f.sobrenome) AS funcionario_nome,
    c.cargo_nome AS cargo,
    d.departamento_nome AS departamento,
    g.funcionario_id AS gerente_id,
    CONCAT(g.primeiro_nome, ' ', g.sobrenome) AS gerente_nome
FROM funcionarios f
INNER JOIN cargos c ON c.cargo_id = f.cargo_id
INNER JOIN departamentos d ON d.departamento_id = f.departamento_id
LEFT JOIN funcionarios g ON g.funcionario_id = f.gerente_id;

-- Folha salarial por departamento, incluindo equipes ainda sem funcionarios.
CREATE OR REPLACE VIEW folha_departamentos AS
SELECT
    d.departamento_id,
    d.departamento_nome,
    COUNT(f.funcionario_id) AS total_funcionarios,
    COALESCE(SUM(f.salario), 0) AS folha_salarial,
    ROUND(AVG(f.salario), 2) AS salario_medio,
    MIN(f.salario) AS menor_salario,
    MAX(f.salario) AS maior_salario
FROM departamentos d
LEFT JOIN funcionarios f ON f.departamento_id = d.departamento_id
GROUP BY d.departamento_id, d.departamento_nome;

-- Radar de salarios: compara cada funcionario com a faixa do cargo.
CREATE OR REPLACE VIEW radar_salarial AS
SELECT
    f.funcionario_id,
    CONCAT(f.primeiro_nome, ' ', f.sobrenome) AS funcionario_nome,
    c.cargo_nome AS cargo,
    f.salario,
    c.min_salario,
    c.max_salario,
    CASE
        WHEN c.min_salario IS NULL OR c.max_salario IS NULL THEN 'Faixa nao definida'
        WHEN f.salario < c.min_salario THEN 'Abaixo da faixa'
        WHEN f.salario > c.max_salario THEN 'Acima da faixa'
        ELSE 'Dentro da faixa'
    END AS situacao_salarial
FROM funcionarios f
INNER JOIN cargos c ON c.cargo_id = f.cargo_id;

-- Arsenal mais vendido: inclui produtos que ainda nao tiveram vendas.
-- Receita estimada com o preco atual do catalogo; nao ha preco historico por venda.
CREATE OR REPLACE VIEW arsenal_mais_vendido AS
SELECT
    p.produto_id,
    p.produto_nome,
    CAST(p.produto_price AS DECIMAL(10, 2)) AS preco_unitario,
    COUNT(v.venda_id) AS total_vendas,
    COALESCE(SUM(v.quantidade_vendida), 0) AS unidades_vendidas,
    COALESCE(SUM(v.quantidade_vendida * CAST(p.produto_price AS DECIMAL(10, 2))), 0) AS receita_estimada
FROM produtos p
LEFT JOIN vendas v ON v.produto_id = p.produto_id
GROUP BY p.produto_id, p.produto_nome, p.produto_price;

-- Evolucao mensal das vendas; meses sem vendas nao aparecem.
-- Valores estimados com os precos atuais do catalogo.
CREATE OR REPLACE VIEW vendas_mensais AS
SELECT
    EXTRACT(YEAR FROM v.venda_data) AS ano,
    EXTRACT(MONTH FROM v.venda_data) AS mes,
    COUNT(v.venda_id) AS total_vendas,
    SUM(v.quantidade_vendida) AS unidades_vendidas,
    COUNT(DISTINCT v.funcionario_id) AS vendedores_ativos,
    SUM(v.quantidade_vendida * CAST(p.produto_price AS DECIMAL(10, 2))) AS receita_estimada,
    ROUND(AVG(v.quantidade_vendida * CAST(p.produto_price AS DECIMAL(10, 2))), 2) AS ticket_medio_estimado
FROM vendas v
INNER JOIN produtos p ON p.produto_id = v.produto_id
GROUP BY EXTRACT(YEAR FROM v.venda_data), EXTRACT(MONTH FROM v.venda_data);

-- Exemplos de consultas (a ordenacao e definida ao consultar cada view):
-- SELECT * FROM equipes_multiverso WHERE gerente_id = 103;
-- SELECT * FROM folha_departamentos ORDER BY folha_salarial DESC;
-- SELECT * FROM radar_salarial WHERE situacao_salarial <> 'Dentro da faixa';
-- SELECT * FROM arsenal_mais_vendido ORDER BY unidades_vendidas DESC;
-- SELECT * FROM vendas_mensais ORDER BY ano, mes;

-- Selecting data from VIEW
SELECT * From dados_funcionarios;
