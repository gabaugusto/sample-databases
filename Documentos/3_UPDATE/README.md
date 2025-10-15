# MongoDB - Operações UPDATE (Atualização)

## 📝 Introdução

As operações **UPDATE** no MongoDB permitem modificar documentos existentes em uma coleção. O MongoDB oferece três métodos principais: `updateOne()`, `updateMany()` e `replaceOne()`.

---

## 🔄 Comandos de Atualização

### `updateOne()` - Atualizar um único documento

Atualiza o **primeiro documento** que corresponder ao filtro.

**Sintaxe:**
```javascript
db.colecao.updateOne(
  { filtro },        // Qual documento atualizar
  { operador }       // Como atualizar
)
```

**Exemplo:**
```javascript
db.medicos.updateOne(
  { nome: "Dra. Carla Elizabete" },  // Filtro
  { $set: { nome: "Dra. Carla Bete" } }  // Atualização
)
```

**Retorno:**
```javascript
{
  "acknowledged": true,
  "matchedCount": 1,   // Quantos documentos corresponderam
  "modifiedCount": 1   // Quantos foram modificados
}
```

---

### `updateMany()` - Atualizar múltiplos documentos

Atualiza **todos os documentos** que corresponderem ao filtro.

**Sintaxe:**
```javascript
db.colecao.updateMany(
  { filtro },
  { operador }
)
```

**Exemplo:**
```javascript
db.medicos.updateMany(
  { especialidades: "Infectologia" },
  { $set: { departamento: "Doenças Infecciosas" } }
)
```

---

### `replaceOne()` - Substituir documento inteiro

Substitui **completamente** um documento por outro (exceto o `_id`).

**Sintaxe:**
```javascript
db.colecao.replaceOne(
  { filtro },
  { novo_documento_completo }
)
```

**Exemplo:**
```javascript
db.medicos.replaceOne(
  { _id: ObjectId("507f1f77bcf86cd799439011") },
  {
    nome: "Dr. João Silva",
    CRM: "SP999999",
    especialidades: ["Cardiologia"]
  }
)
```

**⚠️ Atenção:** `replaceOne()` remove todos os campos não especificados no novo documento!

---

## 🎯 Operadores de Atualização

### `$set` - Definir ou Atualizar Campos

Atualiza o valor de um campo ou cria o campo se não existir.

```javascript
// Atualizar nome
db.medicos.updateOne(
  { nome: "Dra. Carla" },
  { $set: { nome: "Dra. Carla Silva" } }
)

// Atualizar múltiplos campos
db.medicos.updateOne(
  { _id: ObjectId("...") },
  {
    $set: {
      nome: "Dr. Pedro Santos",
      status: 1,
      "endereco.cidade": "São Paulo"
    }
  }
)

// Adicionar novo campo
db.medicos.updateOne(
  { nome: "Dr. Carlos" },
  { $set: { email: "carlos@hospital.com" } }
)
```

**Dica:** Use notação de ponto para atualizar campos aninhados: `"endereco.cidade"`.

---

### `$unset` - Remover Campos

Remove um ou mais campos do documento.

```javascript
// Remover um campo
db.medicos.updateOne(
  { nome: "Dra. Carla" },
  { $unset: { "documentos.Passaporte": "" } }
)

// Remover múltiplos campos
db.pacientes.updateOne(
  { _id: ObjectId("...") },
  {
    $unset: {
      convenio: "",
      observacoes: ""
    }
  }
)
```

**Nota:** O valor passado para `$unset` é irrelevante (pode ser `""`, `1`, `true`). O campo será removido de qualquer forma.

---

### `$inc` - Incrementar Valores Numéricos

Incrementa (ou decrementa) um valor numérico.

```javascript
// Incrementar idade em 1
db.pacientes.updateOne(
  { nome: "João" },
  { $inc: { idade: 1 } }
)

// Decrementar (usar valor negativo)
db.produtos.updateOne(
  { nome: "Medicamento X" },
  { $inc: { estoque: -5 } }
)

// Incrementar múltiplos campos
db.medicos.updateOne(
  { _id: ObjectId("...") },
  {
    $inc: {
      total_consultas: 1,
      anos_experiencia: 1
    }
  }
)
```

**⚠️ Atenção:** Se o campo não existir, `$inc` o criará com o valor especificado.

---

### `$mul` - Multiplicar Valores

Multiplica o valor de um campo por um número.

```javascript
// Dobrar o salário
db.funcionarios.updateOne(
  { nome: "Maria" },
  { $mul: { salario: 2 } }
)

// Aplicar desconto de 10% (multiplicar por 0.9)
db.produtos.updateMany(
  { categoria: "Medicamentos" },
  { $mul: { preco: 0.9 } }
)
```

---

### `$rename` - Renomear Campos

Renomeia um campo.

```javascript
db.medicos.updateMany(
  {},
  { $rename: { "CRM": "registro_profissional" } }
)

// Renomear campo aninhado
db.pacientes.updateMany(
  {},
  { $rename: { "contato.telefone": "contato.celular" } }
)
```

---

### `$min` e `$max` - Atualizar se Menor/Maior

Atualiza o campo apenas se o novo valor for menor (`$min`) ou maior (`$max`) que o atual.

```javascript
// Atualizar apenas se o novo preço for menor
db.produtos.updateOne(
  { nome: "Medicamento X" },
  { $min: { preco: 50 } }
)
// Se preco atual = 60, muda para 50
// Se preco atual = 40, mantém 40

// Atualizar apenas se o novo estoque for maior
db.produtos.updateOne(
  { nome: "Medicamento Y" },
  { $max: { estoque: 100 } }
)
```

---

### `$currentDate` - Definir Data/Hora Atual

Define o valor de um campo para a data/hora atual.

```javascript
db.medicos.updateOne(
  { _id: ObjectId("...") },
  {
    $currentDate: {
      ultima_atualizacao: true,           // Tipo: Date
      timestamp: { $type: "timestamp" }   // Tipo: Timestamp
    }
  }
)
```

---

## 📦 Operadores para Arrays

### `$push` - Adicionar Elemento ao Array

Adiciona um elemento ao final de um array.

```javascript
// Adicionar uma especialidade
db.medicos.updateOne(
  { nome: "Dr. Carlos" },
  { $push: { especialidades: "Geriatria" } }
)

// Adicionar múltiplos elementos com $each
db.medicos.updateOne(
  { nome: "Dr. Carlos" },
  {
    $push: {
      especialidades: {
        $each: ["Geriatria", "Clínica Geral"]
      }
    }
  }
)

// Adicionar e manter array ordenado
db.medicos.updateOne(
  { nome: "Dr. Carlos" },
  {
    $push: {
      especialidades: {
        $each: ["Geriatria"],
        $sort: 1  // Ordenar alfabeticamente
      }
    }
  }
)

// Limitar tamanho do array
db.logs.updateOne(
  { usuario: "joao" },
  {
    $push: {
      acessos: {
        $each: [new Date()],
        $slice: -10  // Manter apenas os últimos 10
      }
    }
  }
)
```

---

### `$addToSet` - Adicionar Elemento Único ao Array

Adiciona um elemento ao array apenas se ele ainda não existir (evita duplicatas).

```javascript
// Adicionar especialidade se não existir
db.medicos.updateOne(
  { nome: "Dr. Carlos" },
  { $addToSet: { especialidades: "Cardiologia" } }
)
// Se "Cardiologia" já existir, não adiciona novamente

// Adicionar múltiplos elementos únicos
db.medicos.updateOne(
  { nome: "Dr. Carlos" },
  {
    $addToSet: {
      especialidades: {
        $each: ["Cardiologia", "Pediatria"]
      }
    }
  }
)
```

---

### `$pop` - Remover Primeiro ou Último Elemento

Remove o primeiro ou último elemento de um array.

```javascript
// Remover último elemento
db.medicos.updateOne(
  { nome: "Dr. Carlos" },
  { $pop: { especialidades: 1 } }
)

// Remover primeiro elemento
db.medicos.updateOne(
  { nome: "Dr. Carlos" },
  { $pop: { especialidades: -1 } }
)
```

**Valores:**
- `1` = Remove o último elemento
- `-1` = Remove o primeiro elemento

---

### `$pull` - Remover Elementos Específicos

Remove todas as ocorrências de um valor específico do array.

```javascript
// Remover "Pediatria" das especialidades
db.medicos.updateOne(
  { nome: "Dr. Carlos" },
  { $pull: { especialidades: "Pediatria" } }
)

// Remover múltiplos valores
db.medicos.updateOne(
  { nome: "Dr. Carlos" },
  {
    $pull: {
      especialidades: { $in: ["Pediatria", "Geriatria"] }
    }
  }
)

// Remover elementos que atendem condição
db.consultas.updateOne(
  { _id: ObjectId("...") },
  {
    $pull: {
      receitas: { dosagem: "500mg" }  // Remove receitas com essa dosagem
    }
  }
)
```

---

### `$pullAll` - Remover Múltiplos Valores Específicos

Remove múltiplos valores específicos de um array.

```javascript
db.medicos.updateOne(
  { nome: "Dr. Carlos" },
  {
    $pullAll: {
      especialidades: ["Pediatria", "Geriatria", "Infectologia"]
    }
  }
)
```

---

### `$` - Operador Posicional (Atualizar Elemento Específico)

Atualiza o primeiro elemento do array que corresponder ao filtro.

```javascript
// Atualizar dosagem de um medicamento específico
db.consultas.updateOne(
  {
    _id: ObjectId("..."),
    "receitas.medicamento": "Paracetamol"  // Filtro no array
  },
  {
    $set: {
      "receitas.$.dosagem": "750mg"  // $ representa o elemento encontrado
    }
  }
)
```

**Nota:** O operador `$` só funciona quando você filtra o array na query.

---

### `$[]` - Atualizar Todos os Elementos do Array

Atualiza todos os elementos de um array.

```javascript
// Adicionar campo "ativo" em todos os elementos
db.medicos.updateOne(
  { nome: "Dr. Carlos" },
  {
    $set: {
      "receitas.$[].ativo": true
    }
  }
)
```

---

### `$[<identifier>]` - Atualizar Elementos Filtrados

Atualiza elementos do array que atendem a uma condição específica.

```javascript
// Atualizar receitas com dosagem > 500mg
db.consultas.updateOne(
  { _id: ObjectId("...") },
  {
    $set: {
      "receitas.$[elem].prescricao_controlada": true
    }
  },
  {
    arrayFilters: [
      { "elem.dosagem": { $gte: "500mg" } }
    ]
  }
)
```

---

## 🎨 Opções de Atualização

### `upsert` - Insert or Update

Se o documento não existir, cria um novo. Se existir, atualiza.

```javascript
db.medicos.updateOne(
  { CRM: "SP123456" },  // Filtro
  {
    $set: {
      nome: "Dr. João Silva",
      especialidades: ["Cardiologia"]
    }
  },
  { upsert: true }  // Opção upsert
)
```

**Comportamento:**
- Se encontrar documento com `CRM: "SP123456"`: **ATUALIZA**
- Se não encontrar: **CRIA** novo documento com todos os campos

---

### `multi` (Descontinuado - Use `updateMany()`)

Em versões antigas do MongoDB, usava-se `{multi: true}`. Hoje use `updateMany()`.

---

## 💡 Comparação com SQL

| SQL | MongoDB |
|-----|---------|
| `UPDATE medicos SET nome = 'João' WHERE _id = 1` | `db.medicos.updateOne({_id: 1}, {$set: {nome: "João"}})` |
| `UPDATE medicos SET status = 1` | `db.medicos.updateMany({}, {$set: {status: 1}})` |
| `UPDATE medicos SET idade = idade + 1` | `db.medicos.updateMany({}, {$inc: {idade: 1}})` |
| `UPDATE ... WHERE NOT EXISTS (INSERT ...)` | `updateOne(..., {upsert: true})` |

---

## 🎯 Exemplos Práticos

### Exemplo 1: Atualizar Dados de Contato

```javascript
db.pacientes.updateOne(
  { CPF: "12345678900" },
  {
    $set: {
      "contato.telefone": "11999999999",
      "contato.email": "novo@email.com"
    }
  }
)
```

### Exemplo 2: Incrementar Número de Consultas

```javascript
db.medicos.updateOne(
  { _id: ObjectId("...") },
  {
    $inc: { total_consultas: 1 },
    $currentDate: { ultima_consulta: true }
  }
)
```

### Exemplo 3: Adicionar Telefone Adicional

```javascript
db.pacientes.updateOne(
  { nome: "João Silva" },
  {
    $push: {
      telefones: "11988888888"
    }
  }
)
```

### Exemplo 4: Atualizar Status em Massa

```javascript
// Ativar todos os médicos inativos
db.medicos.updateMany(
  { status: 0 },
  { $set: { status: 1 } }
)
```

### Exemplo 5: Remover Campo de Todos os Documentos

```javascript
db.pacientes.updateMany(
  {},
  { $unset: { campo_obsoleto: "" } }
)
```

### Exemplo 6: Upsert - Criar ou Atualizar

```javascript
// Registrar última vez que paciente fez consulta
db.historico.updateOne(
  { paciente_id: ObjectId("...") },
  {
    $set: { ultima_consulta: new Date() },
    $inc: { total_consultas: 1 }
  },
  { upsert: true }
)
// Se registro não existir, cria com total_consultas = 1
// Se existir, incrementa o contador
```

---

## ⚠️ Cuidados Importantes

### 1. Sempre Teste com `find()` Antes

```javascript
// ❌ NÃO faça isso diretamente
db.medicos.updateMany(
  { especialidades: "Cardiologia" },
  { $set: { departamento: "Cardio" } }
)

// ✅ Primeiro teste o filtro
db.medicos.find({ especialidades: "Cardiologia" })
// Veja quantos documentos correspondem

// Depois execute o update
db.medicos.updateMany(
  { especialidades: "Cardiologia" },
  { $set: { departamento: "Cardio" } }
)
```

### 2. Use `updateOne()` Quando Possível

```javascript
// ✅ Bom - atualiza apenas um
db.medicos.updateOne(
  { _id: ObjectId("...") },  // Filtro específico
  { $set: { nome: "Dr. João" } }
)

// ⚠️ Cuidado - pode atualizar muitos documentos
db.medicos.updateMany(
  { status: 1 },  // Filtro amplo
  { $set: { departamento: "Geral" } }
)
```

### 3. Não Misture `$set` com Outros Operadores de Forma Errada

```javascript
// ✅ Correto
db.medicos.updateOne(
  { _id: ObjectId("...") },
  {
    $set: { nome: "João" },
    $inc: { consultas: 1 }
  }
)

// ❌ Errado - $set dentro de $inc
db.medicos.updateOne(
  { _id: ObjectId("...") },
  {
    $inc: {
      $set: { consultas: 1 }  // ERRADO!
    }
  }
)
```

### 4. Cuidado com `replaceOne()`

```javascript
// ❌ Cuidado - vai perder todos os outros campos!
db.medicos.replaceOne(
  { _id: ObjectId("...") },
  { nome: "Dr. João" }
)
// Resultado: documento terá APENAS _id e nome

// ✅ Use updateOne com $set
db.medicos.updateOne(
  { _id: ObjectId("...") },
  { $set: { nome: "Dr. João" } }
)
// Resultado: atualiza apenas o nome, mantém outros campos
```

---

## 🔍 Verificando Atualizações

### Verificar Resultado da Atualização

```javascript
const resultado = db.medicos.updateOne(
  { nome: "Dr. Carlos" },
  { $set: { status: 1 } }
)

console.log(resultado.matchedCount)   // Quantos corresponderam ao filtro
console.log(resultado.modifiedCount)  // Quantos foram modificados
console.log(resultado.upsertedId)     // ID do documento criado (se upsert)
```

### Buscar Documento Após Atualização

```javascript
// Atualizar
db.medicos.updateOne(
  { _id: ObjectId("...") },
  { $set: { nome: "Dr. João Silva" } }
)

// Verificar
db.medicos.findOne({ _id: ObjectId("...") })
```

---

## 📚 Recursos Adicionais

- **Documentação Oficial:** [MongoDB Update](https://docs.mongodb.com/manual/reference/method/db.collection.updateOne/)
- **Operadores de Update:** [Update Operators](https://docs.mongodb.com/manual/reference/operator/update/)

---

## 🎓 Resumo

- **`updateOne()`**: Atualiza primeiro documento que corresponder
- **`updateMany()`**: Atualiza todos os documentos que corresponderem
- **`replaceOne()`**: Substitui documento completo
- **`$set`**: Define ou atualiza campos
- **`$unset`**: Remove campos
- **`$inc`**: Incrementa valores numéricos
- **`$push`**: Adiciona elemento ao array
- **`$pull`**: Remove elemento do array
- **`$addToSet`**: Adiciona elemento único ao array
- **`upsert`**: Cria documento se não existir
- **Operador posicional `$`**: Atualiza elemento específico do array

Agora você domina as atualizações no MongoDB! 🚀
