-- VIEWS são consultas salvas no banco de dados. 
-- Elas são úteis para simplificar consultas complexas e para restringir o acesso a determinados dados.

-- -- Criando uma view

CREATE VIEW nome_da_view AS exemplo_de_view
SELECT nome_da_coluna1, nome_da_coluna2
FROM nome_da_tabela_numero_um 
INNER JOIN nome_da_outra_tabela
ON nome_da_tabela_numero_um.nome_da_coluna = nome_da_outra_tabela.nome_da_coluna;