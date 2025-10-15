# MongoDB - Operações DELETE (Remoção)

## 📝 Introdução

As operações **DELETE** no MongoDB permitem remover documentos de uma coleção. O MongoDB oferece dois métodos principais: `deleteOne()` e `deleteMany()`, além de métodos para remover coleções e bancos de dados inteiros.

⚠️ **ATENÇÃO:** Operações de deleção são **PERMANENTES** e **NÃO PODEM SER DESFEITAS**. Sempre teste seus filtros com `find()` antes de executar `delete()`.

---

## 🗑️ Comandos de Deleção

### `deleteOne()` - Remover um único documento

Remove o **primeiro documento** que corresponder ao filtro.

**Sintaxe:**
```javascript
db.colecao.deleteOne({ filtro })
```

**Exemplo:**
```javascript
db.medicos.deleteOne({
  nome: "Dr. Carlos Pereira"
})
```

**Retorno:**
```javascript
{
  "acknowledged": true,
  "deletedCount": 1  // Quantos documentos foram removidos
}
```

---

### `deleteMany()` - Remover múltiplos documentos

Remove **todos os documentos** que corresponderem ao filtro.

**Sintaxe:**
```javascript
db.colecao.deleteMany({ filtro })
```

**Exemplo:**
```javascript
// Remover todos os médicos inativos
db.medicos.deleteMany({
  status: 0
})
```

**Retorno:**
```javascript
{
  "acknowledged": true,
  "deletedCount": 5  // Quantos documentos foram removidos
}
```

---

## ⚠️ CUIDADOS IMPORTANTES

### 1. **SEMPRE** Teste o Filtro Antes de Deletar

```javascript
// ❌ NUNCA faça isso diretamente
db.medicos.deleteMany({ status: 0 })

// ✅ SEMPRE faça isso primeiro
db.medicos.find({ status: 0 })
// Veja quantos documentos correspondem

// Conte quantos serão afetados
db.medicos.countDocuments({ status: 0 })

// Depois execute o delete
db.medicos.deleteMany({ status: 0 })
```

### 2. Use `deleteOne()` Para Deleções Específicas

```javascript
// ✅ Bom - deleta apenas um documento específico
db.medicos.deleteOne({
  _id: ObjectId("507f1f77bcf86cd799439011")
})

// ⚠️ Cuidado - pode deletar muitos documentos
db.medicos.deleteMany({
  status: 0  // Filtro amplo
})
```

### 3. Cuidado com Filtros Vazios

```javascript
// ❌ MUITO PERIGOSO - deleta TODOS os documentos!
db.medicos.deleteMany({})

// Se quiser realmente deletar tudo, seja explícito
db.medicos.deleteMany({})  // Deleta todos, mas mantém a coleção

// Ou use drop() para remover a coleção inteira
db.medicos.drop()
```

---

## 🎯 Exemplos de Deleção por Filtros

### Deletar por ID

```javascript
db.pacientes.deleteOne({
  _id: ObjectId("507f1f77bcf86cd799439011")
})
```

### Deletar por Campo Específico

```javascript
// Deletar médico por CRM
db.medicos.deleteOne({
  "documentos.CRM": "SP123456"
})

// Deletar pacientes sem convênio
db.pacientes.deleteMany({
  convenio: { $exists: false }
})
```

### Deletar por Comparação

```javascript
// Deletar consultas antigas (antes de 2020)
db.consultas.deleteMany({
  data: { $lt: ISODate("2020-01-01") }
})

// Deletar pacientes com idade < 18
db.pacientes.deleteMany({
  idade: { $lt: 18 }
})
```

### Deletar por Múltiplas Condições

```javascript
// Deletar médicos inativos E sem especialidades
db.medicos.deleteMany({
  $and: [
    { status: 0 },
    {
      $or: [
        { especialidades: { $exists: false } },
        { especialidades: { $size: 0 } }
      ]
    }
  ]
})
```

### Deletar por Valores em Array

```javascript
// Deletar médicos que têm "Pediatria" nas especialidades
db.medicos.deleteMany({
  especialidades: "Pediatria"
})

// Deletar documentos onde array está vazio
db.medicos.deleteMany({
  especialidades: { $size: 0 }
})
```

---

## 🗑️ Remover Coleções e Bancos de Dados

### `drop()` - Remover Coleção Inteira

Remove a coleção completamente, incluindo todos os documentos e índices.

```javascript
db.medicos.drop()
```

**Retorno:**
```javascript
true  // Se sucesso
false // Se coleção não existir
```

**Diferença entre `deleteMany({})` e `drop()`:**

| Operação | `deleteMany({})` | `drop()` |
|----------|------------------|----------|
| Remove documentos | ✅ Sim | ✅ Sim |
| Remove índices | ❌ Não | ✅ Sim |
| Remove coleção | ❌ Não | ✅ Sim |
| Performance | Mais lento | Mais rápido |
| Usa espaço em disco | Sim (temporariamente) | Libera imediatamente |

---

### `dropDatabase()` - Remover Banco de Dados Inteiro

Remove o banco de dados atual, incluindo todas as coleções.

```javascript
db.dropDatabase()
```

**Exemplo:**
```javascript
// Conectar ao banco
use hospital_db

// Deletar o banco inteiro
db.dropDatabase()
```

**Retorno:**
```javascript
{
  "ok": 1,
  "dropped": "hospital_db"
}
```

⚠️ **EXTREMO CUIDADO:** Esta operação é **IRREVERSÍVEL** e deleta **TUDO**.

---

## 🔍 Deletar com Filtros Complexos

### Deletar Documentos Órfãos

```javascript
// Buscar IDs de pacientes válidos
const pacientesValidos = db.pacientes.distinct("_id")

// Deletar consultas de pacientes que não existem mais
db.consultas.deleteMany({
  paciente_id: { $nin: pacientesValidos }
})
```

### Deletar Duplicatas

```javascript
// Encontrar duplicatas (mesmo CPF)
db.pacientes.aggregate([
  {
    $group: {
      _id: "$CPF",
      duplicatas: { $push: "$_id" },
      count: { $sum: 1 }
    }
  },
  {
    $match: { count: { $gt: 1 } }
  }
]).forEach(doc => {
  // Manter apenas o primeiro, deletar os demais
  doc.duplicatas.shift()  // Remove o primeiro da lista
  db.pacientes.deleteMany({
    _id: { $in: doc.duplicatas }
  })
})
```

### Deletar Baseado em Subconsulta

```javascript
// Deletar médicos que não têm consultas
const medicosComConsultas = db.consultas.distinct("medico_id")

db.medicos.deleteMany({
  _id: { $nin: medicosComConsultas },
  status: 0
})
```

---

## 💡 Comparação com SQL

| SQL | MongoDB |
|-----|---------|
| `DELETE FROM medicos WHERE _id = 1` | `db.medicos.deleteOne({_id: 1})` |
| `DELETE FROM medicos WHERE status = 0` | `db.medicos.deleteMany({status: 0})` |
| `DELETE FROM medicos` | `db.medicos.deleteMany({})` |
| `TRUNCATE TABLE medicos` | `db.medicos.drop()` |
| `DROP TABLE medicos` | `db.medicos.drop()` |
| `DROP DATABASE hospital` | `db.dropDatabase()` |

---

## 🎯 Boas Práticas

### 1. Sempre Faça Backup Antes de Deletar em Produção

```bash
# Fazer backup do banco antes de deletar
mongodump --db hospital_db --out /backup/$(date +%Y%m%d)
```

### 2. Use Transações para Deleções Críticas

```javascript
const session = db.getMongo().startSession()
session.startTransaction()

try {
  db.pacientes.deleteOne({ _id: ObjectId("...") }, { session })
  db.consultas.deleteMany({ paciente_id: ObjectId("...") }, { session })

  session.commitTransaction()
} catch (error) {
  session.abortTransaction()
  console.log("Erro ao deletar:", error)
} finally {
  session.endSession()
}
```

### 3. Soft Delete ao Invés de Hard Delete

Em vez de deletar permanentemente, marque como "deletado":

```javascript
// Em vez de:
db.medicos.deleteOne({ _id: ObjectId("...") })

// Considere:
db.medicos.updateOne(
  { _id: ObjectId("...") },
  {
    $set: {
      deletado: true,
      data_delecao: new Date()
    }
  }
)

// Depois, filtre documentos não deletados nas consultas
db.medicos.find({ deletado: { $ne: true } })
```

**Vantagens do Soft Delete:**
- Possibilidade de recuperação
- Auditoria (saber quando foi deletado)
- Manter integridade referencial temporariamente

### 4. Log de Deleções

```javascript
// Antes de deletar, registre em log
const docParaDeletar = db.medicos.findOne({ _id: ObjectId("...") })

db.logs_delecao.insertOne({
  colecao: "medicos",
  documento: docParaDeletar,
  data_delecao: new Date(),
  usuario: "admin"
})

// Depois delete
db.medicos.deleteOne({ _id: ObjectId("...") })
```

---

## 🔍 Verificando Deleções

### Verificar Resultado da Deleção

```javascript
const resultado = db.medicos.deleteMany({ status: 0 })

console.log(resultado.deletedCount)  // Quantos foram deletados
```

### Contar Documentos Antes e Depois

```javascript
// Antes
const antes = db.medicos.countDocuments({ status: 0 })
console.log("Documentos a deletar:", antes)

// Deletar
db.medicos.deleteMany({ status: 0 })

// Depois
const depois = db.medicos.countDocuments({ status: 0 })
console.log("Documentos restantes:", depois)
```

---

## 🚨 Cenários de Emergência

### Deletou Por Engano?

Se você deletou documentos por engano e **não tem backup**:

1. **PARE IMEDIATAMENTE** qualquer outra operação
2. **NÃO ESCREVA** mais dados no banco
3. Entre em contato com DBA/suporte
4. Considere ferramentas de recuperação (complexo, nem sempre funciona)

**Melhor prevenção:** Sempre tenha backups regulares!

### Proteger Contra Deleções Acidentais

```javascript
// Criar regra de validação que impede deleção sem flag
db.runCommand({
  collMod: "medicos",
  validator: {
    $jsonSchema: {
      properties: {
        pode_deletar: {
          bsonType: "bool",
          description: "Flag para permitir deleção"
        }
      }
    }
  }
})

// Agora, para deletar, precisa primeiro marcar
db.medicos.updateOne(
  { _id: ObjectId("...") },
  { $set: { pode_deletar: true } }
)

db.medicos.deleteOne({
  _id: ObjectId("..."),
  pode_deletar: true
})
```

---

## 🎯 Exercícios Práticos

### Exercício 1: Deletar Documento Específico

```javascript
// Delete um paciente específico por CPF (teste com find primeiro!)
db.pacientes.find({ "documentos.CPF": "12345678900" })
db.pacientes.deleteOne({ "documentos.CPF": "12345678900" })
```

### Exercício 2: Limpeza de Dados Antigos

```javascript
// Delete consultas com mais de 5 anos
const cincoAnosAtras = new Date()
cincoAnosAtras.setFullYear(cincoAnosAtras.getFullYear() - 5)

db.consultas.find({ data: { $lt: cincoAnosAtras } })  // Teste
db.consultas.deleteMany({ data: { $lt: cincoAnosAtras } })  // Execute
```

### Exercício 3: Deletar Documentos Incompletos

```javascript
// Delete pacientes sem campos obrigatórios
db.pacientes.find({
  $or: [
    { nome: { $exists: false } },
    { "documentos.CPF": { $exists: false } }
  ]
})  // Teste

db.pacientes.deleteMany({
  $or: [
    { nome: { $exists: false } },
    { "documentos.CPF": { $exists: false } }
  ]
})  // Execute
```

---

## 📚 Recursos Adicionais

- **Documentação Oficial:** [MongoDB Delete](https://docs.mongodb.com/manual/reference/method/db.collection.deleteOne/)
- **Backup e Restore:** [mongodump e mongorestore](https://docs.mongodb.com/manual/reference/program/mongodump/)

---

## 🎓 Resumo

- **`deleteOne()`**: Remove primeiro documento que corresponder
- **`deleteMany()`**: Remove todos os documentos que corresponderem
- **`drop()`**: Remove coleção inteira (mais rápido que deleteMany)
- **`dropDatabase()`**: Remove banco de dados inteiro
- **SEMPRE teste com `find()` antes de deletar**
- **SEMPRE faça backup antes de deleções em produção**
- **Considere soft delete** para operações críticas
- **Deleções são permanentes** e não podem ser desfeitas

---

## ⚠️ Checklist Antes de Deletar

- [ ] Testei o filtro com `find()`?
- [ ] Contei quantos documentos serão afetados?
- [ ] Tenho backup atualizado?
- [ ] Verifiquei se há relacionamentos com outras coleções?
- [ ] Considerei usar soft delete ao invés de hard delete?
- [ ] Estou usando `deleteOne()` se possível?
- [ ] Registrei a operação em log?

Se respondeu **SIM** para tudo, pode prosseguir com segurança! 🛡️

Agora você sabe deletar documentos com segurança no MongoDB! 🚀
