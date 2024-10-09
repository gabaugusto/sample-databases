
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
    suprimentos.quantidade, 
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
    CONCAT(funcionarios.primeiro_nome, ' ', funcionarios.sobrenome) AS 'funcionario_nome'
	FROM audit_log 
INNER JOIN  funcionarios 
	ON audit_log.funcionario_id = funcionarios.funcionario_id;
        
-- Creating vendas_report VIEW 
CREATE OR REPLACE VIEW `relatorio_vendas` AS
SELECT 
    vendas.venda_id as 'ticket', 
    vendas.quantidade as 'quantidade_vendida', 
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
  SUM(vendas.quantidade * produtos.produto_price) AS total_vendas
    FROM vendas
  INNER JOIN funcionarios ON vendas.funcionario_id = funcionarios.funcionario_id
  INNER JOIN produtos ON vendas.produto_id = produtos.produto_id
  GROUP BY funcionarios.funcionario_id; 

-- Selecting data from VIEW
SELECT * From dados_funcionarios;