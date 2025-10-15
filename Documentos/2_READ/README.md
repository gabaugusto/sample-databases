# MongoDB - Operações READ (Consultas)

## 📝 Introdução

As operações **READ** no MongoDB são realizadas principalmente através dos comandos `find()` e `aggregate()`. Estas operações permitem buscar, filtrar, ordenar e transformar documentos de uma coleção.

---

## 🔍 Comando `find()` - Consultas Básicas

### Buscar Todos os Documentos

```javascript
db.medicos.find()
```

### Buscar com Filtro (WHERE em SQL)

```javascript
// Buscar médicos com especialidade específica
db.medicos.find({
  especialidades: "Cardiologia"
})

// Buscar por múltiplos campos
db.medicos.find({
  especialidades: "Cardiologia",
  status: 1
})
```

### Buscar Campos Específicos (SELECT em SQL)

```javascript
// Retornar apenas nome e CRM
db.medicos.find(
  { especialidades: "Cardiologia" },  // Filtro
  { nome: 1, "documentos.CRM": 1 }    // Projeção (1 = incluir)
)

// Excluir campos específicos
db.medicos.find(
  {},
  { endereco: 0, contato: 0 }  // 0 = excluir
)
```

**⚠️ Importante:** Não misture inclusão (1) e exclusão (0) no mesmo `find()`, exceto para `_id`.

---

## 🎯 Operadores de Comparação

| Operador | Descrição | SQL Equivalente | Exemplo |
|----------|-----------|-----------------|---------|
| `$eq` | Igual a | `=` | `{idade: {$eq: 30}}` |
| `$ne` | Diferente de | `!=` | `{status: {$ne: 0}}` |
| `$gt` | Maior que | `>` | `{altura: {$gt: 1.70}}` |
| `$gte` | Maior ou igual | `>=` | `{idade: {$gte: 18}}` |
| `$lt` | Menor que | `<` | `{idade: {$lt: 65}}` |
| `$lte` | Menor ou igual | `<=` | `{idade: {$lte: 65}}` |
| `$in` | Está na lista | `IN` | `{status: {$in: [1, 2]}}` |
| `$nin` | Não está na lista | `NOT IN` | `{cargo: {$nin: ["CEO", "CFO"]}}` |

### Exemplos Práticos

```javascript
// Buscar enfermeiros com altura maior que 1.70
db.enfermeiros.find({
  altura: { $gt: 1.70 }
})

// Buscar pacientes nascidos antes de 1995
db.pacientes.find({
  data_nascimento: { $lt: ISODate("1995-01-01") }
})

// Buscar médicos com status 1 ou 2
db.medicos.find({
  status: { $in: [1, 2] }
})

// Buscar enfermeiros entre 1.60m e 1.80m
db.enfermeiros.find({
  altura: {
    $gte: 1.60,
    $lte: 1.80
  }
})
```

---

## 🔗 Operadores Lógicos

| Operador | Descrição | SQL Equivalente |
|----------|-----------|-----------------|
| `$and` | E lógico | `AND` |
| `$or` | OU lógico | `OR` |
| `$not` | Negação | `NOT` |
| `$nor` | NEM (nenhuma condição verdadeira) | `NOT ... OR NOT ...` |

### Exemplos de `$and`

```javascript
// AND implícito (vírgula separa condições)
db.medicos.find({
  especialidades: "Infectologia",
  status: 1
})

// AND explícito
db.medicos.find({
  $and: [
    { especialidades: "Infectologia" },
    { status: 1 }
  ]
})
```

### Exemplos de `$or`

```javascript
// Buscar médicos com especialidade Infectologia OU Cardiologia
db.medicos.find({
  $or: [
    { especialidades: "Infectologia" },
    { especialidades: "Cardiologia" }
  ]
})
```

### Combinando `$and` e `$or`

```javascript
// Status 1 E (Infectologia OU Cardiologia)
db.medicos.find({
  $and: [
    { status: 1 },
    {
      $or: [
        { especialidades: "Infectologia" },
        { especialidades: "Cardiologia" }
      ]
    }
  ]
})
```

---

## 📝 Operadores de String e Regex

### Busca Parcial com Regex

```javascript
// Buscar médicos cujo nome contém "Carla"
db.medicos.find({
  nome: /Carla/
})

// Case insensitive (ignora maiúsculas/minúsculas)
db.medicos.find({
  nome: /carla/i
})

// Começa com "Dr."
db.medicos.find({
  nome: /^Dr\./
})

// Termina com "Silva"
db.medicos.find({
  nome: /Silva$/
})
```

---

## 🗂️ Ordenação, Limitação e Paginação

### `sort()` - Ordenar Resultados

```javascript
// Ordenar por nome (crescente)
db.medicos.find().sort({ nome: 1 })

// Ordenar por nome (decrescente)
db.medicos.find().sort({ nome: -1 })

// Ordenar por múltiplos campos
db.medicos.find().sort({
  status: 1,      // Primeiro por status (crescente)
  nome: 1         // Depois por nome (crescente)
})
```

**Valores:**
- `1` = Crescente (A-Z, 0-9, menor data para maior)
- `-1` = Decrescente (Z-A, 9-0, maior data para menor)

### `limit()` - Limitar Resultados

```javascript
// Retornar apenas os primeiros 5 médicos
db.medicos.find().limit(5)

// Combinar ordenação e limitação
db.medicos.find()
  .sort({ nome: 1 })
  .limit(5)
```

### `skip()` - Pular Resultados (Paginação)

```javascript
// Pular os primeiros 5 resultados
db.medicos.find().skip(5)

// Paginação: Página 2 (5 resultados por página)
db.medicos.find()
  .sort({ nome: 1 })
  .skip(5)   // Pula os primeiros 5
  .limit(5)  // Retorna os próximos 5
```

**Fórmula para Paginação:**
```javascript
const paginaAtual = 2
const porPagina = 10
const skip = (paginaAtual - 1) * porPagina

db.medicos.find()
  .skip(skip)
  .limit(porPagina)
```

---

## 🔢 Contagem de Documentos

### `countDocuments()` - Contar com Filtro

```javascript
// Contar todos os médicos
db.medicos.countDocuments()

// Contar médicos com status 1
db.medicos.countDocuments({ status: 1 })
```

### `estimatedDocumentCount()` - Estimativa Rápida

```javascript
// Estimativa rápida (sem filtro)
db.medicos.estimatedDocumentCount()
```

**Diferença:**
- `countDocuments()`: Mais preciso, mas mais lento (faz scan completo)
- `estimatedDocumentCount()`: Mais rápido, mas é uma estimativa (usa metadados)

---

## 🎨 Operadores de Array

### `$all` - Todos os elementos devem existir

```javascript
// Médico deve ter TODAS essas especialidades
db.medicos.find({
  especialidades: {
    $all: ["Cardiologia", "Clínica Geral"]
  }
})
```

### `$elemMatch` - Pelo menos um elemento deve satisfazer

```javascript
// Consultas com receitas de Paracetamol com dosagem específica
db.consultas.find({
  receitas: {
    $elemMatch: {
      medicamento: "Paracetamol",
      dosagem: "500mg"
    }
  }
})
```

### `$size` - Tamanho do array

```javascript
// Médicos com exatamente 3 especialidades
db.medicos.find({
  especialidades: { $size: 3 }
})
```

---

## 📊 Framework de Agregação (`aggregate()`)

O **aggregation framework** permite realizar operações complexas de transformação e análise de dados, similar a GROUP BY, JOINs e subconsultas em SQL.

### Estrutura Básica

```javascript
db.colecao.aggregate([
  { estágio1 },
  { estágio2 },
  { estágio3 }
])
```

Cada estágio transforma os documentos e passa o resultado para o próximo estágio.

---

## 🔍 `$match` - Filtrar Documentos

Equivalente ao `WHERE` em SQL ou ao `find()`.

```javascript
// Buscar consultas de um paciente específico
db.consultas.aggregate([
  {
    $match: {
      paciente_id: ObjectId("66e96b0576efecbc5e470c28")
    }
  }
])

// Múltiplas condições
db.consultas.aggregate([
  {
    $match: {
      data: { $gte: ISODate("2024-01-01") },
      valor: { $gt: 100 }
    }
  }
])
```

**Dica:** Use `$match` o mais cedo possível no pipeline para reduzir o número de documentos processados.

---

## 👥 `$group` - Agrupar e Agregar

Equivalente ao `GROUP BY` em SQL.

### Sintaxe Básica

```javascript
db.colecao.aggregate([
  {
    $group: {
      _id: "$campo_agrupamento",  // Campo para agrupar
      total: { $sum: 1 }           // Contador
    }
  }
])
```

### Operadores de Agregação

| Operador | Descrição | SQL Equivalente |
|----------|-----------|-----------------|
| `$sum` | Soma valores | `SUM()` |
| `$avg` | Média | `AVG()` |
| `$min` | Valor mínimo | `MIN()` |
| `$max` | Valor máximo | `MAX()` |
| `$count` | Contar | `COUNT()` |
| `$push` | Criar array com valores | `GROUP_CONCAT()` |
| `$addToSet` | Array com valores únicos | `DISTINCT` + `GROUP_CONCAT()` |
| `$first` | Primeiro valor do grupo | - |
| `$last` | Último valor do grupo | - |

### Exemplos Práticos

#### Somar Valores por Paciente

```javascript
// Total de gastos de cada paciente
db.consultas.aggregate([
  {
    $group: {
      _id: "$paciente_id",           // Agrupar por paciente
      total_gasto: { $sum: "$valor" } // Somar valores
    }
  }
])
```

**Resultado:**
```javascript
{ _id: ObjectId("..."), total_gasto: 450 }
{ _id: ObjectId("..."), total_gasto: 320 }
```

#### Contar Consultas por Médico

```javascript
db.consultas.aggregate([
  {
    $group: {
      _id: "$medico_id",
      total_consultas: { $sum: 1 }  // Contar documentos
    }
  }
])
```

#### Calcular Média de Valores

```javascript
db.consultas.aggregate([
  {
    $group: {
      _id: "$medico_id",
      valor_medio: { $avg: "$valor" }
    }
  }
])
```

#### Agrupar por Múltiplos Campos

```javascript
// Agrupar por médico E mês
db.consultas.aggregate([
  {
    $group: {
      _id: {
        medico: "$medico_id",
        mes: { $month: "$data" }
      },
      total: { $sum: "$valor" }
    }
  }
])
```

#### Criar Arrays com Valores

```javascript
// Listar todos os pacientes de cada médico
db.consultas.aggregate([
  {
    $group: {
      _id: "$medico_id",
      pacientes: { $addToSet: "$paciente_id" }  // Array com IDs únicos
    }
  }
])
```

---

## 🎯 `$project` - Selecionar e Transformar Campos

Equivalente ao `SELECT` em SQL. Permite incluir, excluir ou calcular novos campos.

### Incluir/Excluir Campos

```javascript
db.medicos.aggregate([
  {
    $project: {
      nome: 1,              // Incluir
      especialidades: 1,    // Incluir
      _id: 0                // Excluir
    }
  }
])
```

### Criar Novos Campos Calculados

```javascript
// Criar campo com nome completo
db.pacientes.aggregate([
  {
    $project: {
      nome_completo: {
        $concat: ["$primeiro_nome", " ", "$sobrenome"]
      },
      idade: {
        $subtract: [
          { $year: new Date() },
          { $year: "$data_nascimento" }
        ]
      }
    }
  }
])
```

### Renomear Campos

```javascript
db.medicos.aggregate([
  {
    $project: {
      nome_medico: "$nome",          // Renomear nome para nome_medico
      registro: "$documentos.CRM"    // Trazer CRM para nível raiz
    }
  }
])
```

---

## 🔗 `$lookup` - JOIN entre Coleções

Equivalente ao `JOIN` em SQL. Permite combinar documentos de diferentes coleções.

### Sintaxe Básica

```javascript
{
  $lookup: {
    from: "colecao_destino",      // Coleção a ser "joinada"
    localField: "campo_local",     // Campo da coleção atual
    foreignField: "campo_externo", // Campo da coleção destino
    as: "nome_array_resultado"     // Nome do campo que conterá os resultados
  }
}
```

### Exemplo: Consulta com Médico

```javascript
// Buscar consulta e trazer dados do médico
db.consultas.aggregate([
  {
    $match: {
      _id: ObjectId("66e96b2076efecbc5e470c2a")
    }
  },
  {
    $lookup: {
      from: "medicos",           // Coleção de médicos
      localField: "medico_id",   // Campo na coleção consultas
      foreignField: "_id",       // Campo na coleção medicos
      as: "medico"               // Resultado será array
    }
  }
])
```

**Resultado:**
```javascript
{
  _id: ObjectId("..."),
  data: ISODate("2024-01-15"),
  medico_id: ObjectId("..."),
  valor: 150,
  medico: [  // Array com documento(s) do médico
    {
      _id: ObjectId("..."),
      nome: "Dr. Carlos Silva",
      especialidades: ["Cardiologia"]
    }
  ]
}
```

### Múltiplos `$lookup`

```javascript
// Buscar consulta com médico E paciente
db.consultas.aggregate([
  {
    $match: {
      _id: ObjectId("66e96b2076efecbc5e470c2a")
    }
  },
  {
    $lookup: {
      from: "medicos",
      localField: "medico_id",
      foreignField: "_id",
      as: "medico"
    }
  },
  {
    $lookup: {
      from: "pacientes",
      localField: "paciente_id",
      foreignField: "_id",
      as: "paciente"
    }
  }
])
```

### Transformar Array em Objeto com `$unwind`

O `$lookup` retorna um array. Use `$unwind` para "desempacotar":

```javascript
db.consultas.aggregate([
  {
    $lookup: {
      from: "medicos",
      localField: "medico_id",
      foreignField: "_id",
      as: "medico"
    }
  },
  {
    $unwind: "$medico"  // Transforma array em objeto
  }
])
```

**Antes do `$unwind`:**
```javascript
{ medico: [ { nome: "Dr. Carlos" } ] }
```

**Depois do `$unwind`:**
```javascript
{ medico: { nome: "Dr. Carlos" } }
```

---

## 🎯 `$sort` - Ordenação em Agregação

```javascript
db.consultas.aggregate([
  {
    $group: {
      _id: "$paciente_id",
      total: { $sum: "$valor" }
    }
  },
  {
    $sort: { total: -1 }  // Ordenar por total (decrescente)
  }
])
```

---

## 🔢 `$limit` e `$skip` em Agregação

```javascript
// Top 5 pacientes que mais gastaram
db.consultas.aggregate([
  {
    $group: {
      _id: "$paciente_id",
      total: { $sum: "$valor" }
    }
  },
  { $sort: { total: -1 } },
  { $limit: 5 }
])

// Paginação
db.consultas.aggregate([
  { $sort: { data: -1 } },
  { $skip: 10 },
  { $limit: 10 }
])
```

---

## 🎨 `$addFields` - Adicionar Campos Calculados

Diferente de `$project`, mantém todos os campos existentes e adiciona novos.

```javascript
db.pacientes.aggregate([
  {
    $addFields: {
      idade: {
        $subtract: [
          { $year: new Date() },
          { $year: "$data_nascimento" }
        ]
      }
    }
  }
])
```

---

## 🔍 `$facet` - Múltiplas Agregações em Paralelo

Permite executar múltiplos pipelines de agregação simultaneamente.

```javascript
db.consultas.aggregate([
  {
    $facet: {
      "total_por_medico": [
        { $group: { _id: "$medico_id", total: { $sum: "$valor" } } }
      ],
      "total_por_paciente": [
        { $group: { _id: "$paciente_id", total: { $sum: "$valor" } } }
      ],
      "estatisticas": [
        {
          $group: {
            _id: null,
            media: { $avg: "$valor" },
            max: { $max: "$valor" },
            min: { $min: "$valor" }
          }
        }
      ]
    }
  }
])
```

---

## 💡 Comparação SQL vs MongoDB

| SQL | MongoDB `find()` | MongoDB `aggregate()` |
|-----|------------------|----------------------|
| `SELECT * FROM medicos` | `db.medicos.find()` | `db.medicos.aggregate([])` |
| `WHERE status = 1` | `db.medicos.find({status: 1})` | `{$match: {status: 1}}` |
| `SELECT nome, CRM` | `db.medicos.find({}, {nome: 1, CRM: 1})` | `{$project: {nome: 1, CRM: 1}}` |
| `ORDER BY nome` | `db.medicos.find().sort({nome: 1})` | `{$sort: {nome: 1}}` |
| `LIMIT 10` | `db.medicos.find().limit(10)` | `{$limit: 10}` |
| `GROUP BY` | - | `{$group: {...}}` |
| `JOIN` | - | `{$lookup: {...}}` |
| `COUNT(*)` | `db.medicos.countDocuments()` | `{$group: {_id: null, total: {$sum: 1}}}` |
| `SUM(valor)` | - | `{$group: {_id: null, total: {$sum: "$valor"}}}` |
| `AVG(valor)` | - | `{$group: {_id: null, media: {$avg: "$valor"}}}` |

---

## 🎓 Exemplo Completo: Relatório de Consultas

```javascript
db.consultas.aggregate([
  // 1. Filtrar consultas de 2024
  {
    $match: {
      data: {
        $gte: ISODate("2024-01-01"),
        $lt: ISODate("2025-01-01")
      }
    }
  },

  // 2. Juntar com médicos
  {
    $lookup: {
      from: "medicos",
      localField: "medico_id",
      foreignField: "_id",
      as: "medico"
    }
  },

  // 3. Desempacotar array de médico
  {
    $unwind: "$medico"
  },

  // 4. Juntar com pacientes
  {
    $lookup: {
      from: "pacientes",
      localField: "paciente_id",
      foreignField: "_id",
      as: "paciente"
    }
  },

  // 5. Desempacotar array de paciente
  {
    $unwind: "$paciente"
  },

  // 6. Agrupar por médico
  {
    $group: {
      _id: "$medico._id",
      nome_medico: { $first: "$medico.nome" },
      total_consultas: { $sum: 1 },
      total_faturado: { $sum: "$valor" },
      valor_medio: { $avg: "$valor" }
    }
  },

  // 7. Ordenar por total faturado
  {
    $sort: { total_faturado: -1 }
  },

  // 8. Limitar aos top 10
  {
    $limit: 10
  },

  // 9. Formatar resultado final
  {
    $project: {
      _id: 0,
      medico: "$nome_medico",
      consultas: "$total_consultas",
      faturamento: "$total_faturado",
      ticket_medio: { $round: ["$valor_medio", 2] }
    }
  }
])
```

---

## 📚 Recursos Adicionais

- **Documentação Oficial:** [MongoDB Find](https://docs.mongodb.com/manual/reference/method/db.collection.find/)
- **Aggregation Framework:** [MongoDB Aggregation](https://docs.mongodb.com/manual/aggregation/)
- **Operadores de Query:** [Query Operators](https://docs.mongodb.com/manual/reference/operator/query/)

---

## 🎓 Resumo

- **`find()`**: Consultas simples com filtros e projeções
- **Operadores de comparação**: `$gt`, `$lt`, `$gte`, `$lte`, `$in`, `$nin`
- **Operadores lógicos**: `$and`, `$or`, `$not`, `$nor`
- **`sort()`**, **`limit()`**, **`skip()`**: Ordenação e paginação
- **`aggregate()`**: Pipeline de transformações complexas
- **`$match`**: Filtrar (WHERE)
- **`$group`**: Agrupar e agregar (GROUP BY)
- **`$project`**: Selecionar e transformar campos (SELECT)
- **`$lookup`**: JOIN entre coleções
- **`$unwind`**: Desempacotar arrays
- **`$sort`**, **`$limit`**, **`$skip`**: Ordenação e paginação em agregação

Agora você domina as consultas no MongoDB! 🚀
