-- Views para o modelo Momento (MySQL 8.0+).
-- A receita usa itens_venda.preco_unitario: este é o preço histórico da transação.

CREATE OR REPLACE VIEW dados_funcionarios AS
SELECT f.funcionario_id, CONCAT(f.primeiro_nome, ' ', f.sobrenome) AS funcionario_nome,
       f.telefone, f.email, f.data_contratacao, sf.nome AS situacao, f.salario, f.moeda_salario,
       c.cargo_nome AS cargo, c.min_salario, c.max_salario,
       d.departamento_nome AS departamento, e.escritorio_nome AS escritorio, e.endereco,
       p.pais_nome AS pais, r.regiao_nome AS regiao
FROM funcionarios f
JOIN cargos c ON c.cargo_id = f.cargo_id
JOIN departamentos d ON d.departamento_id = f.departamento_id
JOIN escritorios e ON e.escritorio_id = d.escritorio_id
JOIN paises p ON p.pais_id = e.pais_id
JOIN regioes r ON r.regiao_id = p.regiao_id
JOIN status_funcionario sf ON sf.status_funcionario_id = f.status_funcionario_id;

CREATE OR REPLACE VIEW dados_dependentes AS
SELECT d.dependente_id, CONCAT(d.primeiro_nome, ' ', d.sobrenome) AS dependente_nome,
       d.relacionamento, f.funcionario_id,
       CONCAT(f.primeiro_nome, ' ', f.sobrenome) AS funcionario_nome
FROM dependentes d JOIN funcionarios f ON f.funcionario_id = d.funcionario_id;

CREATE OR REPLACE VIEW custos_escritorios AS
SELECT e.escritorio_id, e.escritorio_nome, s.suprimento_id, s.referencia_compra,
       s.suprimento_nome, s.quantidade_estoque, s.custo_unitario, s.moeda, s.data_compra,
       s.quantidade_estoque * s.custo_unitario AS custo_total_item
FROM suprimentos s JOIN escritorios e ON e.escritorio_id = s.escritorio_id;

-- LEFT JOIN preserva eventos de auditoria sem funcionário associado.
CREATE OR REPLACE VIEW relatorio_auditoria AS
SELECT a.log_id, a.log_acao AS acao, a.log_ts AS momento, ma.nome AS modulo,
       sa.nome AS status, a.log_origem AS origem, a.log_detalhes AS detalhes,
       a.funcionario_id, CONCAT(f.primeiro_nome, ' ', f.sobrenome) AS funcionario_nome
FROM audit_log a
JOIN modulos_auditoria ma ON ma.modulo_auditoria_id = a.modulo_auditoria_id
JOIN status_auditoria sa ON sa.status_auditoria_id = a.status_auditoria_id
LEFT JOIN funcionarios f ON f.funcionario_id = a.funcionario_id;

-- Uma linha por item vendido; ticket e dados da venda se repetem quando há vários itens.
CREATE OR REPLACE VIEW relatorio_vendas AS
SELECT v.venda_id AS ticket, v.referencia_origem, v.data_venda, cv.nome AS canal, sv.nome AS status_venda,
       i.numero_item, i.quantidade, i.preco_unitario, i.moeda,
       i.quantidade * i.preco_unitario AS receita_item,
       p.produto_id, p.sku, p.produto_nome AS produto, f.funcionario_id,
       CONCAT(f.primeiro_nome, ' ', f.sobrenome) AS funcionario_nome
FROM vendas v
JOIN itens_venda i ON i.venda_id = v.venda_id
JOIN produtos p ON p.produto_id = i.produto_id
JOIN funcionarios f ON f.funcionario_id = v.funcionario_id
JOIN canais_venda cv ON cv.canal_venda_id = v.canal_venda_id
JOIN status_venda sv ON sv.status_venda_id = v.status_venda_id;

CREATE OR REPLACE VIEW vendas_funcionario_performance AS
SELECT f.funcionario_id, CONCAT(f.primeiro_nome, ' ', f.sobrenome) AS funcionario_nome,
       COUNT(DISTINCT v.venda_id) AS total_vendas, COALESCE(SUM(i.quantidade), 0) AS unidades_vendidas,
       COALESCE(SUM(i.quantidade * i.preco_unitario), 0) AS receita_total
FROM funcionarios f
LEFT JOIN vendas v ON v.funcionario_id = f.funcionario_id
LEFT JOIN itens_venda i ON i.venda_id = v.venda_id
GROUP BY f.funcionario_id, f.primeiro_nome, f.sobrenome;

CREATE OR REPLACE VIEW equipes_multiverso AS
SELECT f.funcionario_id, CONCAT(f.primeiro_nome, ' ', f.sobrenome) AS funcionario_nome,
       c.cargo_nome AS cargo, d.departamento_nome AS departamento, g.funcionario_id AS gerente_id,
       CONCAT(g.primeiro_nome, ' ', g.sobrenome) AS gerente_nome
FROM funcionarios f JOIN cargos c ON c.cargo_id = f.cargo_id
JOIN departamentos d ON d.departamento_id = f.departamento_id
LEFT JOIN funcionarios g ON g.funcionario_id = f.gerente_id;

CREATE OR REPLACE VIEW folha_departamentos AS
SELECT d.departamento_id, d.departamento_nome, COUNT(f.funcionario_id) AS total_funcionarios,
       COALESCE(SUM(f.salario), 0) AS folha_salarial, ROUND(AVG(f.salario), 2) AS salario_medio,
       MIN(f.salario) AS menor_salario, MAX(f.salario) AS maior_salario
FROM departamentos d LEFT JOIN funcionarios f ON f.departamento_id = d.departamento_id
GROUP BY d.departamento_id, d.departamento_nome;

CREATE OR REPLACE VIEW radar_salarial AS
SELECT f.funcionario_id, CONCAT(f.primeiro_nome, ' ', f.sobrenome) AS funcionario_nome,
       c.cargo_nome AS cargo, f.salario, f.moeda_salario, c.min_salario, c.max_salario,
       CASE WHEN f.moeda_salario <> 'USD' THEN 'Moeda diferente da faixa'
            WHEN f.salario < c.min_salario THEN 'Abaixo da faixa'
            WHEN f.salario > c.max_salario THEN 'Acima da faixa'
            ELSE 'Dentro da faixa' END AS situacao_salarial
FROM funcionarios f JOIN cargos c ON c.cargo_id = f.cargo_id;

CREATE OR REPLACE VIEW arsenal_mais_vendido AS
SELECT p.produto_id, p.sku, p.produto_nome, p.preco_catalogo, p.moeda,
       COUNT(DISTINCT v.venda_id) AS total_vendas, COALESCE(SUM(i.quantidade), 0) AS unidades_vendidas,
       COALESCE(SUM(i.quantidade * i.preco_unitario), 0) AS receita_total
FROM produtos p LEFT JOIN itens_venda i ON i.produto_id = p.produto_id
LEFT JOIN vendas v ON v.venda_id = i.venda_id
GROUP BY p.produto_id, p.sku, p.produto_nome, p.preco_catalogo, p.moeda;

CREATE OR REPLACE VIEW vendas_mensais AS
SELECT YEAR(v.data_venda) AS ano, MONTH(v.data_venda) AS mes,
       COUNT(DISTINCT v.venda_id) AS total_vendas, SUM(i.quantidade) AS unidades_vendidas,
       COUNT(DISTINCT v.funcionario_id) AS vendedores_ativos,
       SUM(i.quantidade * i.preco_unitario) AS receita_total,
       ROUND(SUM(i.quantidade * i.preco_unitario) / COUNT(DISTINCT v.venda_id), 2) AS ticket_medio
FROM vendas v JOIN itens_venda i ON i.venda_id = v.venda_id
GROUP BY YEAR(v.data_venda), MONTH(v.data_venda);

-- Indicadores de aprendizagem e impacto; turmas sem matrícula também aparecem.
CREATE OR REPLACE VIEW impacto_educacional AS
SELECT c.curso_id, c.curso_nome, t.turma_id, t.codigo AS turma,
       CONCAT(f.primeiro_nome, ' ', f.sobrenome) AS professor,
       COUNT(m.matricula_id) AS matriculas,
       SUM(sm.nome = 'CONCLUIDA') AS concluintes,
       SUM(m.certificado_emitido) AS certificados_emitidos,
       ROUND(AVG(m.nota_final), 2) AS nota_media,
       COUNT(DISTINCT vt.aluno_id) AS talentos_vinculados
FROM cursos c
JOIN turmas t ON t.curso_id = c.curso_id
JOIN funcionarios f ON f.funcionario_id = t.professor_funcionario_id
LEFT JOIN matriculas m ON m.turma_id = t.turma_id
LEFT JOIN status_matricula sm ON sm.status_matricula_id = m.status_matricula_id
LEFT JOIN vinculos_talentos vt ON vt.aluno_id = m.aluno_id
GROUP BY c.curso_id, c.curso_nome, t.turma_id, t.codigo, f.funcionario_id, f.primeiro_nome, f.sobrenome;

-- Perfil comercial, preservando vendas legadas ainda não associadas a cliente.
CREATE OR REPLACE VIEW clientes_vendas AS
SELECT c.cliente_id, c.nome AS cliente, c.email,
       COUNT(v.venda_id) AS total_vendas,
       MAX(v.data_venda) AS ultima_venda,
       COALESCE(SUM(i.quantidade * i.preco_unitario), 0) AS receita_total
FROM clientes c
LEFT JOIN vendas v ON v.cliente_id = c.cliente_id
LEFT JOIN itens_venda i ON i.venda_id = v.venda_id
GROUP BY c.cliente_id, c.nome, c.email;
