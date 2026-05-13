# Desafio: O Multiverso Precisa de Organização!

O **Multiverso Nerd** entrou em colapso.  
Os portais entre universos se abriram e **personagens de mundos diferentes estão misturados** em uma base de dados completamente confusa:  
nomes duplicados, franquias desorganizadas, campos escritos de forma diferente e até espécies misteriosas mal registradas!

O **Conselho Supremo da Galáxia** (você 👀) foi convocado para **restaurar a ordem no banco de dados interdimensional**.

Seu objetivo é aplicar seus poderes de **higienização** e **normalização de dados** para reconstruir o equilíbrio nerd do universo dos dados.

---

## Objetivos do Desafio

Há dois arquivos neste repositório com **75 registros** de personagens, criaturas e heróis do mundo nerd. Que devem ser higienizados e normalizados em uma nova tabela chamada **`universo_nerd`**.

---

O arquivo conterá:

Uma tabela chamada nerd_items com registros de itens nerds coletados de diferentes universos fictícios. Cada registro pode conter:

* registros com inconsistências reais, como:

* Preços em formatos diferentes (R$, USD, números sem separador);

* Datas em formatos variados (2023-04-10, 10/04/23, 04/2023);

* Campos faltando ou trocados;

* Letras trocadas, maiúsculas aleatórias;

* “universos” misturados (Marvel, Star Wars, Pokémon, etc.);

* Alguns campos numéricos salvos como texto e vice-versa.

```sql
INSERT INTO nerd_items VALUES
(1, 'Sabre d luz azul', 'Star Wrs', 'arma', 'R$1500', '12', 'Sabre com luz LED azul, empunhadura metálica', '2023-04-10', 'JediSupply', 'raro'),
(2, 'Anel do Poder', 'O Senhor dos Aneis', 'artefato', '$999.99', '??', 'forjado em mordor... ou será que não?', '10/04/23', 'Sauron INC', 'lendário'),
(3, 'Pokebola', 'Pokémon', 'Acessorio', '35.00', '100', 'bolinha pra pegar monstrinhos', '04/2023', '', 'comum'),
(4, 'Buster Swrd', 'Final Fantasy', 'arma', 'US$ 1299', '8 unidades', 'espada enorme q o Cloud usa', '12-04-22', 'Shinra', 'raro'),
(5, 'Mjolnir', 'Marvel', 'arma', '2200 reais', '5', 'martelo do thor, mt pesado', '2021/05/03', 'AsgardTools', 'lendário'),
(6, 'Varinha do Harry', 'Harry Poter', 'artefato', 'R$250', '42', 'madeira com pena de fênix', '01.05.2023', 'Ollivanders', 'comum'),
(7, 'Escudo do Capitão', 'marvel', 'Armadura', 'USD4000', '2', 'escudo vibranium original', '2022-11-30', 'StarkIndustries', 'raro'),
(8, 'Tricorder', 'StarTrek', 'tecnologia', '1800R$', '6', 'dispositivo de análise científica portátil', '30-06-21', 'UFP', 'épico'),
(9, 'Chapéu seletor', 'harry potter', 'artefato', 'R$400', 'n/a', 'fala sozinho e escolhe casas', '2023/06/01', 'Hogwarts', 'raro'),
```

---

O desafio será dividido em **etapas**:

### Etapa 0 - EXPLORAR E HIGIENIZAR

1. Execute os comandos abaixo para criar a base original.
2. Observe os problemas (tipos misturados, datas diferentes, valores errados, etc.).
3. Liste as anomalias que encontrar.
4. Crie uma versão “limpa” da tabela (`nerd_items_clean`).  
   - Padronize tipos de dados (preços como DECIMAL, datas como DATE, etc.).
   - Corrija valores inconsistentes (nomes, universos, categorias).
   - Trate valores nulos ou ausentes.
   - Remova duplicatas.

### Etapa 1 — Higienização de Dados

O caos tomou conta da base de dados! Sua primeira missão é **limpar e padronizar** os registros.

Tarefas obrigatórias:

1. Padronize nomes de campos (`Name`, `nome`, `char_name` → `name`);
2. Corrija capitalização e espaços extras (`"tOny stark"` → `"Tony Stark"`);
3. Converta tipos de dados (`"85"` → `85`);
4. Trate valores nulos, vazios ou `"N/A"`;
5. Transforme listas inconsistentes em arrays reais;
6. Unifique universos semelhantes (`"marvel studios"`, `"MARVEL COMICS"` → `"Marvel"`);
7. Elimine duplicidades (como `"Batman"` e `"bat man"`);
8. Gere uma nova base limpa chamada **`nerd_universe_clean`**.
9. Exporte a base limpa para um arquivo chamado `nerd_universe_clean` e comite no **seu** repositório.

---

### Etapa 2 — Normalização

Depois de limpar os dados, você deve propor um **modelo normalizado**
em 3ª Forma Normal (3FN), separando entidades independentes e relacionamentos.

Abaixo está um modelo sugerido, mas você pode propor o seu próprio.

```sql
CREATE TABLE universos (
  id_universo INT PRIMARY KEY AUTO_INCREMENT,
  nome_universo VARCHAR(100) NOT NULL
);
```

### DESAFIOS FINAIS

* Corrija e insira os dados higienizados nas tabelas correspondentes.

* Garanta que os preços estejam padronizados em BRL com duas casas decimais.

* Padronize universos e categorias (ex: “Star wras”, “star wars” → “Star Wars”).

* Converta datas para formato ISO (`YYYY-MM-DD`).

* Utilize JOINs para reconstruir a visão integrada dos produtos após a normalização.

* (Opcional) Crie uma view chamada `vw_nerd_items_final` unindo todas as tabelas.

**Dica**: explore comandos como:
    - TRIM(), UPPER(), LOWER(), REPLACE(), STR_TO_DATE()
    - CAST() e CONVERT()
    - CASE WHEN ... THEN ... END


### Desafio Extra (opcional)

Use seu poder máximo e crie consultas heroicas!

Tente descobrir:

* O personagem mais poderoso de cada universo;

* O universo com mais personagens registrados;

* Quantos personagens possuem mais de 3 equipamentos.

**Entregas**: 

1. Código de higienizados e normalizados em seu repositório pessoal;
2. Arquivo `nerd_universe_clean.json` com os dados higienizados;
