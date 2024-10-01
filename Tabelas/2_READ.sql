-- Comandos básicos de leitura

-- Selecionar todos os registros de uma tabela

SELECT * FROM nome_da_tabela;

-- Selecionar registros específicos de uma tabela

SELECT nome_da_coluna1, nome_da_coluna2 FROM nome_da_tabela;

-- Selecionar registros de uma tabela com uma condição

SELECT * FROM nome_da_tabela WHERE nome_da_coluna = valor;

-- Selecionar registros de uma tabela com várias condições

SELECT * FROM nome_da_tabela WHERE nome_da_coluna1 = valor1 AND nome_da_coluna2 = valor2;

-- Selecionar registros de uma tabela com uma condição de comparação de texto

SELECT * FROM nome_da_tabela WHERE nome_da_coluna LIKE '%valor%';

-- Selecionar registros de uma tabela com uma condição de comparação maior que 

SELECT * FROM nome_da_tabela WHERE nome_da_coluna > valor;

-- Selecionar registros de uma tabela com uma condição de comparação entre um intervalo

SELECT * FROM nome_da_tabela WHERE nome_da_coluna BETWEEN valor1 AND valor2;

-- Selecionar registros de uma tabela com uma condição de comparação em uma lista

SELECT * FROM nome_da_tabela WHERE nome_da_coluna IN (valor1, valor2, valor3);



-- Selecionar registros de uma tabela com uma condição de comparação de texto nula

SELECT * FROM nome_da_tabela WHERE nome_da_coluna IS NULL;

-- Selecionar registros de uma tabela com uma condição de comparação de texto não nula

SELECT * FROM nome_da_tabela WHERE nome_da_coluna IS NOT NULL;

-- Selecionar registros de uma tabela com uma condição de comparação de texto ignorando maiúsculas e minúsculas

SELECT * FROM nome_da_tabela WHERE UPPER(nome_da_coluna) LIKE '%VALOR%';


-- ###########################################################################################
-- ###########################################################################################
-- ###########################################################################################

-- JOINS

-- Selecionar registros de duas tabelas

SELECT * FROM nome_da_tabela_numero_um
INNER JOIN nome_da_outra_tabela
ON nome_da_tabela_numero_um.nome_da_coluna = nome_da_outra_tabela.nome_da_coluna;

-- Selecionar registros de duas tabelas com uma condição

SELECT * FROM nome_da_tabela_numero_um
INNER JOIN nome_da_outra_tabela
ON nome_da_tabela_numero_um.nome_da_coluna = nome_da_outra_tabela.nome_da_coluna
WHERE nome_da_tabela_numero_um.nome_da_coluna = valor;

-- Diferença entre INNER JOIN e LEFT JOIN

-- INNER JOIN: Retorna apenas os registros que possuem correspondência nas duas tabelas
-- LEFT JOIN: Retorna todos os registros da tabela da esquerda e os registros correspondentes da tabela da direita

-- Selecionar registros de duas tabelas com LEFT JOIN

SELECT * FROM nome_da_tabela_numero_um
LEFT JOIN nome_da_outra_tabela
ON nome_da_tabela_numero_um.nome_da_coluna = nome_da_outra_tabela.nome_da_coluna;