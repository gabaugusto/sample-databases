# Desafio: O Multiverso Precisa de Organização!

O **Multiverso Nerd** entrou em colapso.  
Os portais entre universos se abriram e **personagens de mundos diferentes estão misturados** em uma base de dados completamente confusa:  
nomes duplicados, franquias desorganizadas, campos escritos de forma diferente e até espécies misteriosas mal registradas!

O **Conselho Supremo da Galáxia** (você 👀) foi convocado para **restaurar a ordem no banco de dados interdimensional**.

Seu objetivo é aplicar seus poderes de **higienização** e **normalização de dados** para reconstruir o equilíbrio nerd do universo dos dados.

---

## Objetivos do Desafio

Há dois arquivos neste repositório com **75 registros** de personagens, criaturas e heróis do mundo nerd. Que devem ser higienizados e normalizados em uma nova coleção chamada **`universo_nerd`**.

---

Exemplos de dados inconsistentes:

```json
{
  "_id": 1,
  "Name": "tony stark",
  "alias": ["Ironman", "Iron Man", null],
  "universe": "Marvel",
  "first_appearance": "1963 (Tales of suspense #39)",
  "powerLevel": "95",
  "equipment": ["armor", "AI assistant", "money", "ARMOR"],
  "species": "Human ",
  "movies": "Iron Man 1, Iron Man 2, Avengers, Avengers: Endgame",
  "debut_year": "Nineteen Sixty Three"
},
{
  "_id": 2,
  "char_name": "Darth vader",
  "Universe": "StarWars",
  "First_Appearance": "Star wars episode iv",
  "power_level": 88,
  "equipment": "lightsaber, armor, force",
  "species": "Human (cyborg)",
  "movies": ["A New Hope", "Empire Strikes Back", "Return of the Jedi"],
  "debut_year": 1977
},
{
  "_id": 3,
  "nome": "harry potter",
  "Alias": "The Boy Who Lived",
  "universe": "Wizarding world ",
  "first_appearance": null,
  "PowerLevel": "N/A",
  "equipment": ["wand", "cloak", "owl"],
  "species": "human",
  "movies": ["Sorcerer's stone","Chamber of secrets","prisoner of azkaban"],
  "debut_year": 1997
},
{
  "_id": 4,
  "nome": "Peter Parker",
  "alias": ["Spider-man", "Spiderman"],
  "universe": "Marvel",
  "powerLevel": 89,
  "equipment": "web shooters, costume",
  "species": "Human",
  "movies": null,
  "debut_year": "1962"
},
{
  "_id": 5,
  "Nome": "Master Chief",
  "Alias": ["John-117"],
  "Universe": "HALO",
  "firstAppearance": "Halo Combat Evolved",
  "powerLevel": "100",
  "equipment": ["Mjolnir armor", "Assault rifle", ""],
  "species": "Human",
  "movies": "Halo: Nightfall",
  "debut_year": "2001"
},
{
  "_id": 6,
  "name": "Gandalf the Grey",
  "universe": "Middle-Earth",
  "powerLevel": 93,
  "equipment": "staff, sword, horse",
  "species": "Maia (spirit)",
  "movies": ["The Fellowship of the Ring", "The Two Towers", "The Return of the King"],
  "debut_year": "1954"
},
{
  "_id": 7,
  "char_name": "Batman",
  "universe": "Dc",
  "powerlevel": "85 ",
  "equipment": ["Batsuit","batmobile","money"],
  "species": "Human",
  "movies": ["The Dark Knight","Batman Begins","The Batman"],
  "debut_year": "1939"
},
{
  "_id": 8,
  "char_name": "bat man",
  "universe": "DC comics",
  "power_level": "85",
  "equipment": "batsuit, batmobile, money",
  "species": "human",
  "movies": "The Dark Knight",
  "debut_year": 1939
}
```

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

* O personagem mais poderoso de cada universo;

* O universo com mais personagens registrados;

* Quantos personagens possuem mais de 3 equipamentos.

**Entregas**: 

1. Código de higienizados e normalizados em seu repositório pessoal;
2. Arquivo `nerd_universe_clean.json` com os dados higienizados;
