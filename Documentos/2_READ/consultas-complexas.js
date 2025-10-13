// Buscar todos os médicos que tenham "Infectologia" como especialidade e que tenham status 1 ou 2
db.medicos.find({
  especialidades: "Infectologia",
  status: {
    $in: [1, 2] // Operador $in para buscar valores em um array
  }
});

// Buscar médicos com status 1 e especialidade "Infectologia" ou "Cardiologia"
db.medicos.find({
  $and: [{ // Operador $and para combinar condições
    status: 1,
  }, {
    $or: [{
      especialidades: "Infectologia"
    }, {
      especialidades: "Cardiologia"
    }]
  }]
});

// Buscar todos os médicos e ordernar por nome
db.medicos.find().sort({
  nome: 1
});

// Buscar todos os médicos e ordernar por nome de forma decrescente
db.medicos.find().sort({
  nome: -1
});

// Buscar todos os médicos e ordernar por nome e especialidade
db.medicos.find().sort({
  nome: 1,
  especialidades: 1
});

//////////////////////////////////
//////////////////////////////////
//////////////////////////////////

// A diferença entre countDocuments e estimatedDocumentCount é que o primeiro é mais preciso, mas mais lento, enquanto o segundo é mais rápido, mas menos preciso.

// Contar a quantidade de médicos
db.medicos.countDocuments();

// Contar a quantidade de médicos com status 1
db.medicos.countDocuments({
  status: 1
});

// Contar a quantidade de médicos
db.medicos.estimatedDocumentCount();

//////////////////////////////////
//////////////////////////////////
//////////////////////////////////

// Buscar e ordernar por nome e especialidade e limitar a 5 registros
db.medicos.find().sort({
  nome: 1,
  especialidades: 1
}).limit(5); 

// Buscar e ordernar por nome e especialidade e limitar a 5 registros e pular 5 registros
db.medicos.find().sort({
  nome: 1,
  especialidades: 1
}).limit(5).skip(5);

// Buscar enfermeiros com altura maior que 1.70
db.enfermeiros.find({
  altura: {
    $gt: 1.70 // gt = greater than (maior que)
  }
});

// Buscar enfermeiros que nasceram antes de 1995
db.enfermeiros.find({
  data_nascimento: {
    $lt: ISODate("1995-01-01") // lt = less than (menor que)
  }
});

// Buscar e ordernar por data de nascimento dentro de um determinado intervalo
db.enfermeiros.find({
  data_nascimento: {
    $gte: ISODate("1990-01-01"),
    $lte: ISODate("1995-01-01")
  }
});

// Buscar uma consulta pelo id e encontrar o médico relacionado
// O método aggregate() é utilizado para realizar operações de agregação no MongoDB.
// A operação de agregação $lookup é utilizada para realizar junções entre coleções no MongoDB.
db.consultas.aggregate([{
  $match: { // Filtra os documentos da coleção de consultas
    _id: ObjectId("68ed00f67d36afd851de669c") // Filtra pelo id da consulta
  }
}, {
  $lookup: { // Realiza a junção com a coleção de médicos
    from: "medicos",         // Buscar na Coleção de médicos
    localField: "medico_id", // Campo da coleção de consultas
    foreignField: "_id",     // Campo da coleção de médicos (Equivalente ao campo medico_id da coleção de consultas)
    as: "medico"              // Nome do campo que será criado na coleção de consultas
  }
}]);

// Buscar uma consulta pelo id e encontrar o médico e o paciente relacionado
db.consultas.aggregate([{
  $match: {
    _id: ObjectId("66e96b2076efecbc5e470c2a")
  }
}, {
  $lookup: {
    from: "medicos",
    localField: "medico_id",
    foreignField: "_id",
    as: "medico"
  }
}, {
  $lookup: {
    from: "pacientes",
    localField: "paciente_id",
    foreignField: "_id",
    as: "paciente"
  }
}]);

// Consultar o valor da consulta do paciente Paulo Santos.
// Dessa vez, o valor da consulta é um campo do documento de consulta, e não do paciente.
// A expressão "valor": 1 no segundo argumento da função find() indica que apenas o campo "valor" deve ser retornado.
db.consultas.find({
  paciente_id: ObjectId("8a24h1b5d9931b5b00ajhs3b")
}, {
  valor: 1
}).pretty();

// Consultar as somas dos valores das consultas de cada paciente.
// O método aggregate() é utilizado para realizar operações de agregação no MongoDB.
// A operação de agregação $group é utilizada para agrupar os documentos de uma coleção.
// A operação $sum é utilizada para somar os valores dos documentos agrupados.

db.consultas.aggregate([{
  $group: { // Agrupa os documentos
      _id: "$paciente_id", // Agrupa pelo campo paciente_id
      total: { // Cria um campo total
          $sum: "$valor" // Soma os valores dos documentos agrupados
      }
  }
}]);