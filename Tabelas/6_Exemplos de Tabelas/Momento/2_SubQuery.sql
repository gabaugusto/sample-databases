
-- Selecionando dados através de uma subconsulta

SELECT funcionarios.primeiro_nome, funcionarios.sobrenome
FROM funcionarios 
WHERE ocupacao_id = 
    (SELECT ocupacao_id
     FROM ocupacoes
     WHERE ocupacao_nome = 'Contador');
