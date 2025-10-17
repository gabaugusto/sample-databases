# Desafio: O Multiverso Precisa de Organização!

## Contexto

O **Multiverso Nerd** entrou em colapso.  
Os portais entre universos se abriram e **personagens de mundos diferentes estão misturados** em uma base de dados completamente confusa:  
nomes duplicados, franquias desorganizadas, campos escritos de forma diferente e até espécies misteriosas mal registradas!

O **Conselho Supremo da Galáxia** (você 👀) foi convocado para **restaurar a ordem no banco de dados interdimensional**.

Seu objetivo é aplicar seus poderes de **higienização** e **normalização de dados** para reconstruir o equilíbrio nerd do universo dos dados.

---

## Objetivos do Desafio

Há dois arquivos neste repositório com **50 registros** de personagens, criaturas e heróis do mundo nerd. Que devem ser higienizados e normalizados em uma nova coleção chamada **`universo_nerd`**.

---

O desafio será dividido em **duas etapas**:

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
8. Gere uma nova coleção limpa chamada **`nerd_universe_clean`**.
9. Exporte a coleção limpa para um arquivo JSON chamado `nerd_universe_clean.json` e comite no **seu** repositório.

---

### Etapa 2 — Normalização

Agora que o multiverso foi parcialmente restaurado, é hora de organizar os dados em coleções mais estruturadas.

Crie as seguintes coleções (ou variações delas):

**characters** → informações principais dos personagens;

**universes** → nome, tipo (filmes, HQs, games, animes), origem;

**species** → nome, descrição (humano, alien, elfo, etc.);

**equipment** → equipamentos icônicos dos personagens;

**movies** → principais obras em que o personagem aparece.

Lembre-se de relacionar as coleções usando IDs de referência (universe_id, species_id, etc.)
e de testar seus relacionamentos com o operador `$lookup`.


### Desafio Extra (opcional)

Use seu poder máximo e crie consultas heroicas!

Tente descobrir:

O personagem mais poderoso de cada universo;

O universo com mais personagens registrados;

Quantos personagens possuem mais de 3 equipamentos.

Entregas: 

1. Código de higienizados e normalizados em seu repositório pessoal;
2. Arquivo `nerd_universe_clean.json` com os dados higienizados;
