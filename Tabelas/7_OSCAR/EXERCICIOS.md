# Oscar - Exercícios SQL

Bem-vindo à base de dados do **Oscar**!

O Oscar é a premiação mais prestigiada do cinema mundial, realizada anualmente desde 1929 pela Academia de Artes e Ciências Cinematográficas. Nesta base de dados SQL, você encontrará registros históricos de indicados e vencedores de diversas categorias ao longo de quase 100 anos de história do cinema.

Nestes exercícios, você vai explorar o banco de dados usando SQL e responder perguntas que revelam insights fascinantes sobre a história do cinema, tendências de premiação, e momentos marcantes da indústria cinematográfica.

---

## 📊 Nível 1: Primeiros Passos

### Conhecendo a Base de Dados

**1.1** Quantos registros existem na tabela `indicados_ao_oscar`?

**1.2** Quais são as diferentes categorias de premiação que existem no banco de dados? Liste todas as categorias únicas.

**1.3** Qual foi o primeiro ano de cerimônia do Oscar registrado na base?

**1.4** Qual foi o último ano de cerimônia registrado na base?

**1.5** Quantas cerimônias (edições) do Oscar estão registradas no total?

**1.6** Liste as primeiras 10 linhas da tabela para entender sua estrutura.

**1.7** Atualize os registros da tabela com os dados do Oscar 2025 (pesquise os vencedores e adicione-os).

---

## 🎬 Nível 2: Explorando Categorias

**2.1** Quantas indicações existem para cada categoria? Agrupe por categoria e ordene da mais frequente para a menos frequente.

**2.2** Qual categoria teve mais indicações ao longo da história do Oscar?

**2.3** Qual categoria teve menos indicações ao longo da história?

**2.4** A partir de que ano a categoria "ACTRESS" deixou de existir? (Dica: procure a última cerimônia com essa categoria)

**2.5** Quais categorias existiam na primeira cerimônia (1928) mas não existem nas últimas 5 cerimônias?

**2.6** Liste todas as categorias que contêm a palavra "DIRECTING" no nome.

**2.7** Quantas categorias diferentes existem na base de dados?

---

## 🌟 Nível 3: Atores e Atrizes Famosos

### Natalie Portman

**3.1** Quantas vezes Natalie Portman foi indicada ao Oscar?

**3.2** Quantos Oscars Natalie Portman ganhou?

**3.3** Em quais anos e por quais filmes Natalie Portman foi indicada?

**3.4** Liste todas as indicações de Natalie Portman mostrando: ano, categoria, filme e se venceu.

### Viola Davis

**3.5** Quantas vezes Viola Davis foi indicada ao Oscar?

**3.6** Quantos Oscars Viola Davis ganhou?

**3.7** Por quais filmes Viola Davis foi indicada?

### Amy Adams

**3.8** Amy Adams já ganhou algum Oscar?

**3.9** Quantas vezes Amy Adams foi indicada sem ganhar?

### Denzel Washington

**3.10** Denzel Washington já ganhou algum Oscar?

**3.11** Quantas vezes Denzel Washington foi indicado ao Oscar?

**3.12** Liste todos os Oscars que Denzel Washington ganhou (ano, categoria, filme).

---

## 🏆 Nível 4: Vencedores Históricos

**4.1** Quem ganhou o primeiro Oscar para Melhor Atriz (ACTRESS)? Em que ano e por qual filme?

**4.2** Quem ganhou o primeiro Oscar para Melhor Ator (ACTOR)? Em que ano e por qual filme?

**4.3** Quantos vencedores (registros com vencedor = TRUE) existem ao todo na base de dados?

**4.4** Liste todos os filmes que ganharam o Oscar de Melhor Filme (categoria "OUTSTANDING PICTURE" ou "BEST PICTURE").

**4.5** Quantos filmes diferentes já ganharam algum Oscar?

**4.6** Liste os 10 primeiros vencedores do Oscar na história, ordenados por ano.

---

## 🎭 Nível 5: Análise de Indicações

**5.1** Quais atores/atrizes foram indicados mais de uma vez? Liste o nome e o número de indicações, ordenado por número decrescente.

**5.2** Qual ator ou atriz tem o maior número de indicações na história do Oscar?

**5.3** Quais atores foram indicados mais de 3 vezes mas nunca ganharam?

**5.4** Encontre todos os artistas que têm pelo menos 2 indicações. Mostre nome e total de indicações.

**5.5** Quantos indicados únicos (nomes diferentes) existem na história do Oscar?

**5.6** Qual a média de indicações por indicado?

---

## 🎥 Nível 6: Análise de Filmes

### Toy Story

**6.1** A série de filmes Toy Story ganhou Oscars em quais anos?

**6.2** Quantas indicações a franquia Toy Story recebeu no total?

**6.3** Em quais categorias os filmes Toy Story foram indicados?

### Crash

**6.4** Em qual edição do Oscar o filme "Crash" concorreu?

**6.5** Quantas indicações o filme "Crash" recebeu?

**6.6** "Crash" ganhou o Oscar de Melhor Filme?

### Central do Brasil

**6.7** O filme "Central do Brasil" aparece no banco de dados?

**6.8** Se sim, quantas indicações "Central do Brasil" recebeu e em quais categorias?

**6.9** Liste todos os filmes que contêm "Brasil" no nome.

---

## 📅 Nível 7: Análise Temporal

**7.1** Quantas indicações aconteceram por década? Agrupe por década (1920s, 1930s, etc.) e mostre o total. Use `FLOOR(ano_cerimonia/10)*10` para calcular a década.

**7.2** Em qual década houve o maior número de indicações?

**7.3** Quantas categorias únicas existiam em cada década?

**7.4** Qual foi o ano com o maior número de indicações registradas?

**7.5** Quantas indicações houve nos anos 2000 (entre 2000 e 2009)?

**7.6** Compare o número de indicações da primeira década (1920s) com a última década disponível.

---

## 🔄 Nível 8: Operações de Atualização e Inserção

**8.1** Insira no banco 3 filmes fictícios que nunca foram nomeados ao Oscar, mas que você acha que merecem.

**8.2** Atualize o nome de um filme específico (escolha um e corrija algum erro de digitação se encontrar).

**8.3** Se houver registros com `vencedor` como 1 ou 0 (numérico), verifique quantos são TRUE e quantos são FALSE.

**8.4** Adicione uma nova categoria fictícia com alguns indicados do ano 2024.

**8.5** Delete todos os registros que você inseriu nos exercícios anteriores (use WHERE criteriosamente!).

**8.6** Conte quantos registros têm `nome_filme` como NULL.

---

## 🎯 Nível 9: Questões Históricas e Sociais

### Representatividade

**9.1** Sidney Poitier foi o primeiro ator negro a ser indicado ao Oscar. Em que ano ele foi indicado? Por qual filme?

**9.2** Sidney Poitier ganhou o Oscar nessa indicação?

**9.3** Liste todas as indicações de Sidney Poitier na história do Oscar.

**9.4** Quantos registros de indicações ao Oscar existem antes de 1950?

### Coincidências

**9.5** Denzel Washington e Jamie Foxx já concorreram ao Oscar no mesmo ano? Use uma query para descobrir anos em comum.

**9.6** Liste os filmes que ganharam mais de 3 Oscars na mesma cerimônia.

**9.7** Encontre casos onde o mesmo filme aparece em mais de 5 categorias na mesma cerimônia.

---

## 🔍 Nível 10: Análise Avançada

**10.1** Liste os filmes que ganharam tanto o Oscar de Melhor Filme quanto aparecem em outras categorias vencedoras na mesma cerimônia.

**10.2** Qual filme recebeu o maior número de indicações em uma única cerimônia? Use GROUP BY e COUNT.

**10.3** Calcule a "taxa de conversão" de cada filme: (número de vitórias / número de indicações) * 100. Mostre apenas filmes com pelo menos 3 indicações.

**10.4** Qual a média de indicações por cerimônia ao longo da história?

**10.5** Liste os 5 filmes com mais indicações que nunca ganharam nenhum Oscar.

---

## 🏅 Nível 11: Queries Complexas com JOINs e Subqueries

**11.1** Crie um ranking dos 10 filmes mais premiados da história (que ganharam mais Oscars).

**11.2** Crie um ranking dos 10 artistas mais indicados da história.

**11.3** Use uma subquery para encontrar todos os indicados que têm mais indicações do que a média geral.

**11.4** Encontre categorias onde o mesmo artista ganhou mais de uma vez (vencedores repetidos).

**11.5** Liste filmes que foram indicados em pelo menos 5 categorias diferentes na mesma cerimônia.

**11.6** Qual categoria tem a maior "competitividade"? (média de indicados por cerimônia)

---

## 🎲 Nível 12: Casos Práticos e Relatórios

### Cenário 1: Curadoria de Mostra de Cinema

**12.1** Crie uma lista dos 20 filmes mais premiados para uma mostra de cinema.

**12.2** Selecione 5 filmes de cada década que ganharam pelo menos um Oscar. Use UNION ou múltiplas queries.

**12.3** Crie uma lista de "clássicos" - filmes que ganharam Oscars há mais de 50 anos.

### Cenário 2: Análise Estatística

**12.4** Calcule estatísticas gerais:
   - Total de indicações
   - Total de vencedores
   - Total de filmes únicos
   - Total de artistas únicos

**12.5** Crie um relatório mostrando, para cada década:
   - Número de cerimônias
   - Total de indicações
   - Total de vencedores
   - Número de categorias únicas

**12.6** Encontre "azarões" - artistas com mais de 5 indicações e 0 vitórias.

### Cenário 3: Dashboard para Site

**12.7** Crie uma query que retorne um "resumo do Oscar":
   - Primeira cerimônia (ano)
   - Última cerimônia (ano)
   - Total de registros
   - Categoria com mais indicações

**12.8** Liste os 10 anos com mais premiações (vencedores).

**12.9** Mostre um ranking de filmes por "sucesso" (percentual de vitórias sobre indicações), apenas para filmes com 5+ indicações.

---

## 💡 Nível 13: Queries Criativas e Avançadas

**13.1** Encontre todos os filmes cujo nome começa com "The" e ganharam pelo menos um Oscar.

**13.2** Liste indicados cujo nome contém um hífen (possível sobrenome composto).

**13.3** Encontre cerimônias onde houve "empate" (múltiplos vencedores na mesma categoria - mais de um TRUE).

**13.4** Use `RAND()` ou `RANDOM()` para selecionar 5 filmes aleatórios que ganharam Melhor Filme.

**13.5** Analise padrões: quantos filmes vencedores de Melhor Filme têm 1 palavra, 2 palavras, 3+ palavras no título?

**13.6** Crie uma view chamada `vencedores_actor` que contenha apenas vencedores da categoria ACTOR.

**13.7** Use CASE WHEN para criar uma coluna que classifica indicados em "Lenda" (5+ indicações), "Veterano" (3-4), "Iniciante" (1-2).

---

## 🎯 Nível 14: Otimização e Performance

**14.1** Use EXPLAIN para analisar a performance de uma query complexa (ex: a query 11.1).

**14.2** Crie índices nas colunas mais consultadas:
   - `CREATE INDEX idx_nome_indicado ON indicados_ao_oscar(nome_indicado);`
   - `CREATE INDEX idx_categoria ON indicados_ao_oscar(categoria);`
   - `CREATE INDEX idx_vencedor ON indicados_ao_oscar(vencedor);`

**14.3** Compare o tempo de execução de uma query antes e depois de criar os índices.

**14.4** Use LIMIT para otimizar queries que retornam muitos resultados.

**14.5** Identifique queries que podem se beneficiar de índices compostos (múltiplas colunas).

---

## 🎓 Nível 15: Desafios Avançados de SQL

**15.1** Use window functions (se seu SGBD suportar) para rankear atores por número de indicações:
```sql
SELECT
  nome_indicado,
  COUNT(*) as indicacoes,
  RANK() OVER (ORDER BY COUNT(*) DESC) as ranking
FROM indicados_ao_oscar
GROUP BY nome_indicado
```

**15.2** Crie uma stored procedure que aceite um nome de ator e retorne todas suas indicações.

**15.3** Crie uma trigger que registre em uma tabela de auditoria toda vez que um novo registro é inserido.

**15.4** Use CTEs (Common Table Expressions) para encontrar filmes que ganharam em múltiplas categorias:
```sql
WITH vencedores AS (
  SELECT nome_filme, edicao_cerimonia, COUNT(*) as oscars
  FROM indicados_ao_oscar
  WHERE vencedor = TRUE
  GROUP BY nome_filme, edicao_cerimonia
)
SELECT * FROM vencedores WHERE oscars > 3;
```

**15.5** Crie uma função que calcule a "pontuação Oscar" de um filme: (vitórias * 10) + (indicações * 1).

---

## 📊 Desafio Final: Relatório Executivo Completo

**16.1** Crie uma única query (pode usar subqueries) que retorne:
   - Total de indicações na história
   - Total de cerimônias
   - Ano da primeira cerimônia
   - Ano da última cerimônia
   - Filme mais premiado
   - Ator/atriz mais indicado(a)
   - Categoria com mais indicações

**16.2** Crie uma view chamada `estatisticas_oscar` que contenha estatísticas agregadas por década.

**16.3** Exporte os resultados de uma query complexa para um formato que poderia ser usado em um dashboard (use ORDER BY e LIMIT para organizar).

---

## 💡 Dicas Gerais de SQL

### Funções Úteis
- **Agregação**: `COUNT()`, `SUM()`, `AVG()`, `MAX()`, `MIN()`
- **String**: `LIKE`, `CONCAT()`, `SUBSTRING()`, `UPPER()`, `LOWER()`, `TRIM()`
- **Data**: `YEAR()`, `MONTH()`, `DATE()`, `NOW()`
- **Matemática**: `FLOOR()`, `CEILING()`, `ROUND()`

### Cláusulas Importantes
- **GROUP BY**: Agrupa resultados
- **HAVING**: Filtra grupos (depois do GROUP BY)
- **ORDER BY**: Ordena resultados
- **LIMIT**: Limita número de resultados
- **DISTINCT**: Remove duplicatas

### Boas Práticas
- Sempre use `WHERE` antes de `UPDATE` ou `DELETE`
- Teste com `SELECT` antes de executar `UPDATE` ou `DELETE`
- Use aliases para tornar queries mais legíveis: `AS nome_alias`
- Comente queries complexas: `-- Este é um comentário`
- Indente seu código para melhor legibilidade

### Performance
- Use índices em colunas frequentemente consultadas
- Evite `SELECT *`, especifique apenas as colunas necessárias
- Use `LIMIT` quando não precisar de todos os resultados
- Cuidado com `LIKE '%texto%'` (não usa índice)
- Prefira `EXISTS` a `COUNT(*)` para verificar existência

---

## 🎓 Avaliação

- **Nível 1-4**: SQL básico (SELECT, WHERE, ORDER BY, LIMIT)
- **Nível 5-8**: Agregações (GROUP BY, COUNT, AVG, SUM)
- **Nível 9-11**: Queries intermediárias (HAVING, subqueries, múltiplas tabelas)
- **Nível 12-14**: SQL avançado (views, índices, otimização)
- **Nível 15-16**: Expert SQL (window functions, CTEs, stored procedures)

**Objetivo de aprendizado**: Ao completar todos os níveis, você será capaz de:
- Escrever queries SQL complexas e eficientes
- Analisar grandes volumes de dados históricos
- Otimizar performance de banco de dados
- Criar relatórios e dashboards baseados em SQL
- Usar recursos avançados como views, índices e stored procedures

Bons estudos e que vença o melhor! 🏆🎬

---

## 📝 Comandos SQL Essenciais - Resumo

```sql
-- SELECT básico
SELECT coluna1, coluna2 FROM tabela WHERE condicao;

-- Agregação
SELECT categoria, COUNT(*) as total
FROM indicados_ao_oscar
GROUP BY categoria
ORDER BY total DESC;

-- Subquery
SELECT * FROM indicados_ao_oscar
WHERE ano_cerimonia = (SELECT MAX(ano_cerimonia) FROM indicados_ao_oscar);

-- JOIN (se tivesse múltiplas tabelas)
SELECT a.*, b.* FROM tabela_a a
INNER JOIN tabela_b b ON a.id = b.id;

-- UPDATE
UPDATE indicados_ao_oscar
SET nome_filme = 'Novo Nome'
WHERE id_registro = 123;

-- INSERT
INSERT INTO indicados_ao_oscar (ano_filmagem, ano_cerimonia, categoria, nome_indicado, nome_filme, vencedor)
VALUES (2024, 2025, 'BEST PICTURE', 'Nome', 'Filme', FALSE);

-- DELETE
DELETE FROM indicados_ao_oscar WHERE id_registro = 123;

-- CREATE INDEX
CREATE INDEX idx_nome ON indicados_ao_oscar(nome_indicado);

-- CREATE VIEW
CREATE VIEW vencedores AS
SELECT * FROM indicados_ao_oscar WHERE vencedor = TRUE;
```

Boa sorte! 🎓
