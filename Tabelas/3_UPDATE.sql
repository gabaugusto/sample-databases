----------------------------------------------------
----------------------------------------------------
----------------------------------------------------
-- TABELAS

-- Evite sempre que possível atualizar registros de uma tabela sem os devidos cuidados.
-- Sempre faça um backup antes de atualizar registros de uma tabela.

-- Adicionando uma nova coluna

ALTER TABLE nome_da_tabela ADD nome_da_coluna tipo_da_coluna;

-- Alterando o tipo de uma coluna

ALTER TABLE nome_da_tabela ALTER COLUMN nome_da_coluna SET DATA TYPE tipo_da_coluna;

-- Renomeando uma coluna

ALTER TABLE nome_da_tabela RENAME COLUMN nome_da_coluna TO novo_nome_da_coluna;

-- Removendo uma coluna

ALTER TABLE nome_da_tabela DROP COLUMN nome_da_coluna;

----------------------------------------------------
----------------------------------------------------
----------------------------------------------------
-- Registros

-- Atualizando registros de uma tabela; 

UPDATE nome_da_tabela SET nome_da_coluna = valor WHERE nome_da_coluna = valor;

-- Atualizando registros de uma tabela com várias condições

UPDATE nome_da_tabela SET nome_da_coluna = valor WHERE nome_da_coluna1 = valor1 AND nome_da_coluna2 = valor2;

-- Atualizando registros de uma tabela com uma condição de comparação maior

UPDATE nome_da_tabela SET nome_da_coluna = valor WHERE nome_da_coluna > valor;