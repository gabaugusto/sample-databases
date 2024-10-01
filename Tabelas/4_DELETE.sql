-- APAGANDO TABELAS
-- Apagando uma tabela

DROP TABLE nome_da_tabela;

-- Apagando uma tabela se ela existir

DROP TABLE IF EXISTS nome_da_tabela;

-- Apagando todos os registros de uma tabela

DELETE FROM nome_da_tabela;

-- Apagando registros de uma tabela com uma condição

DELETE FROM nome_da_tabela WHERE nome_da_coluna = valor;

-- Apagando registros de uma tabela com várias condições

DELETE FROM nome_da_tabela WHERE nome_da_coluna1 = valor1 AND nome_da_coluna2 = valor2;

-- Apagando registros de uma tabela com uma condição de comparação maior

DELETE FROM nome_da_tabela WHERE nome_da_coluna > valor;