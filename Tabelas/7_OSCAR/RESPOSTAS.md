# Oscar - Respostas SQL

Este arquivo contém as respostas em SQL para todos os exercícios do arquivo EXERCICIOS.md.

---

## 📊 Nível 1: Primeiros Passos

**1.1** Quantos registros existem na tabela `indicados_ao_oscar`?
```sql
SELECT COUNT(*) AS total_registros
FROM indicados_ao_oscar;
```

**1.2** Quais são as diferentes categorias de premiação que existem no banco de dados?
```sql
SELECT DISTINCT categoria
FROM indicados_ao_oscar
ORDER BY categoria;
```

**1.3** Qual foi o primeiro ano de cerimônia do Oscar registrado na base?
```sql
SELECT MIN(ano_cerimonia) AS primeiro_ano
FROM indicados_ao_oscar;
```

**1.4** Qual foi o último ano de cerimônia registrado na base?
```sql
SELECT MAX(ano_cerimonia) AS ultimo_ano
FROM indicados_ao_oscar;
```

**1.5** Quantas cerimônias (edições) do Oscar estão registradas no total?
```sql
SELECT COUNT(DISTINCT edicao_cerimonia) AS total_cerimonias
FROM indicados_ao_oscar;
```

**1.6** Liste as primeiras 10 linhas da tabela para entender sua estrutura.
```sql
SELECT *
FROM indicados_ao_oscar
LIMIT 10;
```

**1.7** Atualize os registros da tabela com os dados do Oscar 2025.
```sql
-- Exemplo de inserção de dados do Oscar 2025
-- (Substitua pelos dados reais quando disponíveis)
INSERT INTO indicados_ao_oscar(ano_filmagem, ano_cerimonia, edicao_cerimonia, categoria, nome_indicado, nome_filme, vencedor)
VALUES
(2024, 2025, 97, 'BEST PICTURE', NULL, 'Oppenheimer', true),
(2024, 2025, 97, 'ACTOR', 'Cillian Murphy', 'Oppenheimer', true),
(2024, 2025, 97, 'ACTRESS', 'Emma Stone', 'Poor Things', true);
```

---

## 🎬 Nível 2: Explorando Categorias

**2.1** Quantas indicações existem para cada categoria?
```sql
SELECT categoria, COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
GROUP BY categoria
ORDER BY total_indicacoes DESC;
```

**2.2** Qual categoria teve mais indicações ao longo da história do Oscar?
```sql
SELECT categoria, COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
GROUP BY categoria
ORDER BY total_indicacoes DESC
LIMIT 1;
```

**2.3** Qual categoria teve menos indicações ao longo da história?
```sql
SELECT categoria, COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
GROUP BY categoria
ORDER BY total_indicacoes ASC
LIMIT 1;
```

**2.4** A partir de que ano a categoria "ACTRESS" deixou de existir?
```sql
SELECT MAX(ano_cerimonia) AS ultimo_ano_actress
FROM indicados_ao_oscar
WHERE categoria = 'ACTRESS';
```

**2.5** Quais categorias existiam na primeira cerimônia (1928) mas não existem nas últimas 5 cerimônias?
```sql
-- Categorias da primeira cerimônia
SELECT DISTINCT categoria
FROM indicados_ao_oscar
WHERE ano_cerimonia = 1928
  AND categoria NOT IN (
    SELECT DISTINCT categoria
    FROM indicados_ao_oscar
    WHERE ano_cerimonia >= (SELECT MAX(ano_cerimonia) - 4 FROM indicados_ao_oscar)
  )
ORDER BY categoria;
```

**2.6** Liste todas as categorias que contêm a palavra "DIRECTING" no nome.
```sql
SELECT DISTINCT categoria
FROM indicados_ao_oscar
WHERE categoria LIKE '%DIRECTING%'
ORDER BY categoria;
```

**2.7** Quantas categorias diferentes existem na base de dados?
```sql
SELECT COUNT(DISTINCT categoria) AS total_categorias
FROM indicados_ao_oscar;
```

---

## 🌟 Nível 3: Atores e Atrizes Famosos

### Natalie Portman

**3.1** Quantas vezes Natalie Portman foi indicada ao Oscar?
```sql
SELECT COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
WHERE nome_indicado = 'Natalie Portman';
```

**3.2** Quantos Oscars Natalie Portman ganhou?
```sql
SELECT COUNT(*) AS total_vitorias
FROM indicados_ao_oscar
WHERE nome_indicado = 'Natalie Portman'
  AND vencedor = true;
```

**3.3** Em quais anos e por quais filmes Natalie Portman foi indicada?
```sql
SELECT ano_cerimonia, nome_filme
FROM indicados_ao_oscar
WHERE nome_indicado = 'Natalie Portman'
ORDER BY ano_cerimonia;
```

**3.4** Liste todas as indicações de Natalie Portman mostrando: ano, categoria, filme e se venceu.
```sql
SELECT
    ano_cerimonia,
    categoria,
    nome_filme,
    vencedor
FROM indicados_ao_oscar
WHERE nome_indicado = 'Natalie Portman'
ORDER BY ano_cerimonia;
```

### Viola Davis

**3.5** Quantas vezes Viola Davis foi indicada ao Oscar?
```sql
SELECT COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
WHERE nome_indicado = 'Viola Davis';
```

**3.6** Quantos Oscars Viola Davis ganhou?
```sql
SELECT COUNT(*) AS total_vitorias
FROM indicados_ao_oscar
WHERE nome_indicado = 'Viola Davis'
  AND vencedor = true;
```

**3.7** Por quais filmes Viola Davis foi indicada?
```sql
SELECT DISTINCT nome_filme, ano_cerimonia
FROM indicados_ao_oscar
WHERE nome_indicado = 'Viola Davis'
ORDER BY ano_cerimonia;
```

### Amy Adams

**3.8** Amy Adams já ganhou algum Oscar?
```sql
SELECT COUNT(*) AS total_vitorias
FROM indicados_ao_oscar
WHERE nome_indicado = 'Amy Adams'
  AND vencedor = true;
```

**3.9** Quantas vezes Amy Adams foi indicada sem ganhar?
```sql
SELECT COUNT(*) AS indicacoes_sem_vitoria
FROM indicados_ao_oscar
WHERE nome_indicado = 'Amy Adams'
  AND vencedor = false;
```

### Denzel Washington

**3.10** Denzel Washington já ganhou algum Oscar?
```sql
SELECT COUNT(*) AS total_vitorias
FROM indicados_ao_oscar
WHERE nome_indicado = 'Denzel Washington'
  AND vencedor = true;
```

**3.11** Quantas vezes Denzel Washington foi indicado ao Oscar?
```sql
SELECT COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
WHERE nome_indicado = 'Denzel Washington';
```

**3.12** Liste todos os Oscars que Denzel Washington ganhou.
```sql
SELECT
    ano_cerimonia,
    categoria,
    nome_filme
FROM indicados_ao_oscar
WHERE nome_indicado = 'Denzel Washington'
  AND vencedor = true
ORDER BY ano_cerimonia;
```

---

## 🏆 Nível 4: Vencedores Históricos

**4.1** Quem ganhou o primeiro Oscar para Melhor Atriz (ACTRESS)?
```sql
SELECT
    nome_indicado,
    ano_cerimonia,
    nome_filme
FROM indicados_ao_oscar
WHERE categoria = 'ACTRESS'
  AND vencedor = true
ORDER BY ano_cerimonia ASC
LIMIT 1;
```

**4.2** Quem ganhou o primeiro Oscar para Melhor Ator (ACTOR)?
```sql
SELECT
    nome_indicado,
    ano_cerimonia,
    nome_filme
FROM indicados_ao_oscar
WHERE categoria = 'ACTOR'
  AND vencedor = true
ORDER BY ano_cerimonia ASC
LIMIT 1;
```

**4.3** Quantos vencedores (registros com vencedor = TRUE) existem ao todo na base de dados?
```sql
SELECT COUNT(*) AS total_vencedores
FROM indicados_ao_oscar
WHERE vencedor = true;
```

**4.4** Liste todos os filmes que ganharam o Oscar de Melhor Filme.
```sql
SELECT
    ano_cerimonia,
    nome_filme
FROM indicados_ao_oscar
WHERE (categoria = 'OUTSTANDING PICTURE' OR categoria = 'BEST PICTURE')
  AND vencedor = true
ORDER BY ano_cerimonia;
```

**4.5** Quantos filmes diferentes já ganharam algum Oscar?
```sql
SELECT COUNT(DISTINCT nome_filme) AS total_filmes_vencedores
FROM indicados_ao_oscar
WHERE vencedor = true;
```

**4.6** Liste os 10 primeiros vencedores do Oscar na história.
```sql
SELECT
    ano_cerimonia,
    categoria,
    nome_indicado,
    nome_filme
FROM indicados_ao_oscar
WHERE vencedor = true
ORDER BY ano_cerimonia, categoria
LIMIT 10;
```

---

## 🎭 Nível 5: Análise de Indicações

**5.1** Quais atores/atrizes foram indicados mais de uma vez?
```sql
SELECT
    nome_indicado,
    COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
WHERE nome_indicado IS NOT NULL
GROUP BY nome_indicado
HAVING COUNT(*) > 1
ORDER BY total_indicacoes DESC;
```

**5.2** Qual ator ou atriz tem o maior número de indicações na história do Oscar?
```sql
SELECT
    nome_indicado,
    COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
WHERE nome_indicado IS NOT NULL
GROUP BY nome_indicado
ORDER BY total_indicacoes DESC
LIMIT 1;
```

**5.3** Quais atores foram indicados mais de 3 vezes mas nunca ganharam?
```sql
SELECT
    nome_indicado,
    COUNT(*) AS total_indicacoes,
    SUM(CASE WHEN vencedor = true THEN 1 ELSE 0 END) AS total_vitorias
FROM indicados_ao_oscar
WHERE nome_indicado IS NOT NULL
GROUP BY nome_indicado
HAVING COUNT(*) > 3 AND SUM(CASE WHEN vencedor = true THEN 1 ELSE 0 END) = 0
ORDER BY total_indicacoes DESC;
```

**5.4** Encontre todos os artistas que têm pelo menos 2 indicações.
```sql
SELECT
    nome_indicado,
    COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
WHERE nome_indicado IS NOT NULL
GROUP BY nome_indicado
HAVING COUNT(*) >= 2
ORDER BY total_indicacoes DESC;
```

**5.5** Quantos indicados únicos (nomes diferentes) existem na história do Oscar?
```sql
SELECT COUNT(DISTINCT nome_indicado) AS total_indicados_unicos
FROM indicados_ao_oscar
WHERE nome_indicado IS NOT NULL;
```

**5.6** Qual a média de indicações por indicado?
```sql
SELECT AVG(total_indicacoes) AS media_indicacoes
FROM (
    SELECT COUNT(*) AS total_indicacoes
    FROM indicados_ao_oscar
    WHERE nome_indicado IS NOT NULL
    GROUP BY nome_indicado
) AS subquery;
```

---

## 🎥 Nível 6: Análise de Filmes

### Toy Story

**6.1** A série de filmes Toy Story ganhou Oscars em quais anos?
```sql
SELECT DISTINCT ano_cerimonia
FROM indicados_ao_oscar
WHERE nome_filme LIKE '%Toy Story%'
  AND vencedor = true
ORDER BY ano_cerimonia;
```

**6.2** Quantas indicações a franquia Toy Story recebeu no total?
```sql
SELECT COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
WHERE nome_filme LIKE '%Toy Story%';
```

**6.3** Em quais categorias os filmes Toy Story foram indicados?
```sql
SELECT DISTINCT categoria
FROM indicados_ao_oscar
WHERE nome_filme LIKE '%Toy Story%'
ORDER BY categoria;
```

### Crash

**6.4** Em qual edição do Oscar o filme "Crash" concorreu?
```sql
SELECT DISTINCT ano_cerimonia, edicao_cerimonia
FROM indicados_ao_oscar
WHERE nome_filme = 'Crash';
```

**6.5** Quantas indicações o filme "Crash" recebeu?
```sql
SELECT COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
WHERE nome_filme = 'Crash';
```

**6.6** "Crash" ganhou o Oscar de Melhor Filme?
```sql
SELECT
    nome_filme,
    categoria,
    vencedor
FROM indicados_ao_oscar
WHERE nome_filme = 'Crash'
  AND (categoria = 'BEST PICTURE' OR categoria = 'OUTSTANDING PICTURE');
```

### Central do Brasil

**6.7** O filme "Central do Brasil" aparece no banco de dados?
```sql
SELECT COUNT(*) AS aparece
FROM indicados_ao_oscar
WHERE nome_filme LIKE '%Central%Brasil%';
```

**6.8** Se sim, quantas indicações "Central do Brasil" recebeu e em quais categorias?
```sql
SELECT
    categoria,
    COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
WHERE nome_filme LIKE '%Central%Brasil%'
GROUP BY categoria;
```

**6.9** Liste todos os filmes que contêm "Brasil" no nome.
```sql
SELECT DISTINCT nome_filme
FROM indicados_ao_oscar
WHERE nome_filme LIKE '%Brasil%'
ORDER BY nome_filme;
```

---

## 📅 Nível 7: Análise Temporal

**7.1** Quantas indicações aconteceram por década?
```sql
SELECT
    FLOOR(ano_cerimonia/10)*10 AS decada,
    COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
GROUP BY FLOOR(ano_cerimonia/10)*10
ORDER BY decada;
```

**7.2** Em qual década houve o maior número de indicações?
```sql
SELECT
    FLOOR(ano_cerimonia/10)*10 AS decada,
    COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
GROUP BY FLOOR(ano_cerimonia/10)*10
ORDER BY total_indicacoes DESC
LIMIT 1;
```

**7.3** Quantas categorias únicas existiam em cada década?
```sql
SELECT
    FLOOR(ano_cerimonia/10)*10 AS decada,
    COUNT(DISTINCT categoria) AS total_categorias
FROM indicados_ao_oscar
GROUP BY FLOOR(ano_cerimonia/10)*10
ORDER BY decada;
```

**7.4** Qual foi o ano com o maior número de indicações registradas?
```sql
SELECT
    ano_cerimonia,
    COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
GROUP BY ano_cerimonia
ORDER BY total_indicacoes DESC
LIMIT 1;
```

**7.5** Quantas indicações houve nos anos 2000 (entre 2000 e 2009)?
```sql
SELECT COUNT(*) AS total_indicacoes_anos_2000
FROM indicados_ao_oscar
WHERE ano_cerimonia BETWEEN 2000 AND 2009;
```

**7.6** Compare o número de indicações da primeira década (1920s) com a última década disponível.
```sql
SELECT
    'Anos 1920' AS periodo,
    COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
WHERE ano_cerimonia BETWEEN 1920 AND 1929
UNION ALL
SELECT
    'Última década' AS periodo,
    COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
WHERE ano_cerimonia >= (SELECT MAX(ano_cerimonia) - 9 FROM indicados_ao_oscar);
```

---

## 🔄 Nível 8: Operações de Atualização e Inserção

**8.1** Insira no banco 3 filmes fictícios que nunca foram nomeados ao Oscar.
```sql
INSERT INTO indicados_ao_oscar(ano_filmagem, ano_cerimonia, edicao_cerimonia, categoria, nome_indicado, nome_filme, vencedor)
VALUES
(2024, 2025, 97, 'BEST PICTURE', NULL, 'Filme Fictício 1', false),
(2024, 2025, 97, 'BEST PICTURE', NULL, 'Filme Fictício 2', false),
(2024, 2025, 97, 'BEST PICTURE', NULL, 'Filme Fictício 3', false);
```

**8.2** Atualize o nome de um filme específico.
```sql
-- Exemplo: corrigir um erro de digitação
-- Primeiro, verifique o filme com SELECT
SELECT * FROM indicados_ao_oscar WHERE nome_filme = 'Nome Errado';

-- Depois faça a correção
UPDATE indicados_ao_oscar
SET nome_filme = 'Nome Correto'
WHERE nome_filme = 'Nome Errado';
```

**8.3** Verifique quantos registros têm vencedor como TRUE e quantos como FALSE.
```sql
SELECT
    vencedor,
    COUNT(*) AS total
FROM indicados_ao_oscar
GROUP BY vencedor;
```

**8.4** Adicione uma nova categoria fictícia com alguns indicados do ano 2024.
```sql
INSERT INTO indicados_ao_oscar(ano_filmagem, ano_cerimonia, edicao_cerimonia, categoria, nome_indicado, nome_filme, vencedor)
VALUES
(2023, 2024, 96, 'BEST STREAMING CONTENT', 'Indicado 1', 'Filme Streaming 1', false),
(2023, 2024, 96, 'BEST STREAMING CONTENT', 'Indicado 2', 'Filme Streaming 2', true);
```

**8.5** Delete todos os registros que você inseriu nos exercícios anteriores.
```sql
-- CUIDADO: use WHERE criteriosamente!
DELETE FROM indicados_ao_oscar
WHERE nome_filme IN ('Filme Fictício 1', 'Filme Fictício 2', 'Filme Fictício 3', 'Filme Streaming 1', 'Filme Streaming 2');
```

**8.6** Conte quantos registros têm `nome_filme` como NULL.
```sql
SELECT COUNT(*) AS total_sem_nome_filme
FROM indicados_ao_oscar
WHERE nome_filme IS NULL;
```

---

## 🎯 Nível 9: Questões Históricas e Sociais

### Representatividade

**9.1** Em que ano Sidney Poitier foi indicado ao Oscar? Por qual filme?
```sql
SELECT
    ano_cerimonia,
    nome_filme,
    categoria
FROM indicados_ao_oscar
WHERE nome_indicado = 'Sidney Poitier'
ORDER BY ano_cerimonia
LIMIT 1;
```

**9.2** Sidney Poitier ganhou o Oscar nessa indicação?
```sql
SELECT
    ano_cerimonia,
    nome_filme,
    categoria,
    vencedor
FROM indicados_ao_oscar
WHERE nome_indicado = 'Sidney Poitier'
ORDER BY ano_cerimonia;
```

**9.3** Liste todas as indicações de Sidney Poitier na história do Oscar.
```sql
SELECT
    ano_cerimonia,
    categoria,
    nome_filme,
    vencedor
FROM indicados_ao_oscar
WHERE nome_indicado = 'Sidney Poitier'
ORDER BY ano_cerimonia;
```

**9.4** Quantos registros de indicações ao Oscar existem antes de 1950?
```sql
SELECT COUNT(*) AS total_indicacoes_antes_1950
FROM indicados_ao_oscar
WHERE ano_cerimonia < 1950;
```

### Coincidências

**9.5** Denzel Washington e Jamie Foxx já concorreram ao Oscar no mesmo ano?
```sql
SELECT DISTINCT a.ano_cerimonia
FROM indicados_ao_oscar a
INNER JOIN indicados_ao_oscar b
    ON a.ano_cerimonia = b.ano_cerimonia
WHERE a.nome_indicado = 'Denzel Washington'
  AND b.nome_indicado = 'Jamie Foxx'
ORDER BY a.ano_cerimonia;
```

**9.6** Liste os filmes que ganharam mais de 3 Oscars na mesma cerimônia.
```sql
SELECT
    nome_filme,
    ano_cerimonia,
    COUNT(*) AS total_oscars
FROM indicados_ao_oscar
WHERE vencedor = true
GROUP BY nome_filme, ano_cerimonia
HAVING COUNT(*) > 3
ORDER BY total_oscars DESC;
```

**9.7** Encontre casos onde o mesmo filme aparece em mais de 5 categorias na mesma cerimônia.
```sql
SELECT
    nome_filme,
    ano_cerimonia,
    COUNT(DISTINCT categoria) AS total_categorias
FROM indicados_ao_oscar
GROUP BY nome_filme, ano_cerimonia
HAVING COUNT(DISTINCT categoria) > 5
ORDER BY total_categorias DESC;
```

---

## 🔍 Nível 10: Análise Avançada

**10.1** Liste os filmes que ganharam tanto o Oscar de Melhor Filme quanto aparecem em outras categorias vencedoras na mesma cerimônia.
```sql
SELECT DISTINCT a.nome_filme, a.ano_cerimonia
FROM indicados_ao_oscar a
WHERE a.vencedor = true
  AND (a.categoria = 'BEST PICTURE' OR a.categoria = 'OUTSTANDING PICTURE')
  AND EXISTS (
    SELECT 1
    FROM indicados_ao_oscar b
    WHERE b.nome_filme = a.nome_filme
      AND b.ano_cerimonia = a.ano_cerimonia
      AND b.vencedor = true
      AND b.categoria NOT IN ('BEST PICTURE', 'OUTSTANDING PICTURE')
  )
ORDER BY a.ano_cerimonia DESC;
```

**10.2** Qual filme recebeu o maior número de indicações em uma única cerimônia?
```sql
SELECT
    nome_filme,
    ano_cerimonia,
    COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
GROUP BY nome_filme, ano_cerimonia
ORDER BY total_indicacoes DESC
LIMIT 1;
```

**10.3** Calcule a "taxa de conversão" de cada filme (vitórias/indicações * 100).
```sql
SELECT
    nome_filme,
    COUNT(*) AS total_indicacoes,
    SUM(CASE WHEN vencedor = true THEN 1 ELSE 0 END) AS total_vitorias,
    ROUND((SUM(CASE WHEN vencedor = true THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS taxa_conversao
FROM indicados_ao_oscar
GROUP BY nome_filme
HAVING COUNT(*) >= 3
ORDER BY taxa_conversao DESC;
```

**10.4** Qual a média de indicações por cerimônia ao longo da história?
```sql
SELECT AVG(total_por_cerimonia) AS media_indicacoes_por_cerimonia
FROM (
    SELECT ano_cerimonia, COUNT(*) AS total_por_cerimonia
    FROM indicados_ao_oscar
    GROUP BY ano_cerimonia
) AS subquery;
```

**10.5** Liste os 5 filmes com mais indicações que nunca ganharam nenhum Oscar.
```sql
SELECT
    nome_filme,
    COUNT(*) AS total_indicacoes,
    SUM(CASE WHEN vencedor = true THEN 1 ELSE 0 END) AS total_vitorias
FROM indicados_ao_oscar
GROUP BY nome_filme
HAVING SUM(CASE WHEN vencedor = true THEN 1 ELSE 0 END) = 0
ORDER BY total_indicacoes DESC
LIMIT 5;
```

---

## 🏅 Nível 11: Queries Complexas com JOINs e Subqueries

**11.1** Crie um ranking dos 10 filmes mais premiados da história.
```sql
SELECT
    nome_filme,
    COUNT(*) AS total_oscars
FROM indicados_ao_oscar
WHERE vencedor = true
GROUP BY nome_filme
ORDER BY total_oscars DESC
LIMIT 10;
```

**11.2** Crie um ranking dos 10 artistas mais indicados da história.
```sql
SELECT
    nome_indicado,
    COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
WHERE nome_indicado IS NOT NULL
GROUP BY nome_indicado
ORDER BY total_indicacoes DESC
LIMIT 10;
```

**11.3** Use uma subquery para encontrar todos os indicados que têm mais indicações do que a média geral.
```sql
SELECT
    nome_indicado,
    COUNT(*) AS total_indicacoes
FROM indicados_ao_oscar
WHERE nome_indicado IS NOT NULL
GROUP BY nome_indicado
HAVING COUNT(*) > (
    SELECT AVG(total_indicacoes)
    FROM (
        SELECT COUNT(*) AS total_indicacoes
        FROM indicados_ao_oscar
        WHERE nome_indicado IS NOT NULL
        GROUP BY nome_indicado
    ) AS media_geral
)
ORDER BY total_indicacoes DESC;
```

**11.4** Encontre categorias onde o mesmo artista ganhou mais de uma vez.
```sql
SELECT
    categoria,
    nome_indicado,
    COUNT(*) AS total_vitorias
FROM indicados_ao_oscar
WHERE vencedor = true
  AND nome_indicado IS NOT NULL
GROUP BY categoria, nome_indicado
HAVING COUNT(*) > 1
ORDER BY total_vitorias DESC;
```

**11.5** Liste filmes que foram indicados em pelo menos 5 categorias diferentes na mesma cerimônia.
```sql
SELECT
    nome_filme,
    ano_cerimonia,
    COUNT(DISTINCT categoria) AS total_categorias
FROM indicados_ao_oscar
GROUP BY nome_filme, ano_cerimonia
HAVING COUNT(DISTINCT categoria) >= 5
ORDER BY total_categorias DESC;
```

**11.6** Qual categoria tem a maior "competitividade" (média de indicados por cerimônia)?
```sql
SELECT
    categoria,
    COUNT(*) / COUNT(DISTINCT ano_cerimonia) AS media_indicados_por_cerimonia
FROM indicados_ao_oscar
GROUP BY categoria
ORDER BY media_indicados_por_cerimonia DESC
LIMIT 1;
```

---

## 🎲 Nível 12: Casos Práticos e Relatórios

### Cenário 1: Curadoria de Mostra de Cinema

**12.1** Crie uma lista dos 20 filmes mais premiados para uma mostra de cinema.
```sql
SELECT
    nome_filme,
    COUNT(*) AS total_oscars
FROM indicados_ao_oscar
WHERE vencedor = true
GROUP BY nome_filme
ORDER BY total_oscars DESC
LIMIT 20;
```

**12.2** Selecione 5 filmes de cada década que ganharam pelo menos um Oscar.
```sql
-- Anos 1920-1930
SELECT DISTINCT nome_filme, ano_cerimonia
FROM indicados_ao_oscar
WHERE vencedor = true AND ano_cerimonia BETWEEN 1920 AND 1939
LIMIT 5

UNION ALL

-- Anos 1940-1950
SELECT DISTINCT nome_filme, ano_cerimonia
FROM indicados_ao_oscar
WHERE vencedor = true AND ano_cerimonia BETWEEN 1940 AND 1959
LIMIT 5

UNION ALL

-- Anos 1960-1970
SELECT DISTINCT nome_filme, ano_cerimonia
FROM indicados_ao_oscar
WHERE vencedor = true AND ano_cerimonia BETWEEN 1960 AND 1979
LIMIT 5

UNION ALL

-- Anos 1980-1990
SELECT DISTINCT nome_filme, ano_cerimonia
FROM indicados_ao_oscar
WHERE vencedor = true AND ano_cerimonia BETWEEN 1980 AND 1999
LIMIT 5

UNION ALL

-- Anos 2000+
SELECT DISTINCT nome_filme, ano_cerimonia
FROM indicados_ao_oscar
WHERE vencedor = true AND ano_cerimonia >= 2000
LIMIT 5;
```

**12.3** Crie uma lista de "clássicos" - filmes que ganharam Oscars há mais de 50 anos.
```sql
SELECT DISTINCT
    nome_filme,
    ano_cerimonia,
    COUNT(*) AS total_oscars
FROM indicados_ao_oscar
WHERE vencedor = true
  AND ano_cerimonia < 1975
GROUP BY nome_filme, ano_cerimonia
ORDER BY ano_cerimonia;
```

### Cenário 2: Análise Estatística

**12.4** Calcule estatísticas gerais.
```sql
SELECT
    COUNT(*) AS total_indicacoes,
    SUM(CASE WHEN vencedor = true THEN 1 ELSE 0 END) AS total_vencedores,
    COUNT(DISTINCT nome_filme) AS total_filmes_unicos,
    COUNT(DISTINCT nome_indicado) AS total_artistas_unicos
FROM indicados_ao_oscar;
```

**12.5** Crie um relatório mostrando estatísticas por década.
```sql
SELECT
    FLOOR(ano_cerimonia/10)*10 AS decada,
    COUNT(DISTINCT edicao_cerimonia) AS num_cerimonias,
    COUNT(*) AS total_indicacoes,
    SUM(CASE WHEN vencedor = true THEN 1 ELSE 0 END) AS total_vencedores,
    COUNT(DISTINCT categoria) AS num_categorias_unicas
FROM indicados_ao_oscar
GROUP BY FLOOR(ano_cerimonia/10)*10
ORDER BY decada;
```

**12.6** Encontre "azarões" - artistas com mais de 5 indicações e 0 vitórias.
```sql
SELECT
    nome_indicado,
    COUNT(*) AS total_indicacoes,
    SUM(CASE WHEN vencedor = true THEN 1 ELSE 0 END) AS total_vitorias
FROM indicados_ao_oscar
WHERE nome_indicado IS NOT NULL
GROUP BY nome_indicado
HAVING COUNT(*) > 5 AND SUM(CASE WHEN vencedor = true THEN 1 ELSE 0 END) = 0
ORDER BY total_indicacoes DESC;
```

### Cenário 3: Dashboard para Site

**12.7** Crie uma query que retorne um "resumo do Oscar".
```sql
SELECT
    MIN(ano_cerimonia) AS primeira_cerimonia,
    MAX(ano_cerimonia) AS ultima_cerimonia,
    COUNT(*) AS total_registros,
    (
        SELECT categoria
        FROM indicados_ao_oscar
        GROUP BY categoria
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS categoria_mais_indicacoes
FROM indicados_ao_oscar;
```

**12.8** Liste os 10 anos com mais premiações (vencedores).
```sql
SELECT
    ano_cerimonia,
    COUNT(*) AS total_premiacoes
FROM indicados_ao_oscar
WHERE vencedor = true
GROUP BY ano_cerimonia
ORDER BY total_premiacoes DESC
LIMIT 10;
```

**12.9** Mostre um ranking de filmes por "sucesso" (percentual de vitórias).
```sql
SELECT
    nome_filme,
    COUNT(*) AS total_indicacoes,
    SUM(CASE WHEN vencedor = true THEN 1 ELSE 0 END) AS total_vitorias,
    ROUND((SUM(CASE WHEN vencedor = true THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS percentual_sucesso
FROM indicados_ao_oscar
GROUP BY nome_filme
HAVING COUNT(*) >= 5
ORDER BY percentual_sucesso DESC, total_indicacoes DESC;
```

---

## 💡 Nível 13: Queries Criativas e Avançadas

**13.1** Encontre todos os filmes cujo nome começa com "The" e ganharam pelo menos um Oscar.
```sql
SELECT DISTINCT nome_filme
FROM indicados_ao_oscar
WHERE nome_filme LIKE 'The %'
  AND vencedor = true
ORDER BY nome_filme;
```

**13.2** Liste indicados cujo nome contém um hífen.
```sql
SELECT DISTINCT nome_indicado
FROM indicados_ao_oscar
WHERE nome_indicado LIKE '%-%'
ORDER BY nome_indicado;
```

**13.3** Encontre cerimônias onde houve "empate" (múltiplos vencedores na mesma categoria).
```sql
SELECT
    ano_cerimonia,
    categoria,
    COUNT(*) AS total_vencedores
FROM indicados_ao_oscar
WHERE vencedor = true
GROUP BY ano_cerimonia, categoria
HAVING COUNT(*) > 1
ORDER BY total_vencedores DESC, ano_cerimonia;
```

**13.4** Use RAND() para selecionar 5 filmes aleatórios que ganharam Melhor Filme.
```sql
SELECT DISTINCT nome_filme, ano_cerimonia
FROM indicados_ao_oscar
WHERE (categoria = 'BEST PICTURE' OR categoria = 'OUTSTANDING PICTURE')
  AND vencedor = true
ORDER BY RAND()
LIMIT 5;
```

**13.5** Analise padrões: quantos filmes vencedores de Melhor Filme têm 1, 2, 3+ palavras no título?
```sql
SELECT
    CASE
        WHEN LENGTH(nome_filme) - LENGTH(REPLACE(nome_filme, ' ', '')) = 0 THEN '1 palavra'
        WHEN LENGTH(nome_filme) - LENGTH(REPLACE(nome_filme, ' ', '')) = 1 THEN '2 palavras'
        ELSE '3+ palavras'
    END AS num_palavras,
    COUNT(DISTINCT nome_filme) AS total_filmes
FROM indicados_ao_oscar
WHERE (categoria = 'BEST PICTURE' OR categoria = 'OUTSTANDING PICTURE')
  AND vencedor = true
GROUP BY
    CASE
        WHEN LENGTH(nome_filme) - LENGTH(REPLACE(nome_filme, ' ', '')) = 0 THEN '1 palavra'
        WHEN LENGTH(nome_filme) - LENGTH(REPLACE(nome_filme, ' ', '')) = 1 THEN '2 palavras'
        ELSE '3+ palavras'
    END;
```

**13.6** Crie uma view chamada `vencedores_actor` que contenha apenas vencedores da categoria ACTOR.
```sql
CREATE VIEW vencedores_actor AS
SELECT
    ano_cerimonia,
    nome_indicado,
    nome_filme
FROM indicados_ao_oscar
WHERE categoria = 'ACTOR'
  AND vencedor = true;

-- Para consultar a view:
SELECT * FROM vencedores_actor ORDER BY ano_cerimonia;
```

**13.7** Use CASE WHEN para classificar indicados em "Lenda", "Veterano", "Iniciante".
```sql
SELECT
    nome_indicado,
    COUNT(*) AS total_indicacoes,
    CASE
        WHEN COUNT(*) >= 5 THEN 'Lenda'
        WHEN COUNT(*) >= 3 THEN 'Veterano'
        ELSE 'Iniciante'
    END AS classificacao
FROM indicados_ao_oscar
WHERE nome_indicado IS NOT NULL
GROUP BY nome_indicado
ORDER BY total_indicacoes DESC;
```

---

## 🎯 Nível 14: Otimização e Performance

**14.1** Use EXPLAIN para analisar a performance de uma query complexa.
```sql
EXPLAIN
SELECT
    nome_filme,
    COUNT(*) AS total_oscars
FROM indicados_ao_oscar
WHERE vencedor = true
GROUP BY nome_filme
ORDER BY total_oscars DESC
LIMIT 10;
```

**14.2** Crie índices nas colunas mais consultadas.
```sql
CREATE INDEX idx_nome_indicado ON indicados_ao_oscar(nome_indicado);
CREATE INDEX idx_categoria ON indicados_ao_oscar(categoria);
CREATE INDEX idx_vencedor ON indicados_ao_oscar(vencedor);
CREATE INDEX idx_ano_cerimonia ON indicados_ao_oscar(ano_cerimonia);
CREATE INDEX idx_nome_filme ON indicados_ao_oscar(nome_filme);
```

**14.3** Compare o tempo de execução de uma query antes e depois de criar os índices.
```sql
-- Antes de criar índices, execute:
SET profiling = 1;

SELECT nome_indicado, COUNT(*) AS total
FROM indicados_ao_oscar
WHERE nome_indicado = 'Meryl Streep'
GROUP BY nome_indicado;

SHOW PROFILES;

-- Depois de criar os índices, execute novamente:
SELECT nome_indicado, COUNT(*) AS total
FROM indicados_ao_oscar
WHERE nome_indicado = 'Meryl Streep'
GROUP BY nome_indicado;

SHOW PROFILES;
```

**14.4** Use LIMIT para otimizar queries que retornam muitos resultados.
```sql
-- Em vez de retornar todos os registros:
-- SELECT * FROM indicados_ao_oscar;

-- Use LIMIT para retornar apenas o necessário:
SELECT * FROM indicados_ao_oscar
ORDER BY ano_cerimonia DESC
LIMIT 100;
```

**14.5** Identifique queries que podem se beneficiar de índices compostos.
```sql
-- Query que busca por categoria e vencedor frequentemente
-- poderia se beneficiar de índice composto:
CREATE INDEX idx_categoria_vencedor ON indicados_ao_oscar(categoria, vencedor);

-- Query que busca por ano e categoria:
CREATE INDEX idx_ano_categoria ON indicados_ao_oscar(ano_cerimonia, categoria);

-- Query que busca por filme e ano:
CREATE INDEX idx_filme_ano ON indicados_ao_oscar(nome_filme, ano_cerimonia);
```

---

## 🎓 Nível 15: Desafios Avançados de SQL

**15.1** Use window functions para rankear atores por número de indicações.
```sql
SELECT
    nome_indicado,
    COUNT(*) AS indicacoes,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS ranking
FROM indicados_ao_oscar
WHERE nome_indicado IS NOT NULL
GROUP BY nome_indicado
ORDER BY ranking
LIMIT 20;
```

**15.2** Crie uma stored procedure que aceite um nome de ator e retorne todas suas indicações.
```sql
DELIMITER //

CREATE PROCEDURE buscar_indicacoes_ator(IN nome_ator VARCHAR(512))
BEGIN
    SELECT
        ano_cerimonia,
        categoria,
        nome_filme,
        vencedor
    FROM indicados_ao_oscar
    WHERE nome_indicado = nome_ator
    ORDER BY ano_cerimonia;
END //

DELIMITER ;

-- Para usar a procedure:
CALL buscar_indicacoes_ator('Meryl Streep');
```

**15.3** Crie uma trigger que registre em uma tabela de auditoria toda vez que um novo registro é inserido.
```sql
-- Primeiro, criar a tabela de auditoria:
CREATE TABLE auditoria_oscar (
    id_auditoria INT PRIMARY KEY AUTO_INCREMENT,
    acao VARCHAR(50),
    nome_filme VARCHAR(255),
    categoria VARCHAR(255),
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Criar a trigger:
DELIMITER //

CREATE TRIGGER trigger_insert_oscar
AFTER INSERT ON indicados_ao_oscar
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_oscar (acao, nome_filme, categoria)
    VALUES ('INSERT', NEW.nome_filme, NEW.categoria);
END //

DELIMITER ;
```

**15.4** Use CTEs (Common Table Expressions) para encontrar filmes que ganharam em múltiplas categorias.
```sql
WITH vencedores AS (
    SELECT
        nome_filme,
        edicao_cerimonia,
        ano_cerimonia,
        COUNT(*) AS oscars
    FROM indicados_ao_oscar
    WHERE vencedor = true
    GROUP BY nome_filme, edicao_cerimonia, ano_cerimonia
)
SELECT
    nome_filme,
    ano_cerimonia,
    oscars
FROM vencedores
WHERE oscars > 3
ORDER BY oscars DESC;
```

**15.5** Crie uma função que calcule a "pontuação Oscar" de um filme.
```sql
DELIMITER //

CREATE FUNCTION pontuacao_oscar(filme VARCHAR(255))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE pontuacao INT;
    DECLARE vitorias INT;
    DECLARE indicacoes INT;

    SELECT
        COUNT(*),
        SUM(CASE WHEN vencedor = true THEN 1 ELSE 0 END)
    INTO indicacoes, vitorias
    FROM indicados_ao_oscar
    WHERE nome_filme = filme;

    SET pontuacao = (vitorias * 10) + (indicacoes * 1);

    RETURN pontuacao;
END //

DELIMITER ;

-- Para usar a função:
SELECT
    nome_filme,
    pontuacao_oscar(nome_filme) AS pontuacao
FROM indicados_ao_oscar
GROUP BY nome_filme
ORDER BY pontuacao DESC
LIMIT 10;
```

---

## 📊 Nível 16: Desafio Final - Relatório Executivo Completo

**16.1** Crie uma única query que retorne estatísticas completas do Oscar.
```sql
SELECT
    (SELECT COUNT(*) FROM indicados_ao_oscar) AS total_indicacoes,
    (SELECT COUNT(DISTINCT edicao_cerimonia) FROM indicados_ao_oscar) AS total_cerimonias,
    (SELECT MIN(ano_cerimonia) FROM indicados_ao_oscar) AS ano_primeira_cerimonia,
    (SELECT MAX(ano_cerimonia) FROM indicados_ao_oscar) AS ano_ultima_cerimonia,
    (
        SELECT nome_filme
        FROM indicados_ao_oscar
        WHERE vencedor = true
        GROUP BY nome_filme
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS filme_mais_premiado,
    (
        SELECT nome_indicado
        FROM indicados_ao_oscar
        WHERE nome_indicado IS NOT NULL
        GROUP BY nome_indicado
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS artista_mais_indicado,
    (
        SELECT categoria
        FROM indicados_ao_oscar
        GROUP BY categoria
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS categoria_mais_indicacoes;
```

**16.2** Crie uma view chamada `estatisticas_oscar` com estatísticas por década.
```sql
CREATE VIEW estatisticas_oscar AS
SELECT
    FLOOR(ano_cerimonia/10)*10 AS decada,
    COUNT(DISTINCT edicao_cerimonia) AS total_cerimonias,
    COUNT(*) AS total_indicacoes,
    SUM(CASE WHEN vencedor = true THEN 1 ELSE 0 END) AS total_vencedores,
    COUNT(DISTINCT categoria) AS categorias_unicas,
    COUNT(DISTINCT nome_filme) AS filmes_unicos,
    COUNT(DISTINCT nome_indicado) AS artistas_unicos,
    ROUND(AVG(CASE WHEN vencedor = true THEN 1 ELSE 0 END) * 100, 2) AS taxa_vitoria_pct
FROM indicados_ao_oscar
GROUP BY FLOOR(ano_cerimonia/10)*10;

-- Para consultar a view:
SELECT * FROM estatisticas_oscar ORDER BY decada;
```

**16.3** Exporte resultados complexos organizados para dashboard.
```sql
-- Dashboard: Top 20 filmes mais impactantes
SELECT
    nome_filme,
    COUNT(*) AS total_indicacoes,
    SUM(CASE WHEN vencedor = true THEN 1 ELSE 0 END) AS total_vitorias,
    ROUND((SUM(CASE WHEN vencedor = true THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 1) AS taxa_sucesso,
    MIN(ano_cerimonia) AS primeiro_ano,
    MAX(ano_cerimonia) AS ultimo_ano,
    (SUM(CASE WHEN vencedor = true THEN 1 ELSE 0 END) * 10) + COUNT(*) AS pontuacao_total
FROM indicados_ao_oscar
WHERE nome_filme IS NOT NULL
GROUP BY nome_filme
HAVING COUNT(*) >= 3
ORDER BY pontuacao_total DESC, total_vitorias DESC
LIMIT 20;
```

---

## 🎓 Conclusão

Parabéns por completar todos os 16 níveis de exercícios SQL do Oscar!

Ao longo destes exercícios, você:

✅ Dominou consultas básicas com SELECT, WHERE, ORDER BY e LIMIT
✅ Aprendeu agregações com GROUP BY, COUNT, SUM, AVG, MAX, MIN
✅ Praticou queries intermediárias com HAVING e subqueries
✅ Explorou recursos avançados como views, índices e stored procedures
✅ Trabalhou com window functions, CTEs e triggers
✅ Otimizou queries para melhor performance
✅ Criou relatórios complexos para análise de dados

### Recursos Importantes

**Funções de Agregação:**
- `COUNT()` - Conta registros
- `SUM()` - Soma valores
- `AVG()` - Calcula média
- `MAX()` / `MIN()` - Encontra máximo/mínimo

**Cláusulas Essenciais:**
- `WHERE` - Filtra registros individuais
- `GROUP BY` - Agrupa dados
- `HAVING` - Filtra grupos agregados
- `ORDER BY` - Ordena resultados
- `LIMIT` - Limita quantidade de resultados

**Operadores de Comparação:**
- `=`, `!=`, `<>` - Igualdade/diferença
- `>`, `<`, `>=`, `<=` - Comparações
- `LIKE` - Padrões de texto
- `IN` - Lista de valores
- `BETWEEN` - Intervalo de valores
- `IS NULL` / `IS NOT NULL` - Valores nulos

**Recursos Avançados:**
- Views para consultas reutilizáveis
- Índices para otimização de performance
- Stored procedures para lógica encapsulada
- Triggers para automação
- CTEs para queries mais legíveis
- Window functions para análises avançadas

### Próximos Passos

Continue praticando SQL com outros conjuntos de dados e explore:
- Queries de otimização complexas
- Análise de planos de execução
- Particionamento de tabelas
- Replicação e backup
- Integração com aplicações

**Que vença o melhor!** 🏆🎬

---

*Este material foi criado para fins educacionais. Os dados do Oscar são de domínio público e foram compilados para aprendizado de SQL.*
