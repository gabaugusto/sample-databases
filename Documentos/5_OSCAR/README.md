# Oscar - Exercícios MongoDB

Bem-vindo à base de dados do **Oscar**!

O Oscar é a premiação mais prestigiada do cinema mundial, realizada anualmente desde 1929 pela Academia de Artes e Ciências Cinematográficas. Nesta base de dados, você encontrará registros históricos de indicados e vencedores de diversas categorias ao longo de quase 100 anos de história do cinema.

Nestes exercícios, você vai explorar o banco de dados MongoDB do Oscar e responder perguntas que revelam insights fascinantes sobre a história do cinema, tendências de premiação, e momentos marcantes da indústria cinematográfica.

## Dicas Gerais

- **Conversão de Dados**: Use `$toInt`, `$toBool` para converter tipos
- **Arrays**: Use `$addToSet` para valores únicos
- **Datas**: Use `$year` para extrair o ano de campos de data
- **Performance**: Para queries complexas, considere criar índices em campos frequentemente consultados
- **Boa prática**: Sempre teste com `.limit(5)` antes de executar queries que retornam muitos resultados

---

## Avaliação

- **Nível 1-4**: Operações básicas e queries simples
- **Nível 5-8**: Agregações e análise de dados
- **Nível 9-11**: Queries complexas e pensamento analítico
- **Nível 12-14**: Expertise avançada e pensamento estratégico

**Objetivo de aprendizado**: Ao completar todos os níveis, você será capaz de trabalhar com bases de dados históricas complexas, realizar análises estatísticas sofisticadas e extrair insights valiosos de grandes volumes de dados.

---

## Nível 1: Primeiros Passos

### Conhecendo a Base de Dados

**1.1** Quantos registros existem na coleção de indicados ao Oscar?
Exemplo de resposta:

R: 1430 registros
```javascript
db.oscar_indicados.countDocuments();
```

**1.2** Quais são as diferentes categorias de premiação que existem no banco de dados? Liste todas as categorias únicas.

R: 92 registros
Exemplo de resposta:
```javascript
db.oscar_indicados.distinct("categoria");
```

**1.3** Qual foi o primeiro ano de cerimônia do Oscar registrado na base?

**1.4** Qual foi o último ano de cerimônia registrado na base?

**1.5** Quantas cerimônias do Oscar estão registradas no total?

**1.6** Atualize os registros da tabela com os dados do Oscar 2025 e 2026 (pesquise os vencedores e adicione-os).

---

## Nível 2: Explorando Categorias

**2.1** Quantas indicações existem para cada categoria? Agrupe por categoria e ordene da mais frequente para a menos frequente.

**2.2** Qual categoria teve mais indicações ao longo da história do Oscar?

**2.3** Qual categoria teve menos indicações ao longo da história?

**2.4** A partir de que ano a categoria "ACTRESS" deixou de existir? (Dica: procure a última cerimônia com essa categoria)

**2.5** Quais categorias existiam na primeira cerimônia (1928) e não existem mais hoje?

**2.6** Liste todas as categorias que contêm a palavra "DIRECTING" no nome.

---

## Nível 3: Atores e Atrizes Famosos

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

## Nível 4: Vencedores Históricos

**4.1** Quem ganhou o primeiro Oscar para Melhor Atriz (ACTRESS)? Em que ano e por qual filme?

**4.2** Quem ganhou o primeiro Oscar para Melhor Ator (ACTOR)? Em que ano e por qual filme?

**4.3** Quantos vencedores existem ao todo na base de dados?

**4.4** Liste todos os filmes que ganharam o Oscar de Melhor Filme (categoria "OUTSTANDING PICTURE" ou "BEST PICTURE").

**4.5** Quantos filmes diferentes já ganharam o Oscar?

---

## Nível 5: Análise de Indicações

**5.1** Quais atores/atrizes foram indicados mais de uma vez? Liste o nome e o número de indicações.

**5.2** Qual ator ou atriz tem o maior número de indicações na história do Oscar?

**5.3** Quais atores foram indicados mais de 3 vezes mas nunca ganharam?

**5.4** Encontre todos os artistas que foram indicados em categorias diferentes (ex: ator e diretor).

**5.5** Quantos indicados têm exatamente 1 indicação na história?

---

## Nível 6: Análise de Filmes

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

**6.8** Se sim, quantas indicações "Central do Brasil" recebeu?

---

## Nível 7: Análise Temporal

**7.1** Quantas indicações aconteceram por década? Agrupe por década (1920s, 1930s, etc.) e mostre o total.

**7.2** Em qual década houve o maior número de indicações?

**7.3** Como o número de categorias evoluiu ao longo dos anos? Mostre quantas categorias únicas existiam a cada década.

**7.4** Qual foi o ano com o maior número de indicações registradas?

**7.5** Calcule a taxa de crescimento de indicações comparando a primeira década com a última.

---

## Nível 8: Operações de Atualização

**8.1** No campo "vencedor", altere todos os valores "true" (string) para true (booleano) e "false" (string) para false (booleano).

**8.2** Inclua no banco 3 filmes que nunca foram nomeados ao Oscar, mas que você acha que merecem. Use dados fictícios mas realistas.

**8.3** Adicione uma nova categoria chamada "BEST INTERNATIONAL FEATURE FILM" com alguns vencedores recentes (2020-2024).

**8.4** Corrija possíveis erros de digitação nos nomes dos filmes (ex: espaços extras, caracteres especiais desnecessários).

**8.5** Remova todos os registros com valor NULL no campo nome_do_filme.

---

## Nível 9: Questões Históricas e Sociais

### Representatividade

**9.1** Sidney Poitier foi o primeiro ator negro a ser indicado ao Oscar. Em que ano ele foi indicado? Por qual filme?

**9.2** Sidney Poitier ganhou o Oscar nessa indicação?

**9.3** Quantos atores/atrizes negros foram indicados na categoria ACTOR ou ACTRESS antes de 1970?

**9.4** Liste todos os filmes dirigidos por mulheres que ganharam algum Oscar.

### Coincidências

**9.5** Denzel Washington e Jamie Foxx já concorreram ao Oscar no mesmo ano?

**9.6** Se sim, em qual ano e quem ganhou?

**9.7** Encontre casos onde o mesmo filme ganhou Oscar em múltiplas categorias na mesma cerimônia. Mostre o nome do filme e quantas categorias ele venceu.

---

## Nível 10: Análise Avançada

**10.1** Quais filmes ganharam o Oscar de Melhor Filme ("OUTSTANDING PICTURE" ou "BEST PICTURE") e Melhor Diretor na mesma cerimônia?

**10.2** Qual filme recebeu o maior número de indicações em uma única cerimônia?

**10.3** Qual filme teve a maior taxa de conversão (porcentagem de indicações que viraram vitórias)?

**10.4** Encontre atores que foram indicados em anos consecutivos. Liste o nome e os anos.

**10.5** Qual a média de indicações por cerimônia ao longo da história?

**10.6** Identifique "surpresas" - indicados em categorias principais (ACTOR, ACTRESS, BEST PICTURE) cujo filme só teve uma indicação.

---

## Nível 11: Desafios Complexos

**11.1** Crie um ranking dos 10 filmes mais premiados da história (que ganharam mais Oscars).

**11.2** Crie um ranking dos 10 artistas (atores/diretores) mais indicados da história, independente da categoria.

**11.3** Encontre "azarões" - artistas com mais de 5 indicações e 0 vitórias.

**11.4** Qual categoria tem a maior concentração de vitórias (menos vencedores diferentes ao longo do tempo)?

**11.5** Calcule a "competitividade" de cada categoria (média de indicados por cerimônia).

**11.6** Encontre filmes que foram indicados em uma categoria em um ano e ganharam em outra categoria em outro ano.

---

## Nível 12: Casos Práticos

### Cenário 1: Curadoria de Mostra de Cinema

Você está organizando uma mostra de cinema e precisa selecionar filmes.

**12.1** Liste os 20 filmes mais premiados do Oscar para sua mostra.

**12.2** Selecione 5 filmes de cada década (1930s até 2020s) que ganharam pelo menos um Oscar.

**12.3** Crie uma lista de "clássicos esquecidos" - filmes que ganharam Oscars mas são de mais de 50 anos atrás.

### Cenário 2: Análise para Documentário

Você está produzindo um documentário sobre a história do Oscar.

**12.4** Identifique os 5 momentos mais importantes (cerimônias com mais premiações históricas).

**12.5** Liste todos os "primeiros" históricos (primeira mulher a ganhar melhor direção, primeiro ator negro, etc.) - use sua criatividade para encontrar esses marcos.

**12.6** Encontre casos de "injustiça" - filmes/atores muito indicados mas que nunca ganharam.

### Cenário 3: Estatísticas para Apostas

Você trabalha para um site de apostas e precisa de estatísticas.

**12.7** Qual a probabilidade histórica de um filme indicado em 10 categorias ganhar Melhor Filme?

**12.8** Atores que ganharam Melhor Ator tendem a ter quantas indicações antes da primeira vitória?

**12.9** Qual categoria tem os vencedores mais "previsíveis" (mesmo artista/filme ganha múltiplas vezes)?

---

## Nível 13: Queries Criativas

**13.1** Encontre todos os filmes cujo nome começa com "The" e ganharam pelo menos um Oscar.

**13.2** Liste todos os indicados cujo nome contém um sobrenome composto (ex: "Mary-Louise Parker").

**13.3** Encontre todas as cerimônias onde houve empate (múltiplos vencedores na mesma categoria no mesmo ano).

**13.4** Crie uma query que simule uma "loteria" - selecione 5 filmes aleatórios que ganharam Melhor Filme.

**13.5** Encontre padrões nos nomes dos filmes vencedores (ex: quantos têm uma palavra só, duas palavras, etc.).

---

## Desafio Final: Dashboard Completo

**14.1** Crie UMA ÚNICA query de agregação que retorne um dashboard executivo com:
   - Total de indicações
   - Total de cerimônias
   - Total de vencedores
   - Categoria com mais indicações
   - Filme mais premiado
   - Ator/atriz mais indicado(a)
   - Década com mais premiações
   - Número de categorias únicas

---



Bons estudos!
